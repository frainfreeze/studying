def collatz(num):
    if num==1:return 1
    if num%2==0: 
        print(num//2)
        collatz(num//2)
    if num%2!=0:
        print(3*num+1)
        collatz(3*num+1)

collatz(int(input("enter a number: ")))

