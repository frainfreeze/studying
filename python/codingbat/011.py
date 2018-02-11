def front_back(str):
  if len(str)<=1:
    return str
  return str[len(str)-1] + str[1:len(str)-1] + str[0]

# str[1:len(str)-1] can be written as str[1:-1]

print front_back('code') #'eodc'
print front_back('a') #'a'
print front_back('ab') #'ba'