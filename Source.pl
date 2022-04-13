word(horse, animals).

is_category(C):- 
  word(_, C).
  
pick_word(W, L, C) :-
  word(W, C1),
  C1 = C,
  length(W, L1),
  L = L1.
  
