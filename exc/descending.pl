child(adam,cain).
child(adam,abel).
child(adam,seth).
child(cain,enoch).
child(enoch,irad).
child(irad,mehujael).
child(seth,enos).
child(enos,kenan).
child(kenan,mahalalel).

descend(A,D) :- child(A,D).
descend(A,D) :- child(A,C), descend(C,D).