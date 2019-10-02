/*
 * ������ �� �������� �������� ��� �������� ��� ������� �� ������������
 * ��������.
 *
*/

% ������� �������� member/2, ������� ��������� 2 ���������: ������� �
% ������ � ���������� True, ���� ������� ���������� � ������ � False �
% ��������� ������. ������� ���������� �������� member(?Elem,?List). ��
% ����� ���������� ��� � �������������� ��������� �������.

memberOfTheList(E,[E|_]).
memberOfTheList(E,[_|T]) :- memberOfTheList(E,T).

% ��������� ������������ �������� - ����� ����� ������. ����������
% ���������� �������� length(?List,?Int), ������� ���������� True, ����
% ������ �������� Int ����� ����� ������ List. ������, ������ ��������
% ����� ����������� �������.

listLen([],0).
listLen([_|T],N) :- listLen(T,M),N is M + 1.


% ��������� �������� - ������������ �������. �������� append/3 ���������
% ��� ���������: ��� ������ � �� ������������. ���� ������ �������� -
% append/2, ������� ��������� ������ ���������� ������ �������, � ������
% - ����������� ������� �� ����� ������. ������ ��� ����, �������. ��
% ��������� ������� ������� ��������� � ����� �����������.

appendLists([],L,L).
appendLists([H|T],L,[H|A1]) :- appendLists(T,L,A1).


% � ������� �������� append ����� ����� �������, ������� � ���������
% ��������� ������. ����������, ���������� ���������� ���������
% prefix/2, sublist/2.

prefixOfList(P,L) :- appendLists(P,_,L).
suffixOfList(S,L) :- appendLists(_,S,L).
sublistOfList(Sub,L) :- suffixOfList(S,L),prefixOfList(Sub,S).


% �������� ������ ���������� �������� ������. ���� ���������� ��������
% last/2. �� ��������� ��� ����������� ��������������.


lastEl([],_) :- !,fail.
lastEl([X],X) :- !.
lastEl([_|T],X) :- lastEl(T,X).


% ��������� ������ (���������� �������� reverse/2).

rev([],[]).
rev([H|T],R) :- rev(T,R1),appendLists(R1,[H],R).


% ����� ����� ���� ��������� ������ � �������������, ����� �����������
% �� ���� ��������� ��������


% �������� � ����������. ����� �������, ���� � ������������� ����������
% - ���������� ���������. �� ��������� O(n^2).

singlePass([],[]) :- !. % � ������ ������ ������������ ������� ��� � ����� ����� (��� ������ ���)
singlePass([H],[H]) :- !. % � ������ �� ������ �������� ���� ��� ���������
singlePass([F,S|Tail],[S|PartlySorted]) :- F>S,!,singlePass([F|Tail],PartlySorted).
singlePass([F,S|Tail],[F|PartlySorted]) :- singlePass([S|Tail],PartlySorted).

bubbleSort(Sorted,Sorted) :- singlePass(Sorted,Passed),Sorted=Passed,!.
bubbleSort(L,Sorted) :- singlePass(L,PartlySorted),!,bubbleSort(PartlySorted,Sorted).


% ������ ���������� ��������

singlePermutation([X,Y|T],[Y,X|T]) :- X>Y,!.
singlePermutation([X|T],[X|T1]) :- singlePermutation(T,T1).
bubble(L,L1) :- singlePermutation(L,L2),!,bubble(L2,L1).
bubble(L,L).


% ����� ������ ���� ���������� ������� ����������


% �������� ��� ������ ������ � �������.

printList([]).
printList([H|T]) :- write(H),write(' '),printList(T).


% ���������� ��������� ������ �������� ����� � ��� ���������� ���������� �������
