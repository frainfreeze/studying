class ShortInputException(Exception):
    def __init__(self, length, atleast):
        Exception.__init__(self)
        self.length = length
        self.atleast = atleast

try:
    text = input("enter something: ")
    if(len(text)) < 3:
        raise ShortInputException(len(text),3)

except EOFError:
    print("EOF")

except ShortInputException as ex:
    print("shortinputexeption, input was {} long, expected at least {}".format(ex.length,ex.atleast))

else:
    print("no exception raised")