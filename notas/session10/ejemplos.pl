%% Ejemplos básicos de Prolog

%% Números naturales

%% Definición
nat(zero).
nat(succ(N)) :-
	nat(N).

%% Suma
sumNat(zero, M, M).
sumNat(succ(N), M, succ(Res)) :-
	sumNat(N, M, Res).

%% Producto
prodNat(zero, _, zero).
prodNat(succ(N), M, Res) :-
	prodNat(N, M, X),
	sumNat(X, M, Res).

%% Natural a entero
natInt(zero, 0).
natInt(succ(N), X) :-
	natInt(N, Y),
	X is Y + 1.

%% Listas

%% Concatenación de dos listas
myConc([], YS, YS).
myConc([XH | XT], YS, [XH | ZT]) :-
	myConc(XT, YS, ZT).

%% Reversa de una lista
myReverseAux([], Acc, Acc).
myReverseAux([L1H | L1T], Acc, Rev) :-
	myReverseAux(L1T, [L1H | Acc], Rev).

myReverse(L1, L2) :-
	myReverseAux(L1, [], L2).

%% Palíndromo
palindromeAux(L, L).

palindrome(L1) :-
	myReverse(L1, LRev),
	palindromeAux(LRev, L1).

%% ¿La curiosidad mató al gato?
lovesAllAnimals(jack) :- !.
lovesAllAnimals(X) :-
    loves(_, X).

kills(X, Y) :-
    animal(Y),
    not(loves(_, X)).

cat(tuna).
cat(X) :-
    animal(X).

person(curiosity) :- !.
person(jack) :- !.
animal(tuna) :- !.
