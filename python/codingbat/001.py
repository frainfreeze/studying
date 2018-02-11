def sleep_in(weekday, vacation):
  if not weekday or vacation:
    return True
  return False
  # This can be shortened to: return(not weekday or vacation)

### first solution
def sleep_in_1(weekday, vacation):
  if vacation == False and weekday == True:
    return False
  else:
    return True


print sleep_in(False, False) #True
print sleep_in(True, False) #False
print sleep_in(False, True) #True