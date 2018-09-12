# Replace numbers with "*", letters with "-" and other 
# characters with "?"

# Example
# Input:
# pi=3.14
# Output:
# --?*?**

import re
import string
    
def processLine(inputLine):
    # stackoverflow.com/questions/16060899
    for ch in string.punctuation:
        if ch in inputLine:
            inputLine=inputLine.replace(ch,"?")

    for ch in string.ascii_lowercase:
        if ch in inputLine:
            inputLine=inputLine.replace(ch,"-")

    for ch in string.digits:
        if str(ch) in inputLine:
            inputLine=inputLine.replace(str(ch),"*")

    return inputLine


print(processLine("ai=3.14"))
#passed