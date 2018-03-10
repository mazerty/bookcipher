#!/bin/sh -ex

# cleans a potentially failed previous test run
[ -d tmp/ ] && rm -rf tmp/

# creates tmp directory
mkdir tmp

# the cipher being somewhat random, you can't unit-test it in a simple way
# so first we're gonna unit-test the decipher, then test the whole cipher-decipher process to cover everything

# initializes the reference file
prfg test 1000000 > tmp/reference

# tests the decipher
../src/bookcipher decipher tmp/reference results/cipher tmp/decipher
diff results/original tmp/decipher

# tests the cipher-decipher
../src/bookcipher cipher tmp/reference results/original tmp/cipher
../src/bookcipher decipher tmp/reference tmp/cipher tmp/decipher
diff results/original tmp/decipher

# cleans tmp directory
rm -rf tmp
