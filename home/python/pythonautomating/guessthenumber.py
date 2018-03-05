import random

num = random.randint(1,100)
a = 0
tries = 0

while int(a) != num:
    a = input("enter a  number: ")
    print("too high!") if int(a)>num else print("too low")
    tries+=1

print("you found the number in ",tries," tries.")