def array123(nums):
  for _ in range(len(nums)-2): # -2 so we can check for +2 bellow w/o going out of index
    if nums[_]==1 and nums[_+1]==2 and nums[_+2]==3:
      return True
  return False

print(array123([1, 1, 2, 3, 1])) #True
print(array123([1, 1, 2, 4, 1])) #False
print(array123([1, 1, 2, 1, 2, 3])) #True