# Replace all adjacent equal elements of the given 
# array with one element.

# Input
# String, an array of numbers separated by space
# Output
# Array with no adjacent duplicates
# Example

# Input:
# 4 4 4 2 8 8 7 
# Output:
# 4 2 8 7

def processLine(inputLine):
    if len(inputLine)==0:
        return None
    
    inputLine = [i for i in inputLine if type(i) == int] 

    result = []
    for num in inputLine:
        if len(result) == 0 or num != result[-1]:
            result.append(num)
    return result

print(processLine([1,2,2,3]))
print(processLine([4,4," ",4,2,"!",8,8,7]))