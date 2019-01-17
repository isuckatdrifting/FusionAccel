'''
Host Client for FusionAccel

Functions:
- Send FP32 Caffemodel and configs
- Receive FP32 Output from FPGA

'''
from argparse import ArgumentParser, ArgumentDefaultsHelpFormatter

def parse_args():
    """Parse input arguments
    """

    parser = ArgumentParser(description=__doc__,
                            formatter_class=ArgumentDefaultsHelpFormatter)

    parser.add_argument('input_model_file',
                        help='Input caffemodel file')

    args = parser.parse_args()
    return args

def main():
    args = parse_args()

if __name__ == '__main__':
    main()