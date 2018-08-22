# find mango seller among friends/mutal friends
from collections import deque

graph = {}
graph["you"] = ["alice", "bob", "claire"]
graph["bob"] = ["anuj", "peggy"]
graph["alice"] = ["peggy"]
graph["claire"] = ["thom", "jonny"]
graph["anuj"] = []
graph["peggy"] = []
graph["thom"] = []
graph["jonny"] = []

def person_is_seller(name):
    return name[-1] == 'm'      #if name ends withm m they are mango seller.

def find_mango_seller(name):
    search_queue = deque()          # Creates a new queue
    search_queue += graph["you"]    # Adds all of your neighbors to the search queue
    searched = []                   # keep track of which people you've searched before.
    while search_queue:                 # While the queue isn't empty ...
        person = search_queue.popleft() # ... grabs the first person off the queue
        if person_is_seller(person):    # Checks whether the person is a mango seller
            print(person + " is a mango seller!") # Yes, they're a mango seller.
            return True
        else:
            # No, they aren't. Add all of this person's friends to the search queue.
            search_queue += graph[person]
            searched.append(person) # Mark this person as searched
    return False # If you reached here, no one in the queue was a mango seller.

find_mango_seller("you")