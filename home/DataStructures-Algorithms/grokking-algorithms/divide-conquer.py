# sum of numbers in array using loop
def sum(arr):
    total = 0
    for i in arr:
        total += i
    return total

# sum of numbers in array using recursion
def sum2(arr):
    if arr == []:
        return 0
    return arr[0] + sum(arr[1:])

# recursive function to count the number of items in a list
def count(lst):
    if lst == []:
        return 0
    return 1 + count(lst[1:])

# Find the maximum number in a list using recursion.
def find_max(lst):
    if len(lst) == 0:
        return None
    if len(lst) == 1:
        return lst[0]
    else:
        sub_max = find_max(lst[1:])
        return lst[0] if lst[0] > sub_max else sub_max

print(sum([1,2,3,4,5]))
print(sum2([1,2,3,4,5]))
print(count([1,2,3,'a',4,'b',5]))
print(find_max([1,2,3,4,5]))