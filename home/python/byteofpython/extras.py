# returning tupples
######################################################
def get_Details():
    return(1,'test')

num, text = get_Details()
print()


# a, b = <some expression> interprets the result 
# of the expression as a tuple with two values.
# that means fastest way to switch variabls would be
######################################################
a = 5; b = 3
a,b = b,a
print(a,b)


# lambda takes a parameter followed by a single 
# expression. Lambda becomes the body of the function
# lambda x: 2*x+1 is like def f(x): return 2*x+1 
######################################################
points = [{'x': 2, 'y': 1},{'x': 1, 'y': 3}]
points.sort(key=lambda i: i['x'])
print(points)


# List comprehensions are used to derive a new 
# list from an existing list
######################################################
listone = [2, 3, 4]
listtwo = [2*i for i in listone if i > 2]
print(listtwo)


# the assert statement is used to assert that 
# something is true
######################################################
mylist = ['item']
assert len(mylist) >= 1
mylist.pop()
# assert len(mylist) >= 1


# decorators
# wrapping functions
######################################################
# a decorator receives the method it's wrapping as a variable 'f'
def increment(f):
    # we use arbitrary args and keywords to
    # ensure we grab all the input arguments.
    def wrapped_f(*args, **kw):
        # note we call f against the variables passed into the wrapper,
        # and cast the result to an int and increment .
        return int(f(*args, **kw)) + 1
    return wrapped_f  # the wrapped function gets returned.

# And now we can use it to decorate another method using the '@' symbol:

@increment
def plus(a, b):
    return a + b

result = plus(4, 6)
assert result == 11, "We wrote our decorator wrong!"

# Decorators modify the existing function, and assign the variable to 
# whatever is returned by the decorator. In this case, 
# 'plus' really refers to the result of increment(plus)