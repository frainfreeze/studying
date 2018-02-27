def front_times(str, n):
  if n>=0:
    if len(str)<3:
      return str*n
    return str[:3]*n


print(front_times('Chocolate', 2)) #'ChoCho'
print(front_times('Chocolate', 3)) #'ChoChoCho'
print(front_times('Abc', 3)) #'AbcAbcAbc'