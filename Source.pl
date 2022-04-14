word(horse, animals).

% Implemented by: Shamekh
is_category(C):- 
  word(_, C).
%
  
% Implemented by: Omar
pick_word(W, L, C):-
  word(W, C1),
  C1 = C,
  atom_length(W, L1),
  L = L1.
%
  
% Implemented by: Ali
correct_letters(L1,L2,CL):-
  CL = [H|T],
  correct_letters_helper(H, L1, [H|T]),
  correct_letters_helper(H, L2, [H|T]).

correct_letters_helper(X, [], []).
correct_letters_helper(H,[H0|T0],CL):-
  (H = H0, CL is [H|T]);
  (H \= H0, correct_letters_helper(H, [T0], CL1).

category([]). 
category(L):-
  L = [H|T], is_category(H), category(T).
%
