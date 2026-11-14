% Lab11_TASK1_NameGame.pl - Lab Activity: the "Name Game"
% Start with the letters a, b, c and add, delete or move letters to make your name.
% Uses assert / asserta / assertz, retract and retractall.
% Run it with:  ?- play.
% End every input with a full stop, e.g.  3.   then   s.
% To move a letter: delete it (5), then add it at the top (3) or bottom (4).

:- dynamic ch/1.

ch(a).
ch(b).
ch(c).

play :-
    write('Hi, This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    options.

options :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    read(N),
    do(N).

% 1- Display (letters separated by spaces)
do(1) :-
    findall(X, ch(X), Letters),
    show(Letters),
    options.

% 2- Add a letter (assert puts it last)
do(2) :-
    write('Which letter do you want to add? '), nl,
    read(L),
    assert(ch(L)),
    write('Done, the letter was added.'), nl,
    options.

% 3- Add at the top (asserta puts it first)
do(3) :-
    write('Which letter do you want to add at the top? '), nl,
    read(L),
    asserta(ch(L)),
    write('Done, the letter was added at the top.'), nl,
    options.

% 4- Add at the bottom (assertz puts it last)
do(4) :-
    write('Which letter do you want to add at the bottom? '), nl,
    read(L),
    assertz(ch(L)),
    write('Done, the letter was added at the bottom.'), nl,
    options.

% 5- Delete one letter (retract removes the first match)
do(5) :-
    write('Which letter do you want to delete? '), nl,
    read(L),
    remove(L),
    options.

% 6- Delete all letters (retractall)
do(6) :-
    retractall(ch(_)),
    write('Done, all letters were deleted.'), nl,
    options.

% 7- Exit
do(7) :-
    write('Thank you for playing!'), nl.

% Anything else
do(N) :-
    \+ member(N, [1,2,3,4,5,6,7]),
    write('Please choose a number from 1 to 7.'), nl,
    options.

% ---------- Helpers ----------
remove(L) :-
    once(retract(ch(L))),
    write('Done, the letter was deleted.'), nl.
remove(L) :-
    \+ ch(L),
    write('That letter is not in your set.'), nl.

show([]) :-
    write('Your set of letters is empty.'), nl.
show([H|T]) :-
    write('Your letters: '),
    show_letters([H|T]), nl.

show_letters([]).
show_letters([X|Rest]) :-
    write(X), write(' '),
    show_letters(Rest).
