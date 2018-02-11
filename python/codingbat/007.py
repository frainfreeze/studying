def near_hundred(n):
  return ((abs(100 - n) <= 10) or (abs(200 - n) <= 10))

near_hundred(93) #True
near_hundred(90) #True
near_hundred(89) #False