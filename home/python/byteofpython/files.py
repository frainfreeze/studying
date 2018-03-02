#btw, zen of python is in ROT13
import this
poem = "".join([this.d.get(c, c) for c in this.s])

# Open for 'w'riting
with open('this.txt', 'w') as f: #alternative to ty/finally block below
    f.write(poem)
    f.close()

try:
    # If no mode is specified,
    # 'r'ead mode is assumed by default
    f = open('this.txt')

    while True:
        line = f.readline()

        # Zero length indicates EOF
        if len(line) == 0:
            break

        # The `line` already has a newline
        # at the end of each line
        # since it is reading from a file.
        print(line, end='')
        
finally:
    # close the file
    f.close()