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
    
	%The available categories are: [animals,greetings,fruits, collections]
	%Choose a category:
	%|: animals.
	%Choose a length:
	%|: 9.
	%There are no words of this length.
	%Choose a length:
	%|: 5.
	%Game started. You have 6 guesses.
	
init_game(W):-
 	write('The available categories are: '),
	categories(List),
	write(List), nl,
	available_length(L),
	choose_catgeory(List, C),
	choose_length(L, Word_length),
	pick_word(W, Word_length, C),
	write('Game started. You have 6 guesses.').

choose_catgeory(List, C):-
	write('Choose a category: '),
	read(Input),
	member(Input, List).
	C = Input.

choose_catgeory(List, C):-
	write('Choose a category: '),
	read(Input),
	\+member(Input, List),
	write('There is no such category'), nl,
	choose_catgeory(List, C).
	
choose_length(L, Word_length):-
	write('Choose a length: '),
	read(Len),
	number_string(N, Len),
	member(N, L),
	Word_length = N.

choose_length(L, Word_length):-
	write('Choose a length: '),
	read(Len),
	number_string(N, Len),
	\+member(N, L),
	write('There are no words of this length.'), nl,
	choose_length(L, Word_length).
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

categories([]). 
categories(L):-
  L = [H|T], is_category(H), categories(T).
%

main:-
  write("Welcome to Pro-Wordle!"), nl,
  write("----------------------"), nl,
  build_kb,
  init_game(W),
  play.
