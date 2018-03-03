def has23(nums):
  return 2 in nums or 3 in nums

print(has23([2, 5])) #True	
print(has23([4, 3])) #True	
print(has23([4, 5])) #False
print(has23([2, 2])) #True	
print(has23([3, 2])) #True	
print(has23([3, 3])) #True	
print(has23([7, 7])) #False
print(has23([3, 9])) #True	
print(has23([9, 5])) #False