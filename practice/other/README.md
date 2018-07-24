## quick navigation
- [coding bat](#codingbat)
- [mojposao hackaton](#mojposao)

## Codingbat
### [List-2 > big_diff](027.py)
Given an array length 1 or more of ints, return the difference between the largest and smallest values in the array. Note: the built-in min(v1, v2) and max(v1, v2) functions return the smaller or larger of two values.

### [List-2 > count_evens](026.py)
Return the number of even ints in the given array. Note: the % "mod" operator computes the remainder, e.g. 5 % 2 is 1.

### [List-1 > make_pi](025.py)
Return an int array length 3 containing the first 3 digits of pi, {3, 1, 4}.

### [List-1 > has23](024.py)
Given an int array length 2, return True if it contains a 2 or a 3.

### [List-1 > make_ends](023.py)
Given an array of ints, return a new array length 2 containing the first and last elements from the original array. The original array will be length 1 or more.

### [22 List-1 > middle_way](022.py)
Given 2 int arrays, a and b, each length 3, return a new array length 2 containing their middle elements.

### [21 Warmup-2 > array123](021.py)
Given an array of ints, return true if the sequence of numbers 1, 2, 3 appears in the array somewhere.

### [20 Warmup-2 > array123](020.py)
Given an array of ints, return True if the sequence of numbers 1, 2, 3 appears in the array somewhere.

### [19 Warmup-2 > array_front9](019.py)
Given an array of ints, return True if one of the first 4 elements in the array is a 9. The array length may be less than 4.

### [018 Warmup-2 > array_count 9](018.py)
Given an array of ints, return the number of 9's in the array.

### [017 Warmup-2 > last2](017.py)
Given a string, return the count of the number of times that a substring length 2 appears in the string and also as the last 2 chars of the string, so "hixxxhi" yields 1 (we won't count the end substring).
```
last2('hixxhi') → 1
last2('xaxxaxaxx') → 1
last2('axxxaaxx') → 2
```

### [016 Warmup-2 > string_splosion ](016.py)
Given a non-empty string like "Code" return a string like "CCoCodCode".
```
string_splosion('Code') → 'CCoCodCode'
string_splosion('abc') → 'aababc'
string_splosion('ab') → 'aab'
```

<br>

### [015 Warmup-2 > string_bits ](015.py)
Given a string, return a new string made of every other char starting with the first, so "Hello" yields "Hlo".
```
string_bits('Hello') → 'Hlo'
string_bits('Hi') → 'H'
string_bits('Heeololeo') → 'Hello'
```

<br>

### [014 Warmup-2 > string_times ](014.py)
Given a string and a non-negative int n, we'll say that the front of the string is the first 3 chars, or whatever is there if the string is less than length 3. Return n copies of the front;
```
front_times('Chocolate', 2) → 'ChoCho'
front_times('Chocolate', 3) → 'ChoChoCho'
front_times('Abc', 3) → 'AbcAbcAbc'
```

<br>

### [013 Warmup-2 > string_times ](013.py)
Given a string and a non-negative int n, return a larger string that is n copies of the original string.
```
string_times('Hi', 2) → 'HiHi'
string_times('Hi', 3) → 'HiHiHi'
string_times('Hi', 1) → 'Hi'
```

<br>

### [012 Warmup-1 > front_back ](012.py)
Given a string, we'll say that the front is the first 3 chars of the string. If the string length is less than 3, the front is whatever is there. Return a new string which is 3 copies of the front.
```
front3('Java') → 'JavJavJav'
front3('Chocolate') → 'ChoChoCho'
front3('abc') → 'abcabcabc'
```

<br>

### [011 Warmup-1 > front_back ](011.py)
Given a string, return a new string where the first and last chars have been exchanged.
```
front_back('code') → 'eodc'
front_back('a') → 'a'
front_back('ab') → 'ba'
```

<br>

### [010 Warmup-1 > missing_char ](010.py)
Given a non-empty string and an int n, return a new string where the char at index n has been removed. The value of n will be a valid index of a char in the original string (i.e. n will be in the range 0..len(str)-1 inclusive).
```
missing_char('kitten', 1) → 'ktten'
missing_char('kitten', 0) → 'itten'
missing_char('kitten', 4) → 'kittn'
```

<br>

### [009 Warmup-1 > not_string python](009.py)
### [009 Warmup-1 > not_string cpp](009.cpp)
Given a string, return a new string where "not " has been added to the front. However, if the string already begins with "not", return the string unchanged.
```
not_string('candy') → 'not candy'
not_string('x') → 'not x'
not_string('not bad') → 'not bad'
```

<br>

### [008 Warmup-1 > near_hundred ](008.py)
Given 2 int values, return True if one is negative and one is positive. Except if the parameter "negative" is True, then return True only if both are negative.
```
pos_neg(1, -1, False) → True
pos_neg(-1, 1, False) → True
pos_neg(-4, -5, True) → True
```

<br>

### [007 Warmup-1 > near_hundred ](007.py)
Given an int n, return True if it is within 10 of 100 or 200. Note: abs(num) computes the absolute value of a number.
```
near_hundred(93) → True
near_hundred(90) → True
near_hundred(89) → False
```

<br>

### [006 Warmup-1 > makes10 ](006.py)
Given 2 ints, a and b, return True if one if them is 10 or if their sum is 10.
```
makes10(9, 10) → True
makes10(9, 9) → False
makes10(1, 9) → True
```

<br>

### [005 Warmup-1 > parrot_trouble ](005.py)
We have a loud talking parrot. The "hour" parameter is the current hour time in the range 0..23. We are in trouble if the parrot is talking and the hour is before 7 or after 20. Return True if we are in trouble.
```
parrot_trouble(True, 6) → True
parrot_trouble(True, 7) → False
parrot_trouble(False, 6) → False
```
<br>

### [004 Warmup-1 > diff21 ](004.py)
Given an int n, return the absolute difference between n and 21, except return double the absolute difference if n is over 21.
```
diff21(19) → 2
diff21(10) → 11
diff21(21) → 0
```

<br>

### [003 Warmup-1 > sum_double ](003.py)
Given two int values, return their sum. Unless the two values are the same, then return double their sum.
```
sum_double(1, 2) → 3
sum_double(3, 2) → 5
sum_double(2, 2) → 8
```

<br>

### [002 Warmup-1 > monkey_trouble ](002.py)
We have two monkeys, a and b, and the parameters a_smile and b_smile indicate if each is smiling. We are in trouble if they are both smiling or if neither of them is smiling. Return True if we are in trouble.
```
monkey_trouble(True, True) → True
monkey_trouble(False, False) → True
monkey_trouble(True, False) → False
```

<br>

### [001 Warmup-1 > sleep_in](001.py)
The parameter weekday is True if it is a weekday, and the parameter vacation is True if we are on vacation. We sleep in if it is not a weekday or we're on vacation. Return True if we sleep in.
```
sleep_in(False, False) → True
sleep_in(True, False) → False
sleep_in(False, True) → True
```

<br>

## mojposao
### mojposao.net online hackaton
01_mojPosao.py - Replace all characters equal to the first character of the input, except the first character, with an asterisk (*).

02_mojPosao.py - Count the number of occurances of each letter of the input string. Count ONLY LETTERS,  converted to LOWERCASE. Skip numbers or any other characters.

Return a string containing the letters converted to lowercase and sorted alphabetically, and their respective counts, separated by newlines, as described. Omit the last newline in the result.

03_mojPosao.py - Replace numbers with "*", letters with "-" and other characters with "?"

04_mojPosao.py - Replace "not ... bad" substring starting with NOT and ending with BAD with "good" in the input. 

05_mojPosao.py - Replace all adjacent equal elements of the given array with one element.

06_mojPosao.py - Return an array of 3 numbers less than 100  whose sum equals 194 and product equals 229824. Sort the numbers ascending.
