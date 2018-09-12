def array_front9(nums):
  if len(nums)>3:
    counter = 0
    while counter < 4:
      if nums[counter]==9:
        return True
      counter+=1
  else:
    for i in nums:
      if i == 9:
        return True
  return False

print(array_front9([1, 2, 9, 3, 4])) #True
print(array_front9([1, 2, 3, 4, 9])) #False
print(array_front9([1, 2, 3, 4, 5])) #False

# def array_front9(nums):
#   # First figure the end for the loop
#   end = len(nums)
#   if end > 4:
#     end = 4
  
#   for i in range(end):  # loop over index [0, 1, 2, 3]
#     if nums[i] == 9:
#       return True
#   return False