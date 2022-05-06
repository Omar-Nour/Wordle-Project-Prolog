:- dynamic
        word/2.
		
%available_length(L):-
%	word(X, _),
%	atom_length(X, L).
	
available_length(L,C):-
	word(X, C),
	atom_length(X, L).	
		

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
	atom_length(W, L).
	
pick_random_word(W, L, C):-
	bagof(W1, pick_word(W1, L, C), Bag),
	random_member(W, Bag).
  
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
	

choose_catgeory(C):-
	write('Choose a category: '), nl,
	read(Input),
	(
		(
			is_category(Input),
			C = Input
		)
		;
		(
		   write('This category does not exist.'), nl,
		   choose_catgeory(C)
		)
	).	

	
%choose_length(Word_length):-
%	write('Choose a length: '), nl, nl,
%	read(Len),
%	%number_string(N, [Len]),
%	available_length(Len), !,
%	Word_length = Len.

%choose_length(L, Word_length):-
%	write('Choose a length: '), nl,
%	read(Len),
%	%number_string(N, [Len]),
%	\+available_length(Len), 
%	write('There are no words of this length.'), nl,
%	choose_length(Word_length).

choose_length(Word_length,C):-
	write('Choose a length: '), nl,
	read(Len),
	(
		(
			available_length(Len,C),
			Word_length = Len
		)
		;
		(
		    \+available_length(Len,C),
			write('There are no words of this length.'), nl,
			choose_length(Word_length,C)
		)
	).


init_game(W):-
 	write('The available categories are: '),
	categories(List),
	write(List), nl,
	choose_catgeory(C),
	choose_length(Word_length,C),
	Guesses is Word_length + 1,
	pick_random_word(W, Word_length, C),
	write('Game started. You have '), write(Guesses), write(' guesses.'), nl.
	
%get_word(Length, W):-
%	write('Enter a word composed of '), write(Length), write(' letters:'), nl,
%	read(Input),
%	string_to_list(Input, Word),
%   length(Word, Input_length),
%	Length \== Input_length,
%	write('Word is not composed of '), write(Length), write(' letters. Try again.'), nl,
%	write('Remaining Guesses are '), write(Length), nl, nl,
%	get_word(Length, W).
	
%get_word(Length, W):-
%	write('Enter a word composed of '), write(Length), write(' letters:'), nl,
%	read(Input),
%	string_to_list(Input, Word),
%   length(Word, Input_length),
%	Length == Input_length,
%	W = Word.

get_word(Length, W, Rem_guesses):-
	write('Enter a word composed of '), write(Length), write(' letters:'), nl,
	read(Input),
	string_to_list(Input, Word),
	length(Word, Input_length),
	(
		(
			Length == Input_length,
			W = Word
		)
		;
		(
			Length \== Input_length,
			write('Word is not composed of '), write(Length), write(' letters. Try again.'), nl,
			write('Remaining Guesses are '), write(Rem_guesses), nl, nl,
			get_word(Length, W, Rem_guesses) 
		)
	).
	

	
%turn(Rem_guesses, W, Correct_letters, Correct_positions, Length):-
%	N_Rem_guesses is Rem_guesses - 1,
%	get_word(Length, Word, Rem_guesses),
%	W == Word,
%	write('You Won!').
	
%turn(Rem_guesses, W, Correct_letters, Correct_positions, Length):-
%	N_Rem_guesses is Rem_guesses - 1,
%	get_word(Length, Word, Rem_guesses),
%	W \== Word,
%	correct_letters(W, Word, Correct_letters),
%	correct_positions(W, Word, Correct_positions),
%	write('Correct letters are: '), write(Correct_letters), nl,
%	write('Correct letters in correct positions are: '), write(Correct_positions), nl,
%	write('Remaining Guesses are '), write(N_Rem_guesses), nl, nl,
%	turn(N_Rem_guesses, W, Correct_letters, Correct_positions, Length).

turn(Rem_guesses, W, Correct_letters, Correct_positions, Length):-
	Rem_guesses == 0,
	write('You Lost').
	
turn(Rem_guesses, W, Correct_letters, Correct_positions, Length):-
	N_Rem_guesses is Rem_guesses - 1,
	get_word(Length, Word, Rem_guesses),
	(
		(
			W == Word,
			write('You Won!')
		)
		;
		(
			W \== Word,
			correct_letters(W, Word, Correct_letters),
			correct_positions(W, Word, Correct_positions),
			write('Correct letters are: '), write(Correct_letters), nl,
			write('Correct letters in correct positions are: '), write(Correct_positions), nl,
			write('Remaining Guesses are '), write(N_Rem_guesses), nl, nl,
			turn(N_Rem_guesses, W, Correct_letters, Correct_positions, Length)
		)
	).

%
  
% Implemented by: Ali

%correct_letters(L1,[H|T],Cl):-
%	correct_letters_h(L1,[H|T],[],Cl).

%correct_letters_h(_, [], X, X).

%correct_letters_h(L1,[H|T],Acc,Cl):-
%	\+member(H,L1),
%	correct_letters_h(L1,T,Acc,Cl).

%correct_letters_h(L1,[H|T],Acc,Cl):-
%	L1 is [H2|T2],
%	member(H,L1),
%	append(H,Acc),
%	correct_letters_h(T2,T,Acc,Cl).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
correct_letters(L1, L2, Cl):-
	L1 = [Input|T2],
	correct_letters_h([Input|T2], L2, Cl, []), !.

correct_letters_h([], _, L, L).		
	
correct_letters_h([Input|T2], L2, Cl, Acc):-
	(
		(
			member(Input, L2),
			append([Input], Acc, NewAcc)
		)
		;
		(
			\+member(Input, L2),
			NewAcc = Acc
		)
	),
	correct_letters_h(T2, L2, Cl, NewAcc).

%correct_letters_helper(X, [], []).
%correct_letters_helper(H,[H0|T0],CL):-
%  (H = H0, CL is [H|T]);
%  (H \= H0, correct_letters_helper(H, [T0], CL1)).

categories(L):-
	setof(C , X^word(X, C), L).

play:-
   init_game(W), !,
   string_to_list(W, Word),
   length(Word, Length),
   Turns is Length + 1,
   turn(Turns, Word, Correct_letters, Correct_positions, Length).

main:-
  write("Welcome to Pro-Wordle!"), nl,
  write("----------------------"), nl,
  build_kb,
  play.
  
