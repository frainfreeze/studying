def string_splosion(str):
  result = ""
  for i in range(len(str)):
    result = result + str[:i+1]
  return result

print string_splosion('Code') #'CCoCodCode'
print string_splosion('abc') #'aababc'
print string_splosion('ab') #'aab'