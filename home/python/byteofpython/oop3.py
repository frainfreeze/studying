class ScoolMember:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def tell(self):
        print("Name: {}  Age: {}".format(self.name,self.age), end=' ')

class Teacher(ScoolMember):
    def __init__(self, name,age,salary):
        ScoolMember.__init__(self,name,age)
        self.salary = salary

    def tell(self):
        ScoolMember.tell(self)
        print('Salary: "{:d}"'.format(self.salary))

class Student(ScoolMember):
    '''Represents a student.'''
    def __init__(self, name, age, marks):
        ScoolMember.__init__(self, name, age)
        self.marks = marks
    
    def tell(self):
        ScoolMember.tell(self)
        print('Marks: "{:d}"'.format(self.marks))
        
t = Teacher('teach a', 40, 10000)
s = Student('Student a', 25, 75)

for member in [t,s]:
    member.tell()