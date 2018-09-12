# Replace all characters equal to the first character of the input, 
# except the first character, with an asterisk (*).

# Example
# Input:
# initialization
# Output:
# in*t*al*zat*on

def processLine(inputLine):
    inputLine.lower()
    char = inputLine[0:1]
    line = char + inputLine[1:].replace(char, '*')

    return line

line = "initialization"
inputLine = str(line)
print(processLine(inputLine))
#passed