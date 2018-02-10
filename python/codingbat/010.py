def missing_char(str, n):
  return str[:n]+str[n+1:] 

def missing_char(str, n):
  front = str[:n]   # up to but not including n
  back = str[n+1:]  # n+1 through end of string
  return front + back