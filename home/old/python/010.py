def missing_char(str, n):
  return str[:n]+str[n+1:] 

#def missing_char(str, n):
  #front = str[:n]   # up to but not including n
  #back = str[n+1:]  # n+1 through end of string
  #return front + back

print(missing_char('kitten', 1)) #'ktten'
print(missing_char('kitten', 0)) #'itten'
print(missing_char('kitten', 4)) #'kittn'