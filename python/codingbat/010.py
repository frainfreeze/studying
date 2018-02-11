def missing_char(str, n):
  return str[:n]+str[n+1:] 

def missing_char(str, n):
  front = str[:n]   # up to but not including n
  back = str[n+1:]  # n+1 through end of string
  return front + back

missing_char('kitten', 1) #'ktten'
missing_char('kitten', 0) #'itten'
missing_char('kitten', 4) #'kittn'