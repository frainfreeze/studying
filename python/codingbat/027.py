def big_diff(nums):
  return max(nums)-min(nums)

print(big_diff([10, 3, 5, 6]) )#7	
print(big_diff([7, 2, 10, 9]) )#8	
print(big_diff([2, 10, 7, 2]) )#8	
print(big_diff([2, 10]) )#8	
print(big_diff([10, 2]) )#8	
print(big_diff([10, 0]) )#1OK	
print(big_diff([2, 3]) )#1	
print(big_diff([2, 2]) )#0	
print(big_diff([2]) )#0	
print(big_diff([5, 1, 6, 1, 9, 9]) )#8	
print(big_diff([7, 6, 8, 5]) )#3	
print(big_diff([7, 7, 6, 8, 5, 5, 6])) #