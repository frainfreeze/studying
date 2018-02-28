def fin_max(*nums):
    maxnum = 0
    for i in nums:
        if i > maxnum:
            maxnum = i
    return maxnum

print(max(1,2,6,4,5,-1))