# Count the number of occurances of each 
# letter of the input string. Count ONLY LETTERS, 
# converted to LOWERCASE. Skip numbers or any other 
# characters.

# Return a string containing the letters converted to 
# lowercase and sorted alphabetically, and their respective
# counts, separated by newlines, as described. Omit the 
# last newline in the result.

# Input
# String
# Output
# String, composed of a row for each letter of the input string, formatted like this:
# {letter}:{count}{newline}
# Example
# Input:
# Hello world!
# Output:
# d:1
# e:1
# h:1
# l:3
# o:2
# r:1
# w:1

# #This is the example of how to read and process input.
# import fileinput
    
# def processLine(inputLine):
#     #Enter your code here.

# for line in fileinput.input():
#     inputLine = int(line)
#     print(processLine(inputLine))

import re

def processLine(inputLine):
    str1 = re.sub(r'[^a-zA-Z]+', '', ''.join(sorted(inputLine.lower())))
    letters={i:str1.count(i) for i in str1}

    str_list =  []
    for attribute, value in letters.items():
        str_list.append(attribute)
        str_list.append(":")
        str_list.append(str(value))
        str_list.append("\n")
    if len(str_list)!=0:
        del str_list[-1]
    return ''.join(str_list)

print(processLine("Hello world")) 

#not passing for some reason, code works offline tho?!