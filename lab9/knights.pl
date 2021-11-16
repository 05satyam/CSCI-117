closed_knights(N,M,T) :-
  knightTour(N,M,T),
  T = [m(X,Y),_],
  moves(m(X,Y), m(0,0)).

knightTour(N,M,T) :- N2 is N*M-1, % N2 is the number of positions on the board (N^2)
kT(N,M,N2,[m(0,0)],T). % [m(0,0)] is starting position of the knight

kT(_,_,_,T,T).

kT(N,M,N2,[m(P1,P2)|Pt],T) :-
  	moves(m(P1,P2),m(D1,D2)),          % get next position from current position
    D1>=0, D2>=0, D1<N, D2<M,          % verify next position is within board dimensions
    \+ member(m(D1,D2),Pt),            % next position has not already been covered in tour
    N3 is N2-1,
    kT(N,M,N3,[m(D1,D2),m(P1,P2)|Pt],T). % append next position to front of accumulator

moves(m(X,Y), m(X1,Y1)) :-
member(m(A,B), [m(1,2),m(1,-2),m(-1,2),m(-1,-2),m(2,1),m(2,-1),m(-2,1),m(-2,-1)]),
X1 is X + A,
Y1 is Y + B.



% sample Example output
% ?- knightTour(4,4,T)
% T = [m(0, 0)]
% T = [m(1, 2), m(0, 0)]
% T = [m(2, 0), m(1, 2), m(0, 0)]
% T = [m(3, 2), m(2, 0), m(1, 2), m(0, 0)]
% T = [m(1, 3), m(3, 2), m(2, 0), m(1, 2), m(0, 0)]
% T = [m(2, 1), m(1, 3), m(3, 2), m(2, 0), m(1, 2), m(0, 0)]
% T = [m(3, 3), m(2, 1), m(1, 3), m(3, 2), m(2, 0), m(1, 2), m(0, 0)]
% T = [m(0, 2), m(2, 1), m(1, 3), m(3, 2), m(2, 0), m(1, 2), m(0, 0)]
% T = [m(1, 0), m(0, 2), m(2, 1), m(1, 3), m(3, 2), m(2, 0), m(1, 2), m(0, 0)]
% T = [m(2, 2), m(1, 0), m(0, 2), m(2, 1), m(1, 3), m(3, 2), m(2, 0), m(1, 2), m(0, 0)]
% T = [m(3, 0), m(2, 2), m(1, 0), m(0, 2), m(2, 1), m(1, 3), m(3, 2), m(2, 0), m(1, 2), m(0, 0)]
