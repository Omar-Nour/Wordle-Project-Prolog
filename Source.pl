:- dynamic
        word/2.
  		

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
            write('Done building the words database...'), nl, nl
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
	
choose_catgeory(List, C):-
	write('Choose a category: '), nl,
	read(Input),
	member(Input, List),
	C = Input.

choose_catgeory(List, C):-
	write('Choose a category: '), nl,
	read(Input),
	\+member(Input, List),
	write('This category does not exist.'), nl,
	choose_catgeory(List, C).
	
choose_length(L, Word_length):-
	write('Choose a length: '), nl,
	read(Len),
	number_string(N, Len),
	N = L,
	Word_length = N.

choose_length(L, Word_length):-
	write('Choose a length: '), nl,
	read(Len),
	number_string(N, Len),
	N \= L,
	write('There are no words of this length.'), nl,
	choose_length(L, Word_length).

init_game(W):-
 	write('The available categories are: '),
	categories(List),
	write(List), nl,
	available_length(L),
	choose_catgeory(List, C),
	choose_length(L, Word_length),
	pick_word(W, Word_length, C),
	write('Game started. You have 6 guesses.').
	
get_word(Length, W):-
	write('Enter a word composed of '), write(Length), write(' letters:'), nl,
	read(Input),
	string_to_list(Input, Word),
   	length(Word, Input_length),
	Length \== Input_length,
	write('Word is not composed of '), write(Length), write(' letters. Try again.'), nl,
	write('Remaining Guesses are '), write(Length), nl, nl,
	get_word(Length, W).
	
get_word(Length, W):-
	write('Enter a word composed of '), write(Length), write(' letters:'), nl,
	read(Input),
	string_to_list(Input, Word),
   	length(Word, Input_length),
	Length == Input_length,
	W = Word.
	
turn(Rem_guesses, W, Correct_letters, Correct_positions, Length):-
	Rem_guesses == 0,
	write('You Lost').
	
turn(Rem_guesses, W, Correct_letters, Correct_positions, Length):-
	N_Rem_guesses is Rem_guesses - 1,
	get_word(Length, Word),
	W == Word,
	write('You Won!').
	
turn(Rem_guesses, W, Correct_letters, Correct_positions, Length):-
	N_Rem_guesses is Rem_guesses - 1,
	get_word(Length, Word),
	W \== Word,
	correct_letters(W, Word, Correct_letters),
	correct_positions(W, Word, Correct_positions),
	write('Correct letters are: '), write(Correct_letters), nl,
	write('Correct letters in correct positions are: '), write(Correct_positions), nl,
	write('Remaining Guesses are '), write(Length), nl, nl,
	turn(N_Rem_guesses, W, Correct_letters, Correct_positions, Length).

%
  
% Implemented by: Ali
correct_letters(L1,L2,CL):-
  CL = [H|T],
  correct_letters_helper(H, L1, [H|T]),
  correct_letters_helper(H, L2, [H|T]).

correct_letters_helper(X, [], []).
correct_letters_helper(H,[H0|T0],CL):-
  (H = H0, CL is [H|T]);
  (H \= H0, correct_letters_helper(H, [T0], CL1)).


%categories(L):-
% L = [H|T], is_category(H), \+ member(H,T), categories(T).


%categories([]). 


categories(L):-
	aggregate_all(count, word(_,C), Count).
	catg_h(Count, Acc, L).

catg_h(0, L, L).
catg_h(X, Acc, L):-
	word(_, C),
	\+member(C, Acc),
	append(Acc, [C], NewAcc),
	catg_h(X, NewAcc, L).


play:-
   init_game(W),
   string_to_list(W, Word),
   length(Word, Length),
   turn(6, Word, Correct_letters, Correct_positions, Length).

main:-
  write("Welcome to Pro-Wordle!"), nl,
  write("----------------------"), nl,
  build_kb,
  play.
