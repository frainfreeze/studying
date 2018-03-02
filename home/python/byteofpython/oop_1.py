class Person:
    def __init__(self, name):
        self.name = name

    def sayHi(self):
        print("hi, I'm ", self.name)


p = Person("test")
p.sayHi()