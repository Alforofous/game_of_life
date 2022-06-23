import sys
from random import shuffle

#Run from command line as follows:
#python3 generate.py 0.3 100 100 > 100_grid_30_percent_x
#(so first python3, then file name, then arguments, which are
#ratio of x to dots, line lenght, and finally how many lines,
#then direct the output to whatever filename you want)

args = sys.argv
x_ratio = float(sys.argv[1])
line_lenght = int(sys.argv[2])
lines = int(sys.argv[3])

x_amount = round(line_lenght * lines * x_ratio)
chars = []
for i in range(x_amount):
    chars += 'x'
for i in range(line_lenght * lines - x_amount):
    chars += '.'
shuffle(chars)

stringed = ""
x = 1
for i in chars:
    if x % line_lenght == 0:
        stringed += "\n"
    else:
        stringed += i
    x += 1
print(stringed)
