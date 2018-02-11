def near_hundred(n):
  return ((abs(100 - n) <= 10) or (abs(200 - n) <= 10))

print near_hundred(93) #True
print near_hundred(90) #True
print near_hundred(89) #False