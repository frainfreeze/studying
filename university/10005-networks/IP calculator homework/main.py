#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
from math import sqrt

from datetime import datetime

try:
    from ipcalc import IP, Network
except ImportError:
    exit('ne mogu ucitati ipcalc modul', 1)


def get_network(network_addr):
    if not network_addr:
        print exit('net adresa nije definirana', 1)
    try:
        return Network(network_addr)
    except ValueError, e:
        print exit(e, 1)


def program(n):
    # ip
    tempIP = str(n)
    tempIP = tempIP[:-3]
    print '\nIP: ' + tempIP
    print str('.'.join([bin(int(x) + 256)[3:] for x in tempIP.split('.'
              )]))

    # subnet
    tempSub = str(n)
    tempSub = tempSub[-3:]
    print '\nSubnet: ' + tempSub
    print n.netmask()
    try:
        tempSub = tempSub[-2:]
        rawBinarySubnet = '1' * int(tempSub) + '0' * (32 - int(tempSub))
        print str('.'.join([rawBinarySubnet[i:i + 8] for i in range(0,
                  len(rawBinarySubnet), 8)]))
    except: #za subnete <10
        tempSub = tempSub[-1:]
        rawBinarySubnet = '1' * int(tempSub) + '0' * (32 - int(tempSub))
        print str('.'.join([rawBinarySubnet[i:i + 8] for i in range(0,
                  len(rawBinarySubnet), 8)]))

    # net id, prva i zadnja korisna adresa, broadcast
    print '\nNET ID: ' + str(n.network())
    print str('.'.join([bin(int(x) + 256)[3:] for x in
              str(n.network()).split('.')]))
    print '\nFirst: ' + str(n.host_first())
    print str('.'.join([bin(int(x) + 256)[3:] for x in
              str(n.host_first()).split('.')]))
    print '\nLast: ' + str(n.host_last())
    print str('.'.join([bin(int(x) + 256)[3:] for x in
              str(n.host_last()).split('.')]))
    print '\nBroadcast: ' + str(n.broadcast())
    print str('.'.join([bin(int(x) + 256)[3:] for x in
              str(n.broadcast()).split('.')]))

    uredaja = 32 - int(tempSub)
    sumUredaja = pow(uredaja, 2) - 2
    print '\nUredaja: ' + str(uredaja) + '^2-2 = ' + str(sumUredaja)

def zadaca():
    orig_stdout = sys.stdout
    f = open('zadaca.md', 'w')
    sys.stdout = f

    i = datetime.now()
    print 'Domaca zadaca URM - subnetiranje\nTomislav Kucar ' \
        + i.strftime('%Y/%m/%d %H:%M:%S')

    print '\nZadatak 1'
    print '-' * 10

    foo = 0
    while foo <= 32:
        print 'Subnet: /' + str(foo)
        tempNetwork = '10.10.10.10' + '/' + str(foo)
        n = get_network(tempNetwork)
        print n.netmask()
        rawBinarySubnet = '1' * foo + '0' * (32 - foo)
        print str('.'.join([rawBinarySubnet[i:i + 8] for i in range(0,
                  len(rawBinarySubnet), 8)]))
        foo += 1

    print "\n\n\n\nZadatak 2"
    print '-' * 10
    print 'njah.'

    print "\n\n\n\nZadatak 3"
    print '-' * 10

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
    for bar in popisAdresa:
        spaz = get_network(bar)
        program(spaz)
        print '-' * 34

    print "\n\n\n\nZadatak 4"
    print '-' * 10
    print 'njah.'

    sys.stdout = orig_stdout
    f.close()

def run():

    if sys.argv[1] == 'zadaca':
        zadaca()
    elif sys.argv[1] == 'kalkulator':
        print 'Unesite ip i subnet u formatu 10.10.10.10/10: '
        tempN = raw_input()
        n = get_network(tempN)
        program(n)
    else:
        n = get_network(sys.argv[1])
        program(n)

if __name__ == '__main__':
    run()