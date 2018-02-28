def fin_max(*nums):
    '''returns the maximum of given numbers.
        Values must be integers. 
        Python original module: max()'''
    maxnum = 0
    for i in nums:
        if i > maxnum:
            maxnum = i
    return maxnum
