% Render the ship term as a nice table.
:- use_rendering(table,[header(s('Ship', 'Leaves at', 'Carries', 'Chimney', 'Goes to'))]).

goes_PortSaid(Goes) :-
  ships(S),
  member(s(Goes,_,_,_,portSaid), S).

carries_tea(Carries) :-
  ships(S),
  member(s(Carries,_,tea,_,_), S).

ships(S) :-
  length(S,5),
  member(s(greek,6,coffee,_,_),S),
  S = [_,_,s(_,_,_,black,_),_,_],
  member(s(english,9,_,_,_),S),
  left(s(french,_,_,blue,_),
  s(_,_,coffee,_,_),S),
  next(s(_,_,_,_,marseille),
  s(_,_,cocoa,_,_),S),
  member(s(brazilian,_,_,_,manila),S),
  next(s(_,_,_,green,_),
  s(_,_,rice,_,_),S),
  member(s(_,5,_,_,genoa),S),
  next(s(spanish,7,_,_,_),
  s(_,_,_,_,marseille),S),
  member(s(_,_,_,red,hamburg),S),
  next(s(_,_,_,white,_),s(_,7,_,_,_),S),
  border(s(_,_,corn,_,_),S),
  member(s(_,8,_,black,_),S),
  next(s(_,_,corn,_,_),
  s(_,_,rice,_,_),S),
  member(s(_,6,_,_,hamburg),S),
  member(s(_,_,_,_,portSaid),S),
  member(s(_,_,tea,_,_),S).

next(A, B, Ls) :-
  append(_, [A,B|_], Ls).

next(A, B, Ls) :-
  append(_, [B,A|_], Ls).

left(A, B, Ls) :-
  append(_, [A,B|_], Ls).

border(A, Ls) :-
  append(_,[A], Ls).

border(A, Ls) :-
  append([A|_],_,Ls).
