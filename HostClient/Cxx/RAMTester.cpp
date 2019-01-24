//------------------------------------------------------------------------
// RAMTester.cpp
//
//
//
// Copyright (c) 2004-2009 Opal Kelly Incorporated
// $Rev$ $Date$
//------------------------------------------------------------------------

#include <iostream>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "okFrontPanelDLL.h"

// Check for a 64-bit environment
#if defined(__amd64__) || defined(_M_X64) || defined(__LP64__) || defined(_LP64)
#define ARCH_X64
#endif

// Check for Microsoft compiler for printf compatibility
#ifdef _MSC_VER
#define LL_FMT_SPEC "I64"
#else
#define LL_FMT_SPEC "ll"
#endif

#define XILINX_CONFIGURATION_FILE  "ramtest.bit"
#define ALTERA_CONFIGURATION_FILE  "ramtest.rbf"
#define BLOCK_SIZE                 512              // bytes
#define READBUF_SIZE               (8*1024*1024)	// 8 MB read buffer size
#define WRITE_SIZE                 (8LL*1024LL*1024LL)
#define READ_SIZE                  (8LL*1024LL*1024LL)    // <= READBUF_SIZE
#define NUM_TESTS                  10
#define MIN(x,y)                   ( (x<y) ? (x) : (y) )

unsigned char *g_buf, *g_rbuf;
long long g_nMems, g_nMemSize;
okTDeviceInfo *g_devInfo;


// From mt_random.cpp
void mt_init();
unsigned long mt_random();


// Exits on critical failure
// Returns true if there is no error
// Returns false on non-critical error
bool
exitOnError(okCFrontPanel::ErrorCode error)
{
	switch (error) {
	case okCFrontPanel::DeviceNotOpen:
		printf("Device no longer available.\n");
		exit(EXIT_FAILURE);
	case okCFrontPanel::Failed:
		printf("Transfer failed.\n");
		exit(EXIT_FAILURE);
	case okCFrontPanel::Timeout:
		printf("   ERROR: Timeout\n");
		return false;
	case okCFrontPanel::TransferError:
		std::cout << "   ERROR: TransferError" << '\n';
		return false;
	case okCFrontPanel::UnsupportedFeature:
		printf("   ERROR: UnsupportedFeature\n");
		return false;
	case okCFrontPanel::DoneNotHigh:
	case okCFrontPanel::CommunicationError:
	case okCFrontPanel::InvalidBitstream:
	case okCFrontPanel::FileError:
	case okCFrontPanel::InvalidEndpoint:
	case okCFrontPanel::InvalidBlockSize:
	case okCFrontPanel::I2CRestrictedAddress:
	case okCFrontPanel::I2CBitError:
	case okCFrontPanel::I2CUnknownStatus:
	case okCFrontPanel::I2CNack:
	case okCFrontPanel::FIFOUnderflow:
	case okCFrontPanel::FIFOOverflow:
	case okCFrontPanel::DataAlignmentError:
	case okCFrontPanel::InvalidParameter:
		std::cout << "   ERROR: " << error << '\n';
		return false;
	default:
		return true;
	}
}


void
writeSDRAM(okCFrontPanel &dev, int mem)
{
	okTDeviceInfo* info = new okTDeviceInfo;
	long long i;
	long ret;

	// Generate some random data
	printf("   Generating random data...\n");
	for (i=0; i<g_nMemSize; i++){
		g_buf[i] = mt_random() % 256;
	}

	// Reset FIFOs
	dev.SetWireInValue(0x00, 0x0004);
	dev.UpdateWireIns();
	dev.SetWireInValue(0x00, 0x0000);
	dev.UpdateWireIns();

	// Enable SDRAM write memory transfers
	dev.SetWireInValue(0x00, 0x0002);
	dev.UpdateWireIns();
	printf("   Writing to memory(%d)...\n", mem);

	for (i=0; i<g_nMemSize/WRITE_SIZE; i++){ 
		if (OK_INTERFACE_USB3 == g_devInfo->deviceInterface) {
			ret = dev.WriteToBlockPipeIn(0x80 + mem, BLOCK_SIZE, WRITE_SIZE, &g_buf[WRITE_SIZE*i]);
		}
		else if ((OK_INTERFACE_PCIE == g_devInfo->deviceInterface) || (OK_INTERFACE_USB2 == g_devInfo->deviceInterface)){
			ret = dev.WriteToPipeIn(0x80+mem, WRITE_SIZE, &g_buf[WRITE_SIZE*i]);
		}
		else{
			ret = okCFrontPanel::UnsupportedFeature;
		}
		if (ret < 0) {
			exitOnError((okCFrontPanel::ErrorCode)ret);
			break;
		}

	}

	dev.UpdateWireOuts();
	
	if (false == dev.IsOpen()) {
		exitOnError(okCFrontPanel::DeviceNotOpen);
	}
}


bool
testSDRAM(okCFrontPanel &dev, int mem)
{
	okTDeviceInfo* info = new okTDeviceInfo;
	long long i, j, k, read;
	long ret;
	bool passed;


	// Reset FIFOs
	dev.SetWireInValue(0x00, 0x0004);
	dev.UpdateWireIns();
	dev.SetWireInValue(0x00, 0x0000);
	dev.UpdateWireIns();

	// Enable SDRAM read memory transfers
	dev.SetWireInValue(0x00, 0x0001);
	dev.UpdateWireIns();
	printf("   Reading from memory(%d)...\n", mem);

	passed = true;
	for (i=0; i<g_nMemSize; ) { 
		read = MIN(READ_SIZE, g_nMemSize-i);
		if (OK_INTERFACE_USB3 == g_devInfo->deviceInterface) {
			ret = dev.ReadFromBlockPipeOut(0xA0 + mem, BLOCK_SIZE, (long)read, g_rbuf);
		}
		else if ((OK_INTERFACE_USB2 == g_devInfo->deviceInterface) || (OK_INTERFACE_PCIE == g_devInfo->deviceInterface)){
			ret = dev.ReadFromPipeOut(0xA0+mem, (long)read, g_rbuf);
		}
		else {
			ret = okCFrontPanel::UnsupportedFeature;
		}

		if (false == exitOnError((okCFrontPanel::ErrorCode)ret)) {
			passed = false;
			break;
		}

		for (j=0; j<read; j++) {
			if (g_buf[i + j] != g_rbuf[j]) {
				for (k=0; k<8; k++)
					printf("[%" LL_FMT_SPEC "u] = 0x%02X / 0x%02X // 0x%02X\n",
					       i+j+k,
						   g_buf[i+j+k],
						   g_rbuf[j+k],
						   g_buf[i+j+k] ^ g_rbuf[j+k]);
				passed = false;
				break;
			}
		}
		if (false == passed)
			break;
		i += read;
	}

	if (false == dev.IsOpen()){
		exitOnError(okCFrontPanel::DeviceNotOpen);
	}

	return(passed);
}


OpalKelly::FrontPanelPtr
initializeFPGA()
{
	// Open the first XEM - try all board types.
	OpalKelly::FrontPanelPtr dev = OpalKelly::FrontPanelDevices().Open();
	if (!dev.get()) {
		printf("Device could not be opened.  Is one connected?\n");
		return(dev);
	}
	
	printf("Found a device: %s\n", dev->GetBoardModelString(dev->GetBoardModel()).c_str());
	g_devInfo = new okTDeviceInfo;
	dev->GetDeviceInfo(g_devInfo);

	// Set memory configuration
	switch (dev->GetBoardModel()) {
		case okCFrontPanel::brdXEM3005:
		case okCFrontPanel::brdXEM3010:
			g_nMemSize = 32*1024*1024;
			g_nMems = 1;
			break;
		case okCFrontPanel::brdXEM3050:
			g_nMemSize = 32*1024*1024;
			g_nMems = 2;
			break;
		case okCFrontPanel::brdXEM5010:
		case okCFrontPanel::brdXEM5010LX110:
			g_nMemSize = 128*1024*1024;
			g_nMems = 2;
			break;
		case okCFrontPanel::brdXEM6320LX130T:
			g_nMemSize = 512*1024*1024;
			g_nMems = 1;
			break;
		case okCFrontPanel::brdXEM7350K70T:
		case okCFrontPanel::brdXEM7350K160T:
		case okCFrontPanel::brdXEM7350K410T:
		case okCFrontPanel::brdXEM7010A200:
		case okCFrontPanel::brdXEM7010A50:
		case okCFrontPanel::brdXEM7305:
			g_nMemSize = 512*1024*1024;
			g_nMems = 1;
			break;
		case okCFrontPanel::brdXEM7360K160T:
		case okCFrontPanel::brdXEM7360K410T:
#ifdef ARCH_X64
			g_nMemSize = 4LL*512LL*1024LL*1024LL;
#else // only use 1 GiB due to 32-bit memory allocation restrictions
			g_nMemSize = 2LL*512LL*1024LL*1024LL;
#endif
			g_nMems = 1;
			break;
		case okCFrontPanel::brdXEM7310A75:
		case okCFrontPanel::brdXEM7310A200:
		case okCFrontPanel::brdXEM7320A75T:
		case okCFrontPanel::brdXEM7320A200T:
			g_nMemSize = 2*512*1024*1024;
			g_nMems = 1;
			break;
		case okCFrontPanel::brdXEM6006LX9:
		case okCFrontPanel::brdXEM6006LX16:
		case okCFrontPanel::brdXEM6006LX25:
		case okCFrontPanel::brdXEM6010LX45:
		case okCFrontPanel::brdXEM6010LX150:
		case okCFrontPanel::brdXEM6310LX45:
		case okCFrontPanel::brdXEM6310LX150:
		case okCFrontPanel::brdXEM6310MTLX45T:
		case okCFrontPanel::brdXEM6110LX45:
		case okCFrontPanel::brdXEM6110LX150:
		case okCFrontPanel::brdXEM6110v2LX45:
		case okCFrontPanel::brdXEM6110v2LX150:
		case okCFrontPanel::brdZEM4310:
			g_nMemSize = 128*1024*1024;
			g_nMems = 1;
			break;
		case okCFrontPanel::brdZEM5305A2:
		case okCFrontPanel::brdZEM5310A4:
			g_nMemSize = 512*1024*1024;
			g_nMems = 1;
			break;
		default:
			printf("Unsupported device.\n");
			dev.reset();
			return(dev);
	}

	// Configure the PLL appropriately
	dev->LoadDefaultPLLConfiguration();

	// Get some general information about the XEM.
	printf("Device firmware version: %d.%d\n", dev->GetDeviceMajorVersion(), dev->GetDeviceMinorVersion());
	printf("Device serial number: %s\n", dev->GetSerialNumber().c_str());
	printf("Device ID string: %s\n", dev->GetDeviceID().c_str());
	
	// Download the configuration file.
	std::string config_filename;
	switch (dev->GetBoardModel()) {
		case okCFrontPanel::brdZEM4310:
		case okCFrontPanel::brdZEM5305A2:
		case okCFrontPanel::brdZEM5305A7:
		case okCFrontPanel::brdZEM5310A4:
		case okCFrontPanel::brdZEM5310A7:
			config_filename = ALTERA_CONFIGURATION_FILE;
			break;
		default:
			config_filename = XILINX_CONFIGURATION_FILE;
			break;
	}
	
	if (okCFrontPanel::NoError != dev->ConfigureFPGA(config_filename)) {
		printf("FPGA configuration failed.\n");
		dev.reset();
		return(dev);
	} 	

	// Check for FrontPanel support in the FPGA configuration.
	if (false == dev->IsFrontPanelEnabled()) {
		printf("FrontPanel support is not enabled.\n");
		dev.reset();
		return(dev);
	}

	printf("FrontPanel support is enabled.\n");

	return(dev);
}


static void
printUsage(char *progname)
{
	printf("Usage: %s\n", progname);
}


int
real_main(int argc, char *argv[])
{
	printf("---- Opal Kelly ---- RAMTester Application v1.0 ----\n");
	printf("FrontPanel DLL loaded. Version: %s\n", okFrontPanelDLL_GetAPIVersionString());


	if (argc > 1) {
		printUsage(argv[0]);
		return(-1);
	}

	// Initialize the FPGA with our configuration bitfile.
	OpalKelly::FrontPanelPtr dev = initializeFPGA();
	if (!dev.get()) {
		printf("FPGA could not be initialized.\n");
		return(-1);
	}

	// Initialize random number generator.
	srand( (unsigned int) time(NULL) );
	mt_init();

	// Allocate some buffer memory.
	g_buf = new unsigned char[g_nMemSize];
	g_rbuf = new unsigned char[READBUF_SIZE];

	// Now perform the memory test.
	int pass=0, fail=0, i, j;
	for (i=0; i<NUM_TESTS; i++) {
		for (j=0; j<g_nMems; j++) {
			writeSDRAM(*dev, j);
			if (true == testSDRAM(*dev, j))
				pass++;
			else
				fail++;
		}

		printf("Passed: %d  Failed: %d\n", pass, fail);
	}

	// Free allocated storage.
	delete [] g_buf;
	delete [] g_rbuf;

	return(0);
}


int
main(int argc, char *argv[])
{
	try {
		return real_main(argc, argv);
	} catch (std::exception const& e) {
		fprintf(stderr, "Error: %s\n", e.what());
	} catch (...) {
		fprintf(stderr, "Error: caught unknown exception.\n");
	}

	return -1;
}
