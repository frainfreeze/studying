class Robot:
    """represents robot with a name"""

    population = 0

    def __init__(self,name):
        """initializes the data"""
        self.name = name
        Robot.population += 1 #same as self.__class_.population

    def die(self):
        """I'm dying."""
        Robot.population -= 1
        if Robot.population == 0:
            print("{} was the last robot.".format(self.name))
        else:
            print("there are still {:d} robots left.".format(Robot.population))

    def say_hi(self):
        """greeting by the robot."""
        print("greetings, I'm {}".format(self.name))

    @classmethod # how_many = classmethod(how_many)
    def how_many(cls):
        """prints current population"""
        print(cls.population)

droid1 = Robot("Zz")
droid1.say_hi()
droid1.how_many()

droid2 = Robot("Zz2")
droid2.say_hi()
droid2.how_many()

droid1.die()