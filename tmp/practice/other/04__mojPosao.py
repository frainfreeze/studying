# Replace "not ... bad" substring starting with NOT 
# and ending with BAD) with "good" in the input. 

# Input
# Sentence

# Output
# Sentence with replaced substring

# Example
# Input:
# This pizza is not too bad.
# Output:
# This pizza is good.

    
def processLine(inputLine):
  _not = inputLine.find('not')
  bad = inputLine.find('bad')

  if bad > _not:
    inputLine = inputLine.replace(inputLine[_not:(bad+3)], 'good')

  return inputLine

print(processLine("This pizza is not too bad."))

#passed