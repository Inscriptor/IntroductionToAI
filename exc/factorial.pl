f(0,1).
f(X,Y) :- X>0,X1 is X-1,f(X1,Y1),Y is Y1*X.

calcfm(X) :- f(X,Y),Y1 is Y mod 10,write(Y1).
calcf(X) :- f(X,Y),write(Y).
calcfn(X) :- f(X,_).

run :- write("This program computes factorial using simple non-optimized recursion"),nl,
    write("Please enter 't' if you want to check computing time, and type 'p' if not"),nl,
    read(Mode),run(Mode).

run(X) :- write("Please enter 'y' if you want to see the result computed, and 'n' if not"),nl,
    read(Wr),
    write("Please enter the number: "),nl,
    read(Num),
    run(X,Wr,Num).

run(t,y,N) :- time(calcf(N)).
run(t,n,N) :- time(calcfn(N)).
run(p,y,N) :- calcf(N).
run(p,n,N) :- calcfn(N).



