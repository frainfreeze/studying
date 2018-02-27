def not_string(str):
  if len(str) >= 3 and str[:3] == "not":
    return str
  return "not " + str
  # str[:3] goes from the start of the string up to but not
  # including index 3

print(not_string('candy')) #'not candy'
print(not_string('x')) #'not x'
print(not_string('not bad')) #'not bad'