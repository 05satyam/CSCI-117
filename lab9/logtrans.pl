determiner(S,P1,P2,[every|X],X,all(S,imply(P1,P2))).
determiner(S,P1,P2,[a|X],X,exists(S,and(P1,P2))).

noun(N,[man|X],X, man(N)).
noun(N,[woman|X],X,woman(N)).

% adding child
noun(N,[child|X],X,child(N)).

name([john|X],X,john).
name([mary|X],X,mary).

% adding new names
name([eve|X],X,eve).
name([adam|X],X,adam).

% new transverbs
transverb(S,O,[loves|X],X,loves(S,O)).
transverb(S,O,[knows|X],X,knows(S,O)).
intransverb(S,[lives|X],X,lives(S)).
intransverb(S,[runs|X],X,runs(S)).

sentence(X0,X,P):-
  nounphrase(N,P1,X0,X1,P),
  verbphrase(N,X1,X,P1).

% building sentences
sentence([john,loves,eve],[],O).
sentence([adam,knows,mary],[],O).
sentence([a,woman,lives],[],O).
sentence([a,man,runs],[],O).
sentence([a,child,runs],[],O).
sentence([a,child,who,loves,john,lives],[],O).
sentence([every, woman, who, john, loves, lives],[],O).
sentence([every, woman, who, loves, adam, lives],[],O).
sentence([every, woman, who, adam, loves, lives],[],O).
sentence([every, woman, who, knows, a, man, who, loves, mary, lives],[],O).
sentence([every, man, who, loves, a, woman, who, knows, adam, runs], [], O).
sentence([every, child, who, knows, a, woman, who, knows, eve, lives], [], O).
sentence([every, woman, who, knows, a, child, who, loves, john, runs], [], O).

% sentence formation patterns
nounphrase(N,P1,X0,X,P):-
  determiner(N,P2,P1,X0,X1,P),
  noun(N,X1,X2,P3),
  relclause(N,P3,X2,X,P2).

nounphrase(N,P1,X0,X,P1):-
  name(X0,X,N).

verbphrase(S,X0,X,P):-
  transverb(S,O,X0,X1,P1),
  nounphrase(O,P1,X1,X,P).

verbphrase(S,X0,X,P):-
  nounphrase(O,_,X0,X1,_),
  transverb(O,S,X1,X,P).

verbphrase(S,X0,X,P):-
  intransverb(S,X0,X,P).

relclause(S,P1,[who|X1],X,and(P1,P2)):-
  verbphrase(S,X1,X,P2).

relclause(_,P1,X,X,P1).
