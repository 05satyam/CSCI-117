%1.
cons(nil,E,snoc(nil,E)).
cons(snoc(BL,N),E,snoc(BLN,N)):-cons(BL,E,BLN).

% mode (+,+,-)
% ?- cons(snoc(snoc(nil,10),9),8,O)
% O = snoc(snoc(snoc(nil, 8), 10), 9)

%2.
snoc([], E, [E]).
snoc([Y1|YS],X,[Y1|Out]) :- snoc(Ys,X,Out).

% mode (+,+,-)
% ?- snoc([1,2,3],5,O).
% O = [5, 5]

%3.
snoc([], E, [E]).
snoc([Y|Ys],X,[Y|Out]) :- snoc(Ys,X,Out).
fromBList(nil,[]).
fromBList(snoc(X,N),Out) :- fromBList(X,Y),snoc(Y,N,Out).

% mode (+,-)
% ?-fromBList(snoc(snoc(snoc(nil,1),2),3),Out)
% Out = [1, 2, 3]

%4.
cons(nil,E,snoc(nil,E)).
cons(snoc(Xx,N),E,snoc(Yy,N)):-cons(Xx,E,Yy).
toBList([],nil).
toBList([X|Xs],Out) :- toBList(Xs,Y),cons(Y,X,Out).

% mode (+,-)
% ?- toBList([1,2],Out).
% Out = snoc(snoc(nil, 1), 2)

%5.

num_empties(empty,1).
num_empties(node(A,T1,T2),Z) :- num_empties(T1,X),num_empties(T2,Y),Z is X+Y.

% mode (+,+,-)
% ?-num_empties(node(1,empty,empty),Z)
% Z=2


%6.

num_nodes(empty,0).
num_nodes(node(A,T1,T2),Z) :- num_nodes(T1,X),num_nodes(T2,Y),Z is 1+X+Y.

% mode (+,+,-)
% ?-num_nodes(node(1,empty,empty),Z)
% Z=1


%7.

insert_left(X,empty,node(X,empty,empty)).
insert_left(X,node(A,T1,T2),node(A,TT1,T2)) :- insert_left(X,T1,TT1).

% mode (+,+,-)
% ?-insert_left(3,node(4,empty,empty),E)
% E = E = node(4, node(3, empty, empty), empty)

%8.
insert_right(X,empty,node(X,empty,empty)).
insert_right(X,node(A,T1,T2),node(A,T1,TT2)) :- insert_right(X,T2,TT2).
% mode (+,+,-)
% ?- insert_right(5,node(6,empty,empty),E)
% E = node(6, empty, node(5, empty, empty))

%9.

sum_nodes(Empty,0).
sum_nodes((node(A,T1,T2),Z) :- sum_nodes(T1,X),sum_nodes(T2,Y),Z is A+X+Y.

% mode (+,+,-)
% ?- sum_nodes(node(node(empty,empty,3),empty,5),O)


%10.
append([],Y,Y).
append([H|T],Y,[H|Z]) :- append(T,Y,Z).
inorder(empty,[]).
inorder(node(A,X1,X2),Out2) :-
inorder(X1,XX1),inorder(X2,XX2),append(XX1,[A],Out1),append(Out1,XX1,Out2).

% mode (+,+,-)
% ?- inorder(node(3,node(2, empty,empty),empty),O)
% O = [2, 3, 2]


%11.

num_elts(leaf(A),1).
num_elts(node(A,L,R),Zz) :- num_elts(L,X),num_elts(R,Y),Zz is 1+X+Y.

% mode (+,-)
% ?- num_elts(node(0,leaf(2),leaf(5)),M)
% M=3

%12.
sumNodess(leaf(A),1).
sumNodess(node(A,L,R),Z) :- sumNodes2(L,X),sumNodes2(R,Y),Z is A+X+Y.
% mode (+,-)
% ?- sumNodess(node(1,leaf(10),leaf(3)),O)

%13.
append([],Y,Y).
append([H|T],Y,[H|Z]) :- append(T,Y,Z).
inorder2(leaf(A),[A]).
inorder2(node(A,T1,T2),Out2) :-
inorder2(T1,TT1),inorder2(T2,TT2),append(TT1,[A],Out1),append(Out1,TT1,Out2).

% mode (+,-)
% ?- inorder2(node(0,leaf(9),leaf(9)),O)
% O = [9, 0, 9]

% ?- inorder2(node(1,leaf(4),leaf(4)),O)
% O = [4, 1, 4]

%14.

conv21(leaf(A),node(A ,empty, empty)).
conv21(node2(X,T1,T2),node(X,TT1,TT2)):- conv21(T1,TT1),conv21(T2,TT2).

% mode (+,-)
% ?- conv21((node2(3,leaf(5),leaf(6))),Out)
% Out = node(3, node(5, empty, empty), node(6, empty, empty))

%?- conv21((node2(2,leaf(5),leaf(8))),Out)
% Out = node(2, node(5, empty, empty), node(8, empty, empty))


%15.

toBListIt(List,O):- toBListIt(List,nil,O).
toBListIt([],A,A).
toBListIt([X|Xs],A,Aa):-
AP = snoc(A,X),
toBListIt(Xs,AP,Aa).

% mode (+,-)
% ?- toBListIt([0,9],O)
% O = snoc(snoc(nil, 0), 9)

%16.

fromBlist(snoc(L,N),O):- fromBlistIt(snoc(L,N),[],O).
fromBlistIt(nil,A,A).
fromBlistIt(snoc(L,N),A,AN):-
AP = [N|A],
fromBlistIt(L,AP,AN).

% mode (+,-)
% ?- fromBlist(snoc(snoc(snoc(nil,1),2),3),O)
% O = [1, 2, 3]

%17.

numEmptiesIt(T,Out1) :- numEmptiesItH([T],0,Out1).
numEmptiesItH([],A,A).
numEmptiesItH([empty|Ts],A,Out1):- AP is A+1,numEmptiesItH(Ts,AP,Out1).
numEmptiesItH([node(X,T1,T2)|Ts],A,Out1):-numEmptiesItH([T1,T2|Ts],A,Out1).

% mode (+,-)
% ?- numEmptiesIt((node(1,empty,empty)),Out)
% Out = 2

%18.

numNodes(T,Out1) :- numNodesIt([T],0,Out1).
numNodesIt([],A,A).
numNodesIt([empty|Ts],A,Out1):- numNodesIt(Ts,A,Out1).
numNodesIt([node(X,T1,T2)|Ts],A,Out1):-AP is A+1,numNodesIt(Ts,AP,Out1).

% mode (+,-)
% ?- numNodes((node(9,empty,empty)),Out)
% Out= 1


%19.

sumNodes2(T,N) :- sumNodesIt2([T],0,N).
sumNodesIt2([],A,A).
sumNodesIt2([leaf(E)|Ts],A,N) :- AP is E+A, sumNodesIt2(Ts,AP,N).
sumNodesIt2([node2(X,T1,T2)|Ts],A,N) :- AP is A+X, sumNodesIt2([T1,T2|Ts],AP,N).

% mode (+,-)
% ?- sumNodes2(leaf(0),Out)
% Out = 0

%20.

inorderIt2(T,Out1) :- inorderItH2([T],[],Out1).
inorderItH2([],A,A).
inorderItH2([leaf(F)|Ts],A, Out1) :- inorderItH2(Ts,[F|A],Out1).
inorderItH2([node2(X,T1,T2)|Ts],A,Out1):- inorderItH2([T2,leaf(X),T1|Ts],A,Out1).

% mode (+,-)
% ?-inorderItH2(node(X,L,R)|Ts],A,Out)


%21

% mode(+,-)
% ?-bst node(10,node(8,empty,node(9,empty,empty)), node(11,empty,node(12,empty,empty)),O)

%bst(empty,true).
%bst(T):-bst_it(T,neginf,posinf).
%bst_it(empty,_,_).
%bst_it(node(X,L,R),low,high):-lt(low,fin(X)),lt(fin(X),high),bst_it(L,low,fin(X)),bst_it(R,fin(X),high).

%22.

% mode(+,-)
% ?-bst2 node(10,node(8,empty,node(9,empty,empty)), node(11,empty,node(12,empty,empty)),O)

%bst2(leaf(X),true).
%bst2(T):-bst2_it(T,neginf,posinf).
%bst2_it(leaf(X),low,high):-lt(low,fin(X)),lt(fin(X),high).
%bst2_it(node(X,L,R),low,high):-
%lt(low,fin(X)),lt(fin(X),high),bst2_it(L,low,fin(X)),bst2_it(R,fin(X),high)
