import sys
from pyfiglet import Figlet
from random import choice

def main(argc, argv):
    f = Figlet()
    available_fonts = f.getFonts()
    if argc == 1:
        font = choice(available_fonts)
    elif argc == 3 and sys.argv[1] in ['-f', '--font']:
        if argv[2] in available_fonts:
            font = argv[2]
        else:
            sys.exit('Invalid font')
    else:
        sys.exit('Usage: python ./figlet.py [options]\n\nOptions:\n  -f, --font=<font>\n')

    text = input('Text: ')

    f.setFont(font=font)
    print(f.renderText(text))

    sys.exit()


if __name__ == '__main__':
    argc = len(sys.argv)
    main(argc, sys.argv)
