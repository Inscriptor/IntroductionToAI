d(x,x,1).
d(N,x,0) :- number(N).
d(x**N,x,D) :- _n is N-1,D=N*x**_n.