def front_back(str):
  if len(str)<=1:
    return str
  return str[len(str)-1] + str[1:len(str)-1] + str[0]

# str[1:len(str)-1] can be written as str[1:-1]

front_back('code') #'eodc'
front_back('a') #'a'
front_back('ab') #'ba'