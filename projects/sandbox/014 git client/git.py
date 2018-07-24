#git client implementation
#todo: unittests, refactor
import os
import sys
import zlib
import hashlib

### helper functions ###
def read_file(path):
    """helper function to read files at given path as bytes"""
    with open(path, 'rb') as f:
        return f.read()

def write_file(path, data):
    """helper function to write data bytes to file at given path"""
    with open(path, 'wb') as f:
        f.write(data)

### git ###
def init(repo): #NOTE: fails if repo exits
    """initialize git repository"""
    os.mkdir(repo)
    os.mkdir(os.path.join(repo, '.git'))
    for name in ['objects','refs','refs/heads']:
        os.mkdir(os.path.join(repo, '.git', name))

    write_file(os.path.join(repo, '.git', 'HEAD'), b'ref: refs/head/master')
    print("Initialized empty Git repository in {}/{}/.git/".format(os.getcwd(),repo))


def hash_object(data, obj_type, write=True):
    """Compute hash of object data of given type and write to object if
    "write" is True. Return SHA-1 object hash as hex string.
    """
    header = '{} {}'.format(obj_type,len(data)).encode()
    full_data = header + b'\x00' + data
    sha1 = hashlib.sha1(full_data).hexdigest()
    if write:
        path = os.path.join('.git', 'objects', sha1[:2], sha1[2:])
        if not os.path.exists(path):
            os.makedirs(os.path.dirname(path)), exist_ok=True)
            write_file(path, zlib.compress(full_data))
    return sha1

if __name__ == '__main__':
    #NOTE: switch to argparse or similar
    if sys.argv[1] == 'init':
        init(sys.argv[2])   