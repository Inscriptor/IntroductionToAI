num(0).
num(s(N)) :- num(N).
plus(0,N,N).
plus(s(M),N,s(Sum)) :- plus(M,N,Sum).