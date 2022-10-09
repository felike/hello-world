f = open("in.txt")
seq = 0
for x in f:
    print(seq, x, end="")
    seq += 1
f.close()
