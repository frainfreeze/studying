def string_match(a, b):
  small=min(len(a),len(b))
  counter = 0
  
  for _ in range(small-1):
    a_s = a[_:_+2]
    b_s = b[_:_+2]

    if a_s == b_s:
      counter+=1
  
  return counter


print(string_match('xxcaazz', 'xxbaaz')) #3
print(string_match('abc', 'abc')) #2
print(string_match('abc', 'axc')) #0