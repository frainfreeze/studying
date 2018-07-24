# You are in squareland. The world is a square board 
# (side = 10 meters). The buildings are little squres 
# (side = 1 meter). The blocks are placed on the board 
# from top to bottom and stacked on top of other blocks.

# You have to put a large block (side = 5 meters) inside,
# but it may not fit. In that case, you have to remove 
# some of the small blocks, but only as few as necessary 
# to fit the big block.

# Your input is an array of numbers, corresponding to the 
# number of small blocks in each column of the board. 
# Return the minimal number of small blocks to remove to 
# fit the big block.
# https://i.imgur.com/ACmtJpI.png

# Input
# String, an array of numbers separated by a single space.
# Output
# A number. Remember, only the minimal solution correct.
# Example
# Input:
# 10 10 10 10 10 0 0 1 5 1 
# Output:
# 7