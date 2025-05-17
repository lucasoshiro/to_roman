#!/usr/bin/env python3

def to_roman(n):
    roman_digits = [
        '',
        'i',
        'ii',
        'iii',
        'iv',
        'v',
        'vi',
        'vii',
        'viii',
        'ix',
        'x'
    ]

    roman_dec = 'IVXLCDM  '

    reversed_n = reversed(str(n))

    ivx = zip(roman_dec[::2], roman_dec[1::2], roman_dec[2::2])

    romans = [
        roman_digits[int(alg)].replace('i', i).replace('v', v).replace('x', x)
        for alg, (i, v, x) in zip(reversed_n, ivx)
    ]

    return ''.join(reversed(romans))


if __name__ == '__main__':
    n = int(input('Enter a number: '))
    print(to_roman(n))
