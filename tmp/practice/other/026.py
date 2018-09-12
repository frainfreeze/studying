def count_evens(nums):
  x=0
  for i in nums: 
    if i%2==0: 
      x+=1
  return x

print(count_evens([2, 1, 2, 3, 4])) #3
print(count_evens([2, 2, 0])) #3
print(count_evens([1, 3, 5])) #0
print(count_evens([])) #0
print(count_evens([11, 9, 0, 1])) #1
print(count_evens([2, 11, 9, 0])) #2
print(count_evens([2])) #1
print(count_evens([2, 5, 12])) #2