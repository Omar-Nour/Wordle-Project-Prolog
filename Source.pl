% Implemented by: Shamekh
is_category(C):- 
  word(_, C).
  
correct_positions([], [], []).
correct_positions([H1|T1], [H2|T2], PL):-
	(
	 H1 = H2,
	 PL = [H1|T],
	 correct_positions(T1, T2, T)
	)
	;
	(
	 H1 \= H2,
	 correct_positions(T1, T2, PL)
	).
%
  
% Implemented by: Omar
pick_word(W, L, C):-
  word(W, C),
  atom_length(W, L1),
  L == L1.
  
build_kb:-
    write('Please enter a word and its category on separate lines:'), nl,
    read(N),
    (
        (
            N == 'done',
            write('Done building the words database...'), nl
        )
        ;
        (
            N \== 'done',
            read(C),
            assert(word(N, C)),
            build_kb
        )
    ).
%
  
% Implemented by: Ali
correct_letters(L1,L2,CL):-
  CL is [H|T],
  correct_letters_helper(H, L1, [H|T]),
  correct_letters_helper(H, L2, [H|T]).

correct_letters_helper(X, [], []).
correct_letters_helper(H,[H0|T0],CL):-
  (H = H0, CL is [H|T]);
  (H \= H0, correct_letters_helper(H, [T0], CL1)).

category([]). 
category(L):-
  L = [H|T], is_category(H), category(T).
%

main:-
  write("Welcome to Pro-Wordle!"), nl,
  write("----------------------"), nl,
  build_kb,
  play.
