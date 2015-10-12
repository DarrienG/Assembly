Assembly


OLD

# $t1 Max number of chars we can take in
# $t0 Current index of inBuf
# $a3 The character loaded from inBuf
# $a0 obviously being used
# $t8 Holds the address of $a0
# $s6 Index of tabChar (where you at?)
# $t4 Holds the weight of a character val in int after line 79 (ret)


NEW

# $s2 Used as a temp val to hold $ra
# $s0 Pretty sure this is being used as a dup for printing in dump func()
# $t5 Global pointer to inBuf index (already have $t0)
# $s3 Global pointer to index of TOKEN
# $s1 Holds Q0, not sure where to go from here
# $t9 Used to temporarily hold a val from TOKEN and put into tokArray

# $t0, $t1, $t4, $t5 $t8, $t9, $a0, $a3, $s0, $s1, $s2, $s3, $s6, $a0, $a3, 