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
sys.dont_write_bytecode = True
from datetime import datetime
import zadatak

def zadaca():
    orig_stdout = sys.stdout
    f = open('zadaca.txt', 'w')
    sys.stdout = f

    i = datetime.now()
    print('Domaca zadaca URM - subnetiranje\nTomislav Kucar ' \
        + i.strftime('%Y/%m/%d %H:%M:%S'))

    print('\nZadatak 1')
    print('-' * 10)
    zadatak.zad1()

    print("\n\n\n\nZadatak 2")
    print('-' * 10)
    zadatak.zad2()

    print("\n\n\n\nZadatak 3")
    print('-' * 10)
    zadatak.zad3()

    print("\n\n\n\nZadatak 4")
    print('-' * 10)
    zadatak.zad4()

    sys.stdout = orig_stdout
    f.close()

def run():

    if sys.argv[1] == 'zadaca':
        zadaca()
    elif sys.argv[1] == 'kalkulator':
        print('Unesite ip i subnet u formatu 10.10.10.10/10: ')
        tempN = input()
        n = zadatak.get_network(tempN)
        zadatak.program(n)
    else:
        n = zadatak.get_network(sys.argv[1])
        zadatak.program(n)

if __name__ == '__main__':
    run()
