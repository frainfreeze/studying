# The binary_search function takes a sorted array and an item. If the
# item is in the array, the function returns its position.
def binary_search(lst, item):
    # keep track of where we are in the lsit
    low = 0
    high = len(lst) -1
    
    # while we arent down to one element...
    while low <= high:
        # check middle element
        mid = (low + high) // 2
        guess = lst[mid]
        if guess == item: # found the item
            return mid
        elif guess > item: # the guess was too high
            high = mid -1
        elif guess < item: # the guess was too low
            low = mid + 1
    
    return None # we didnt find the item
#lets test it
test = [1,2,3,4,5,6,7,8,9,10]
print(binary_search(test, 3))
print(binary_search(test, 8))