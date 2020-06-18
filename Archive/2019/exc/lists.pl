/*
 * Задачи на основные операции над списками для разбора на практических
 * занятиях.
 *
*/

% Сначала предикат member/2, который принимает 2 параметра: элемент и
% список и возвращает True, если элемент содержится в списке и False в
% противном случае. Имеется встроенный предикат member(?Elem,?List). Но
% можно определить его и самостоятельно следующим образом.

memberOfTheList(E,[E|_]).
memberOfTheList(E,[_|T]) :- memberOfTheList(E,T).

% Следующая классическая операция - поиск длины списка. Существует
% встроенный предикат length(?List,?Int), который возвращает True, если
% второй параметр Int равен длине списка List. Однако, данный предикат
% можно реализовать вручную.

listLen([],0).
listLen([_|T],N) :- listLen(T,M),N is M + 1.


% Следующая операция - конкатенация списков. Предикат append/3 принимает
% три параметра: два списка и их конкатенацию. Есть другой предикат -
% append/2, который принимает первым параметром список списков, а вторым
% - конкатенцию списков из этого списка. Звучит так себе, конечно. Мы
% реализуем вариант первого предиката с тремя параметрами.

appendLists([],L,L).
appendLists([H|T],L,[H|A1]) :- appendLists(T,L,A1).


% С помощью операции append можно найти префикс, суффикс и подсписок
% заданного списка. Разумеется, существуют встроенные предикаты
% prefix/2, sublist/2.

prefixOfList(P,L) :- appendLists(P,_,L).
suffixOfList(S,L) :- appendLists(_,S,L).
sublistOfList(Sub,L) :- suffixOfList(S,L),prefixOfList(Sub,S).


% Операция поиска последнего элемента списка. Есть встроенный предикат
% last/2. Мы попробуем его реализовать самостоятельно.


lastEl([],_) :- !,fail.
lastEl([X],X) :- !.
lastEl([_|T],X) :- lastEl(T,X).


% Обращение списка (встроенный предикат reverse/2).

rev([],[]).
rev([H|T],R) :- rev(T,R1),appendLists(R1,[H],R).


% Здесь может быть обращение списка с аккумулятором, более эффективное
% за счет хвостовой рекурсии


% Перейдем к сортировке. Самая простая, хотя и неэффективная сортировка
% - сортировка пузырьком. Ее сложность O(n^2).

singlePass([],[]) :- !. % В пустом списке максимальный элемент уже в самом конце (его просто нет)
singlePass([H],[H]) :- !. % В списке из одного элемента тоже все нормально
singlePass([F,S|Tail],[S|PartlySorted]) :- F>S,!,singlePass([F|Tail],PartlySorted).
singlePass([F,S|Tail],[F|PartlySorted]) :- singlePass([S|Tail],PartlySorted).

bubbleSort(Sorted,Sorted) :- singlePass(Sorted,Passed),Sorted=Passed,!.
bubbleSort(L,Sorted) :- singlePass(L,PartlySorted),!,bubbleSort(PartlySorted,Sorted).


% Другая реализация пузырька

singlePermutation([X,Y|T],[Y,X|T]) :- X>Y,!.
singlePermutation([X|T],[X|T1]) :- singlePermutation(T,T1).
bubble(L,L1) :- singlePermutation(L,L2),!,bubble(L2,L1).
bubble(L,L).


% Здесь должна быть реализация быстрой сортировки


% Предикат для вывода списка в консоль.

printList([]).
printList([H|T]) :- write(H),write(' '),printList(T).


% Реализация генерации списка заданной длины и его заполнения случайными числами
