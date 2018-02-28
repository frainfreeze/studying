#btw, zen of python is in ROT13
import this
poem = "".join([this.d.get(c, c) for c in this.s])

# Open for 'w'riting
f = open('this.txt', 'w')

# Write text to file
f.write(poem)

# Close the file
f.close()

# If no mode is specified,
# 'r'ead mode is assumed by default
f = open('poem.txt')

while True:
    line = f.readline()

    # Zero length indicates EOF
    if len(line) == 0:
        break

    # The `line` already has a newline
    # at the end of each line
    # since it is reading from a file.
    print(line, end='')

# close the file
f.close()
