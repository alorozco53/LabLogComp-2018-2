%% Práctica 4
%% Lógica Computacional, 2018-2

%% Definición de árboles binarios
binTree(btnil).
binTree(btbranch(_, LChild, RChild)) :-
	binTree(LChild),
	binTree(RChild).

%% Información de un árbol binario
infoTree(btnil, 0, 0) :- !.
infoTree(btbranch(_, btnil, btnil), 0, 1) :- !.
infoTree(btbranch(_, LChild, RChild), Branches, Leaves) :-
	infoTree(LChild, LeftBranches, LeftLeaves),
	infoTree(RChild, RightBranches, RightLeaves),
	Branches is LeftBranches + RightBranches + 1,
	Leaves is LeftLeaves + RightLeaves.

%% Inserción de un elemento en un árbol de búsqueda binaria
insertBST(E, btnil, btbranch(E, btnil, btnil)) :- !.
insertBST(E, btbranch(N, btnil, RChild), btbranch(N, btbranch(E, btnil, btnil), RChild)) :-
	E =< N, !.
insertBST(E, btbranch(N, LChild, btnil), btbranch(N, LChild, btbranch(E, btnil, btnil))) :-
	E > N, !.
insertBST(E, btbranch(N, LChild, RChild), btbranch(N, NewLChild, RChild)) :-
	E =< N,
	insertBST(E, LChild, NewLChild).
insertBST(E, btbranch(N, LChild, RChild), btbranch(N, LChild, NewRChild)) :-
	E > N,
	insertBST(E, RChild, NewRChild).

%% Inserta todos los elementos de una lista a un BST
insertListBST([], ResBST, ResBST).
insertListBST([H | T], BST, ResBST) :-
	insertBST(H, BST, NewBST),
	insertListBST(T, NewBST, ResBST).

%% Lista a BST
binSearchTree(List, BST) :-
	insertListBST(List, btnil, BST), !.

%% Concatenación de dos listas
myConc([], YS, YS).
myConc([XH | XT], YS, [XH | ZT]) :-
	myConc(XT, YS, ZT).

%% Recorrido inorder
inorder(btnil, []) :- !.
inorder(btbranch(N, LChild, RChild), InOrderList) :-
	inorder(LChild, LeftInOrder),
	inorder(RChild, RightInOrder),
	myConc(LeftInOrder, [N], ConcLeft),
	myConc(ConcLeft, RightInOrder, InOrderList).

%% Recorrido preorder
preorder(btnil, []) :- !.
preorder(btbranch(N, LChild, RChild), PreOrderList) :-
	preorder(LChild, LeftPreOrder),
	preorder(RChild, RightPreOrder),
	myConc([N], LeftPreOrder, ConcLeft),
	myConc(ConcLeft, RightPreOrder, PreOrderList).

%% Recorrido postorder
postorder(btnil, []) :- !.
postorder(btbranch(N, LChild, RChild), PostOrderList) :-
	postorder(LChild, LeftPostOrder),
	postorder(RChild, RightPostOrder),
	myConc(LeftPostOrder, RightPostOrder, ConcDown),
	myConc(ConcDown, [N], PostOrderList).

%% Autómata compresor

%% Toma los primeros k elementos de una lista
take([], _, []) :- !.
take(_, 0, []) :- !.
take([H | T], K, [H | NextPrefix]) :-
	L is K - 1,
	take(T, L, NextPrefix).

%% Autómata de pila para palíndromos
palq1([H | T],  Stack) :-
	palq1(T, [H | Stack]), !.
palq1([H | T],  Stack) :-
	palq2(T, [H | Stack]), !.

palq2(Stack, Stack) :- !.
palq2([_ | Stack], Stack) :- !.

palPDA([]) :- !.
palPDA(List) :-
	palq1(List, []).

%% Autómata compresor y función auxiliar
processPal(List, Acc, Comp) :-
	length(Acc, L),
	L >= 2,
	palPDA(Acc),
	HalfLen is div(L, 2),
	take(Acc, HalfLen, Half),
	processPal(List, [], NextComp),
	myConc(Half, NextComp, Comp).
processPal([], Acc, Acc).
processPal([H | T], Acc, Comp) :-
	myConc(Acc, [H], NewAcc),
	processPal(T, NewAcc, Comp).

delPal(List, Compressed) :-
	processPal(List, [], Compressed), !.
