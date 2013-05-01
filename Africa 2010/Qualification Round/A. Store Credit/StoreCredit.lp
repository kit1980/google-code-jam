% see StoreCredit-potassco.py

choose(I, J) :- I < J, item(I, X), item(J, Y), credit(C), X + Y == C.
#hide.
#show choose/2.
