/*
 * Пример реализации КСГ специальными средствами Prolog
 *
*/


% Описание грамматики

plainSentense --> nounPhrase, verbPhrase.
sentense --> plainSentense.
sentense --> plainSentense, conjunction, sentense.
nounPhrase --> article, noun.
verbPhrase --> verbExpr, nounPhrase.
verbExpr --> modalVerb, verb, prep.

%article --> ["a"].
%article --> ["the"].
%noun --> ["cat"].
%noun --> ["king"].
%modalVerb --> ["may"].
%verb --> ["look"].
%prep --> ["at"].
%conjunction --> ["and"].
%conjunction --> ["or"].
%conjunction --> ["but"].

% Здесь также используем специальный синтаксис для вставки
% дополнительных условий в тело грамматических правил.

article --> {lexicon("article",A)},[A].
noun --> {lexicon("noun",Noun)},[Noun].
modalVerb --> {lexicon("modal verb",Mv)},[Mv].
verb --> {lexicon("verb",Verb)},[Verb].
prep --> {lexicon("prep",Prep)},[Prep].
conjunction --> {lexicon("conj",C)},[C].

% Лексикон отдельно

lexicon("article","a").
lexicon("article","the").
lexicon("noun","cat").
lexicon("noun","king").
lexicon("verb","look").
lexicon("modal verb","may").
lexicon("prep","at").
lexicon("conj","and").
lexicon("conj","or").
lexicon("conj","but").

% Операции консольного UI

recognize :- write("Enter the phrase: "),
    current_input(In),
    read_string(In, "\n", "\r\t ", _, Phrase),
    split_string(Phrase, " ", "", ListPhrase),
    sentense(ListPhrase,[]),!.


generate :- sentense(Phrase,[]), atomics_to_string(Phrase,' ',String),write(String).
