def make_ends(nums):
  return [nums[0],nums[len(nums)-1]]

print(make_ends([1, 2, 3])) #[1, 3]
print(make_ends([1, 2, 3, 4])) #[1, 4]
print(make_ends([7, 4, 6, 2])) #[7, 2]
print(make_ends([1, 2, 2, 2, 2, 2, 2, 3])) #[1, 3]
print(make_ends([7, 4])) #[7, 4]
print(make_ends([7])) #[7, 7]
print(make_ends([5, 2, 9])) #[5, 9]
print(make_ends([2, 3, 4, 1])) #[2, 1]