% This is an example of intent recognition in a smart kitchen based on the PDDL domain an script.
% Ready f probabilities to be learned from the data.

% -------- World facts --------

person(tom).

% ------- Factors that influence intentions --------

1/4::morning; 1/4::midday; 1/4::afternoon; 1/4::evening.

% -------- Possible Intentions ---------

0.9::iMakeBreakfast(X) :- morning, person(X).
0.4::iMakeBreakfast(X) :- midday, person(X).
0.1::iMakeBreakfast(X) :- afternoon, person(X).
0.1::iMakeBreakfast(X) :- evening, person(X).

0.8::iPackLunch(X) :- morning, person(X).
0.7::iPackLunch(X) :- midday, person(X).
0.2::iPackLunch(X) :- afternoon, person(X).
0.1::iPackLunch(X) :- evening, person(X).

0.2::iMakeDinner(X) :- morning, person(X).
0.3::iMakeDinner(X) :- midday, person(X).
0.6::iMakeDinner(X) :- afternoon, person(X).
0.8::iMakeDinner(X) :- evening, person(X).

0.01::iTakeMedicine(X) :- morning, person(X).
0.6::iTakeMedicine(X) :- midday, person(X).
0.1::iTakeMedicine(X) :- afternoon, person(X).
0.8::iTakeMedicine(X) :- evening, person(X).

0.1::iWatchMovie(X) :- morning, person(X).
0.1::iWatchMovie(X) :- midday, person(X).
0.8::iWatchMovie(X) :- afternoon, person(X).
0.6::iWatchMovie(X) :- evening, person(X).

0.5::iWipeCounter(X) :- morning, person(X).
0.6::iWipeCounter(X) :- midday, person(X).
0.4::iWipeCounter(X) :- afternoon, person(X).
0.8::iWipeCounter(X) :- evening, person(X).

0.1::iTendPlants(X) :- morning, person(X).
0.6::iTendPlants(X) :- midday, person(X).
0.8::iTendPlants(X) :- afternoon, person(X).
0.1::iTendPlants(X) :- evening, person(X).

0.6::iDrinkJuice(X) :- morning, person(X).
0.8::iDrinkJuice(X) :- midday, person(X).
0.4::iDrinkJuice(X) :- afternoon, person(X).
0.3::iDrinkJuice(X) :- evening, person(X).

% -------- Observable Actions ---------

0.4::take(water_jug) :-iMakeBreakfast(tom).
0.4::take(water_jug) :-iPackLunch(tom).
0.7::take(water_jug) :-iMakeDinner(tom).
0.3::take(water_jug) :-iTakeMedicine(tom).
0.7::take(water_jug) :-iTendPlants(tom).

0.7::take(keetle) :-iMakeBreakfast(tom).
0.5::take(keetle) :-iPackLunch(tom).
0.5:take(keetle) :-iMakeDinner(tom).

0.5::take(cloth) :-iMakeBreakfast(tom).
0.6::take(cloth) :-iPackLunch(tom).
0.6::take(cloth) :-iMakeDinner(tom).
0.9::take(cloth) :-iWipeCounter(tom).

0.7::take(tea_bag) :-iMakeBreakfast(tom).
0.5::take(tea_bag) :-iPackLunch(tom).
0.4::take(tea_bag) :-iMakeDinner(tom).

0.7::take(cup) :-iMakeBreakfast(tom).
0.5::take(cup) :-iPackLunch(tom).
0.8::take(cup) :-iMakeDinner(tom).
0.3::take(cup) :-iTakeMedicine(tom).
0.7::take(cup) :-iDrinkJuice(tom).

0.7::take(sugar) :-iMakeBreakfast(tom).
0.5::take(sugar) :-iPackLunch(tom).
0.3::take(sugar) :-iMakeDinner(tom).

0.7::take(coffee) :-iMakeBreakfast(tom).
0.5::take(coffee) :-iPackLunch(tom).
0.3::take(coffee) :-iMakeDinner(tom).

0.7::take(creamer) :-iMakeBreakfast(tom).
0.5::take(creamer) :-iPackLunch(tom).
0.3::take(creamer) :-iMakeDinner(tom).

0.6::take(bread) :-iMakeBreakfast(tom).
0.6::take(bread) :-iPackLunch(tom).
0.5::take(bread) :-iMakeDinner(tom).

0.2::take(cheese) :-iMakeBreakfast(tom).
0.7::take(cheese) :-iPackLunch(tom).
0.6::take(cheese) :-iMakeDinner(tom).

0.5::take(plate) :-iMakeBreakfast(tom).
0.6::take(plate) :-iPackLunch(tom).
0.6::take(plate) :-iMakeDinner(tom).

0.6::take(bowl) :-iMakeBreakfast(tom).
0.5::take(bowl) :-iPackLunch(tom).
0.6::take(bowl) :-iMakeDinner(tom).

0.7::take(milk) :-iMakeBreakfast(tom).
0.2::take(milk) :-iPackLunch(tom).
0.5::take(milk) :-iMakeDinner(tom).

0.8::take(cereal) :-iMakeBreakfast(tom).
0.1::take(cereal) :-iPackLunch(tom).
0.1::take(cereal) :-iMakeDinner(tom).

0.5::take(butter) :-iMakeBreakfast(tom).
0.6::take(butter) :-iPackLunch(tom).
0.3::take(butter) :-iMakeDinner(tom).

0.5::take(knife) :-iMakeBreakfast(tom).
0.6::take(knife) :-iPackLunch(tom).
0.7::take(knife) :-iMakeDinner(tom).

0.4::take(peanut_butter) :-iMakeBreakfast(tom).
0.6::take(peanut_butter) :-iPackLunch(tom).
0.1::take(peanut_butter) :-iMakeDinner(tom).

0.7::take(spoon) :-iMakeBreakfast(tom).
0.2::take(spoon) :-iPackLunch(tom).
0.6::take(spoon) :-iMakeDinner(tom).

0.5::take(dressing) :-iPackLunch(tom).
0.7::take(dressing) :-iMakeDinner(tom).

0.5::take(salad_tosser) :-iPackLunch(tom).
0.7::take(salad_tosser) :-iMakeDinner(tom).

0.9::take(lunch_bag) :-iPackLunch(tom).

0.7::use(toaster) :-iMakeBreakfast(tom).
0.1::use(toaster) :-iPackLunch(tom).
0.4::use(toaster) :-iMakeDinner(tom).

0.99::take(medicine) :-iTakeMedicine(tom).

0.01::take(popcorn) :-iMakeBreakfast(tom).
0.2::take(popcorn) :-iPackLunch(tom).
0.2::take(popcorn) :-iMakeDinner(tom).
0.8::take(popcorn) :-iWatchMovie(tom).

0.3::use(microwave) :-iMakeBreakfast(tom).
0.3::use(microwave) :-iPackLunch(tom).
0.6::use(microwave) :-iMakeDinner(tom).
0.8::use(microwave) :-iWatchMovie(tom).

0.9::use(plants) :-iTendPlants(tom).

0.3::take(juice) :-iMakeBreakfast(tom).
0.3::take(juice) :-iPackLunch(tom).
0.3::take(juice) :-iMakeDinner(tom).
0.9::take(juice) :-iDrinkJuice(tom).



% -------- Observations ---------
