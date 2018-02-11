def makes10(a, b):
  return (a == 10 or b == 10 or (a+b)==10)

makes10(9, 10) #True
makes10(9, 9) #False
makes10(1, 9) #True