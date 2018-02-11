def parrot_trouble(talking, hour):
  if talking and (hour<7 or hour>20):
    return True
  return False

def parrot_trouble(talking, hour):
  return (talking and (hour < 7 or hour > 20))


print parrot_trouble(True, 6) #True
print parrot_trouble(True, 7) #False
print parrot_trouble(False, 6) #False