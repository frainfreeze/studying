#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright (c) 2018 Tomislav Kucar
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import sys, os
try:
    from ipcalc import IP, Network
except ImportError:
    exit('ne mogu ucitati ipcalc modul', 1)

def get_network(network_addr):
    return Network(network_addr)
        
def program(n):
    # ip
    tempIP = str(n)
    tempIP = tempIP[:-3]
    print(('\nIP: ' + tempIP))
    print((str('.'.join([bin(int(x) + 256)[3:] for x in tempIP.split('.')]))))

    # subnet
    tempSub = str(n)
    tempSub = tempSub[-3:]
    print('\nSubnet: ' + tempSub)
    print(n.netmask())
    try:
        tempSub = tempSub[-2:]
        rawBinarySubnet = '1' * int(tempSub) + '0' * (32 - int(tempSub))
        print(str('.'.join([rawBinarySubnet[i:i + 8] for i in range(0,
                  len(rawBinarySubnet), 8)])))
    except: #za subnete <10
        tempSub = tempSub[-1:]
        rawBinarySubnet = '1' * int(tempSub) + '0' * (32 - int(tempSub))
        print(str('.'.join([rawBinarySubnet[i:i + 8] for i in range(0,
                  len(rawBinarySubnet), 8)])))

    # net id, prva i zadnja korisna adresa, broadcast
    print('\nNET ID: ' + str(n.network()))
    print(str('.'.join([bin(int(x) + 256)[3:] for x in
              str(n.network()).split('.')])))
    print('\nFirst: ' + str(n.host_first()))
    print(str('.'.join([bin(int(x) + 256)[3:] for x in
              str(n.host_first()).split('.')])))
    print('\nLast: ' + str(n.host_last()))
    print(str('.'.join([bin(int(x) + 256)[3:] for x in
              str(n.host_last()).split('.')])))
    print('\nBroadcast: ' + str(n.broadcast()))
    print(str('.'.join([bin(int(x) + 256)[3:] for x in
              str(n.broadcast()).split('.')])))

    uredaja = 32 - int(tempSub)
    sumUredaja = pow(uredaja, 2) - 2
    print('\nUredaja: ' + str(uredaja) + '^2-2 = ' + str(sumUredaja))

def zad1():
    foo = 0
    while foo <= 32:
        print('Subnet: /' + str(foo))
        tempNetwork = '10.10.10.10' + '/' + str(foo)
        n = get_network(tempNetwork)
        print(n.netmask())
        rawBinarySubnet = '1' * foo + '0' * (32 - foo)
        print(str('.'.join([rawBinarySubnet[i:i + 8] for i in range(0,len(rawBinarySubnet), 8)])))
        foo += 1

def zad2():
    KlasaA = [9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30] # 10.0.0.0/8  
    KlasaB = [13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30] # 172.16.0.0/12
    KlasaC = [17,18,19,20,21,22,23,24,25,26,27,28,29,30] # 192.168.0.0/16

    print("\nKlasa A")
    for IPadresa in KlasaA:
        podmreza = str(pow(2,(IPadresa-8)))
        racunala = str(pow(2,(32-IPadresa))-2)
        args = (IPadresa,podmreza,racunala)
        text = '''Za 10.0.0.0 /{0} broj podmreža koje možemo dobiti od Klase A privatnih adresa
    koristeći subnet masku /{0} iznosi 2^({0}-8) = {1}
    A svaka od tih podmreža sastoji se od 2^(32-{0})-2 = {2} računala'''.format(*args)
        
        print(text)
        print('-' * 34)

    print("\n\n\nKlasa B")
    for IPadresa in KlasaB:
        podmreza = str(pow(2,(IPadresa-12)))
        racunala = str(pow(2,(32-IPadresa))-2)
        args = (IPadresa,podmreza,racunala)
        text = '''Za 172.16.0.0 /{0} broj podmreža koje možemo dobiti od Klase B privatnih adresa
    koristeći subnet masku /{0} iznosi 2^({0}-12) = {1}
    A svaka od tih podmreža sastoji se od 2^(32-{0})-2 = {2} računala'''.format(*args)
        
        print(text)
        print('-' * 34)

    print("\n\n\nKlasa C")
    for IPadresa in KlasaB:
        podmreza = str(pow(2,(IPadresa-16)))
        racunala = str(pow(2,(32-IPadresa))-2)
        args = (IPadresa,podmreza,racunala)
        text = '''Za 192.168.0.0 /{0} broj podmreža koje možemo dobiti od Klase C privatnih adresa
    koristeći subnet masku /{0} iznosi 2^({0}-16) = {1}
    A svaka od tih podmreža sastoji se od 2^(32-{0})-2 = {2} računala'''.format(*args)
        
        print(text)
        print('-' * 34)

def zad3():
    popisAdresa = [
        '10.50.200.1/14',
        '10.50.200.1/15',
        '10.50.200.1/16',
        '10.50.200.1/18',
        '10.50.200.1/20',
        '10.50.200.1/21',
        '10.50.200.1/22',
        '10.50.200.1/24',
        '10.50.200.1/25',
        '10.50.200.1/26',
        '10.50.200.1/27',
        '10.50.200.1/29',
        '10.50.200.1/30',
        '172.16.0.55/28',
        '172.17.31.44/28',
        '172.16.10.20/29',
        '172.22.23.22/14',
        '172.27.0.1/15',
        '172.31.0.100/21',
        '172.16.200.200/25',
        '172.16.200.200/21',
        '192.168.44.99/26',
        '192.168.101.101/23',
        '192.168.24.24/30',
        '192.168.33.56/25',
        '192.168.33.56/22',
        '192.168.1.11/30',
        '192.168.222.222/29',
        ]
    for IPadresa in popisAdresa:
        spaz = get_network(IPadresa)
        program(spaz)
        print('-' * 34)


def zad4():
    #kasno je i neda mi se smislajti bolje rjesenje nego neko polovicno hardkodiranje
    # plus izgleda kao da sam se jako potrudio :D
    print("1. Zadatak")
    a = get_network("192.168.1.0/26")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("192.168.1.64/26")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    c = get_network("192.168.1.128/27")
    c = str('.'.join([bin(int(x) + 256)[3:] for x in str(c)[:-3].split('.')]))
    print(c)
    d = get_network("192.168.1.160/27")
    d = str('.'.join([bin(int(x) + 256)[3:] for x in str(d)[:-3].split('.')]))
    print(d)
    e = get_network("192.168.1.192/26")
    e = str('.'.join([bin(int(x) + 256)[3:] for x in str(e)[:-3].split('.')]))    
    print(e)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b,c,d,e])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)


    print("\n2. Zadatak")
    a = get_network("192.168.0.0/24")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("192.168.1.0/24")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    c = get_network("192.168.2.0/24")
    c = str('.'.join([bin(int(x) + 256)[3:] for x in str(c)[:-3].split('.')]))
    print(c)
    d = get_network("192.168.3.0/24")
    d = str('.'.join([bin(int(x) + 256)[3:] for x in str(d)[:-3].split('.')]))
    print(d)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b,c,d])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)


    print("\n3. Zadatak")
    a = get_network("192.168.2.0/24")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("192.168.3.0/24")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    c = get_network("192.168.4.0/24")
    c = str('.'.join([bin(int(x) + 256)[3:] for x in str(c)[:-3].split('.')]))
    print(c)
    d = get_network("192.168.5.0/24")
    d = str('.'.join([bin(int(x) + 256)[3:] for x in str(d)[:-3].split('.')]))
    print(d)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b,c,d])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)

    print("\n4. Zadatak")
    a = get_network("10.10.0.0/23")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("10.10.2.0/23")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    c = get_network("10.10.4.0/23")
    c = str('.'.join([bin(int(x) + 256)[3:] for x in str(c)[:-3].split('.')]))
    print(c)
    d = get_network("10.10.6.0/23")
    d = str('.'.join([bin(int(x) + 256)[3:] for x in str(d)[:-3].split('.')]))
    print(d)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b,c,d])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)

    print("\n5. Zadatak")
    a = get_network("172.16.20.128/26")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("172.16.20.192/26")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    c = get_network("172.16.21.0/25")
    c = str('.'.join([bin(int(x) + 256)[3:] for x in str(c)[:-3].split('.')]))
    print(c)
    d = get_network("172.16.21.128/27")
    d = str('.'.join([bin(int(x) + 256)[3:] for x in str(d)[:-3].split('.')]))
    print(d)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b,c,d])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)


    print("\n6. Zadatak")
    a = get_network("172.16.10.0/30")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("172.16.10.4/30")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    c = get_network("172.16.10.8/30")
    c = str('.'.join([bin(int(x) + 256)[3:] for x in str(c)[:-3].split('.')]))
    print(c)
    d = get_network("172.16.10.12/30")
    d = str('.'.join([bin(int(x) + 256)[3:] for x in str(d)[:-3].split('.')]))
    print(d)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b,c,d])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)
    
    print("\n7. Zadatak")
    a = get_network("172.16.10.24/30")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("172.16.10.32/30")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    c = get_network("172.16.10.48/30")
    c = str('.'.join([bin(int(x) + 256)[3:] for x in str(c)[:-3].split('.')]))
    print(c)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b,c])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)

    print("\n8. Zadatak")
    a = get_network("192.168.10.0/24")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("192.168.25.0/24")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    c = get_network("192.168.33.0/24")
    c = str('.'.join([bin(int(x) + 256)[3:] for x in str(c)[:-3].split('.')]))
    print(c)
    d = get_network("192.168.40.0/24")
    d = str('.'.join([bin(int(x) + 256)[3:] for x in str(d)[:-3].split('.')]))
    print(d)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b,c,d])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)

    print("\n9. Zadatak")
    a = get_network("10.20.0.0/18")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("10.20.64.0/18")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)

    print("Summary")
    j = str(os.path.commonprefix([a,b])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)


    print("\n10. Zadatak")
    a = get_network("192.168.2.0/25")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("192.168.2.192/27")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    c = get_network("192.168.2.240/29")
    c = str('.'.join([bin(int(x) + 256)[3:] for x in str(c)[:-3].split('.')]))
    print(c)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b,c])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)

    print("\n11. Zadatak")
    a = get_network("192.168.24.0/22")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("192.168.28.0/22")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)

    print("\n12. Zadatak")
    a = get_network("192.168.64.0/19")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("192.168.128.0/30")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)


    print("\n13. Zadatak")
    a = get_network("192.168.24.0/24")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("192.168.28.0/26")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)

    print("\n14. Zadatak")
    a = get_network("192.168.64.0/25")
    a = str('.'.join([bin(int(x) + 256)[3:] for x in str(a)[:-3].split('.')]))    
    print(a)
    b = get_network("192.168.65.0/26")
    b = str('.'.join([bin(int(x) + 256)[3:] for x in str(b)[:-3].split('.')]))
    print(b)
    
    print("Summary")
    j = str(os.path.commonprefix([a,b])).replace(".", "")
    tmpSubLen = str ( len(j) )
    j = j + '0' * (32-len(j)) #patch the length jer baaca error inace
    print(str('.'.join([j[i:i + 8] for i in range(0,len(j), 8)]))) # rascupaj u 8 komada
    print('.'.join(str(int(j[i:i+8], 2)) for i in range(0, 32, 8)) + '/' + tmpSubLen)
