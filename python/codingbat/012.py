def front3(str):
  if len(str)<=3:
    return str+str+str
  return str[0:3] + str[0:3] + str[0:3] 
  
front3('Java') #'JavJavJav'
front3('Chocolate') #'ChoChoCho'
front3('abc') #'abcabcabc'