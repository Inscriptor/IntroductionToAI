/*
 * Пример реализации КСГ стандартными средствами Prolog
 * В качестве примера рассматривается алглоязычная пословица "A cat may
 * look at a king" и ее возможные вариации. Английские выражения проще
 * для описания в виде КСГ по причине отсутствия необходимости
 * морфологических согласований.
 *
*/


% Описание грамматики

sentense(S) :- nounPhrase(NP), verbPhrase(VP), append(NP,VP,S).
nounPhrase(NP) :- article(A), noun(N), append(A,N,NP).
verbPhrase(VP) :- verbExpr(VE), nounPhrase(NP), append(VE,NP,VP).
verbExpr(VE) :- modalVerb(MV), verb(V), prep(P), append([MV,V,P],VE).


%sentense(S) :- append(NP,VP,S), nounPhrase(NP), verbPhrase(VP).
%nounPhrase(NP) :- append(A,N,NP), article(A), noun(N).
%verbPhrase(VP) :- append(VE,NP,VP), verbExpr(VE), nounPhrase(NP).
%verbExpr(VE) :- append([MV,V,P],VE), modalVerb(MV), verb(V), prep(P).

article([A]) :- lexicon("article",A).
noun([N]) :- lexicon("noun",N).
modalVerb([MV]) :- lexicon("modal verb",MV).
verb([V]) :- lexicon("verb",V).
prep([P]) :- lexicon("prep",P).

% Лексикон вынесен отдельно

lexicon("article","a").
lexicon("article","the").
lexicon("noun","cat").
lexicon("noun","king").
lexicon("verb","look").
lexicon("modal verb","may").
lexicon("prep","at").

% Операции консольного UI

recognize :- write("Enter the phrase: "),
    current_input(In),
    read_string(In, "\n", "\r\t ", _, Phrase),
    split_string(Phrase, " ", "", ListPhrase),
    sentense(ListPhrase),!.


generate :- sentense(Phrase), atomics_to_string(Phrase,' ',String),write(String).


