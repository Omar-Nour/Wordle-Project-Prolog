word(horse, animals).

%Implemented by: Shamekh
is_category(C):- 
  word(_, C).
  
%Implemented by: Omar
pick_word(W, L, C):-
  word(W, C1),
  C1 = C,
  atom_length(W, L1),
  L = L1.
  
