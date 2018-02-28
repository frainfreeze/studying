try:
    #In Python 2, you can speed up your pickle 
    #access with cPickle. (In Python3, importing 
    #pickle will automatically use the accelerated 
    # version if it is available.)
    import cPickle as pickle
except:
    import pickle

# The name of the file where we will store the object
shoplistfile = 'shoplist.data'

# The list of things to buy
shoplist = ['apple', 'mango', 'carrot']

# Write to the file
f = open(shoplistfile, 'wb')

# Dump the object to a file
pickle.dump(shoplist, f)
f.close()

# Destroy the shoplist variable
del shoplist

# Read back from the storage
f = open(shoplistfile, 'rb')

# Load the object from the file
storedlist = pickle.load(f)
print(storedlist)
