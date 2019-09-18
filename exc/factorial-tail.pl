f(N,N,F):-write(F),!.
f(N,N1,F1):- N2 is N1+1,F2 is F1*N2,f(N,N2,F2).

factorial(N):- f(N,1,1).
