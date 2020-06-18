/*
 * ������ ���������� ��� ������������ ���������� Prolog � ��������������
 * ���������� �������.
 *
*/


% �������� ����������

sentense(S,D) :- nounPhrase(S,VP), verbPhrase(VP,D).
nounPhrase(NP,D) :- article(NP,N), noun(N,D).
verbPhrase(VP,D) :- verbExpr(VP,VE), nounPhrase(VE,D).
verbExpr(VE,D) :- modalVerb(VE,MV), verb(MV,V), prep(V,D).

article([A|D],D) :- lexicon("article",A).
noun([N|D],D) :- lexicon("noun",N).
modalVerb([MV|D],D) :- lexicon("modal verb",MV).
verb([V|D],D) :- lexicon("verb",V).
prep([P|D],D) :- lexicon("prep",P).

% �������� ������� ��������

lexicon("article","a").
lexicon("article","the").
lexicon("noun","cat").
lexicon("noun","king").
lexicon("verb","look").
lexicon("modal verb","may").
lexicon("prep","at").

% �������� ����������� UI

recognize :- write("Enter the phrase: "),
    current_input(In),
    read_string(In, "\n", "\r\t ", _, Phrase),
    split_string(Phrase, " ", "", ListPhrase),
    sentense(ListPhrase,[]),!.


generate :- sentense(Phrase,[]), atomics_to_string(Phrase,' ',String),write(String).
