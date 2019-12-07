%%% PROFESSOR EXAMPLE
init ( object (node ,1) , value (at , pair (1 ,1))).
init ( object (node ,2) , value (at , pair (2 ,1))).
init ( object (node ,3) , value (at , pair (3 ,1))).
init ( object (node ,4) , value (at , pair (4 ,1))).
init ( object (node ,5) , value (at , pair (1 ,2))).
init ( object (node ,6) , value (at , pair (2 ,2))).
init ( object (node ,7) , value (at , pair (3 ,2))).
init ( object (node ,8) , value (at , pair (4 ,2))).
init ( object (node ,9) , value (at , pair (1 ,3))).
init ( object (node ,10) , value (at , pair (2 ,3))).
init ( object (node ,11) , value (at , pair (3 ,3))).
init ( object (node ,12) , value (at , pair (4 ,3))).
init ( object (node ,13) , value (at , pair (1 ,4))).
init ( object (node ,14) , value (at , pair (2 ,4))).
init ( object (node ,15) , value (at , pair (3 ,4))).
init ( object (node ,16) , value (at , pair (4 ,4))).
init ( object ( highway ,4) , value (at , pair (4 ,1))).
init ( object ( highway ,8) , value (at , pair (4 ,2))).
init ( object ( highway ,12) , value (at , pair (4 ,3))).
init ( object ( highway ,13) , value (at , pair (1 ,4))).
init ( object ( highway ,14) , value (at , pair (2 ,4))).
init ( object ( highway ,15) , value (at , pair (3 ,4))).
init ( object ( highway ,16) , value (at , pair (4 ,4))).
init ( object ( pickingStation ,1) , value (at , pair (1 ,3))).
init ( object ( pickingStation ,2) , value (at , pair (3 ,1))).
init ( object (robot ,1) , value (at , pair (4 ,3))).
init ( object (robot ,2) , value (at , pair (2 ,2))).
init ( object (shelf ,1) , value (at , pair (3 ,3))).
init ( object (shelf ,2) , value (at , pair (2 ,1))).
init ( object (shelf ,3) , value (at , pair (2 ,3))).
init ( object (shelf ,4) , value (at , pair (2 ,2))).
init ( object (shelf ,5) , value (at , pair (3 ,2))).
init ( object (shelf ,6) , value (at , pair (1 ,2))).
init ( object ( product ,1) , value (on , pair (3 ,1))).
init ( object ( product ,2) , value (on , pair (4 ,1))).
init ( object ( product ,3) , value (on , pair (6 ,4))).
init ( object ( product ,4) , value (on , pair (5 ,1))).
init ( object ( product ,4) , value (on , pair (6 ,1))).
init ( object (order ,1) , value ( pickingStation ,1)).
init ( object (order ,1) , value (line , pair (1 ,1))).
init ( object (order ,1) , value (line , pair (3 ,4))).
init ( object (order ,2) , value ( pickingStation ,2)).
init ( object (order ,2) , value (line , pair (2 ,1))).
init ( object (order ,3) , value ( pickingStation ,2)).
init ( object (order ,3) , value (line , pair (4 ,1))).

%%%%%%%%%%%%%%%%%%%%
%% Grid Specifics %%
%%%%%%%%%%%%%%%%%%%%
node(X,Y):- init ( object (node ,N) , value (at , pair (X ,Y))).
highway(X,Y):- init ( object (highway ,H) , value (at , pair (X ,Y))).
pickingStation(P,X,Y):- init ( object (pickingStation ,P) , value (at , pair (X ,Y))).

%%%%%%%%%%%%%%%%%%%%%
%% Shelf and Robot %%
%%%%%%%%%%%%%%%%%%%%%
object(N,I):- init ( object (N ,I) , value (at , pair (X ,Y))), N!=node, N!=highway, N!=pickingStation.
object(shelf,nada).

% Initial position of shelves and robots
at(object (N ,I),X,Y,0):- init ( object (N ,I) , value (at , pair (X ,Y))),object(N,I).



% Initial relations of robots and shelves
carry(R,nada,0):-object(robot,R).

%%%%%%%%%%%%%
%% Product %%
%%%%%%%%%%%%%
product(N):-init ( object ( product ,N) , value (on , pair (S ,U))).

% U units of Product N on shelf S
on(N,shelf,S,U,0):-init ( object (product ,N) , value (on , pair (S ,U))).


%%%%%%%%%%%%
%% Orders %%
%%%%%%%%%%%%
orderPS(O,P):-init ( object (order ,O) , value (pickingStation ,P)).
order(O,I,U,0):-init ( object (order ,O) , value (line , pair (I ,U))).

occurs ( object (robot ,1) , move ( -1 ,0) ,1).
occurs ( object (robot ,2) , move ( -1 ,0) ,1).
occurs ( object (robot ,1) , move ( -1 ,0) ,2).
occurs ( object (robot ,2) , pickup ,2).
occurs ( object (robot ,2) , move (0 ,1) ,3).
occurs ( object (robot ,1) , pickup ,4).
occurs ( object (robot ,2) , deliver (1 ,3 ,4) ,4).
occurs ( object (robot ,1) , move ( -1 ,0) ,5).
occurs ( object (robot ,2) , move (0 , -1) ,5).
occurs ( object (robot ,1) , deliver (1 ,1 ,1) ,6).
occurs ( object (robot ,2) , putdown ,6).
occurs ( object (robot ,1) , putdown ,7).
occurs ( object (robot ,2) , move (1 ,0) ,7).
occurs ( object (robot ,1) , move (1 ,0) ,8).
occurs ( object (robot ,2) , move (1 ,0) ,8).
occurs ( object (robot ,1) , move (0 , -1) ,9).
occurs ( object (robot ,2) , pickup ,9).
occurs ( object (robot ,1) , pickup ,10).
occurs ( object (robot ,2) , move (0 , -1) ,10).
occurs ( object (robot ,1) , move (1 ,0) ,11).
occurs ( object (robot ,2) , deliver (3 ,4 ,1) ,11).
occurs ( object (robot ,1) , move (0 , -1) ,12).
occurs ( object (robot ,2) , move (1 ,0) ,12).
occurs ( object (robot ,1) , deliver (2 ,2 ,1) ,13).
%:-occurs(object(robot,1),move(X,Y),3),move(X,Y).


%%%%%%%%%%%%%%%%%%%%%
%% Move definition %%
%%%%%%%%%%%%%%%%%%%%%
move(1,0).move(0,1).move(-1,0).move(0,-1).

at(object(robot, R), P+X, Q+Y, T):- object(robot,R), occurs(object(robot, R), move(X, Y), T), at(object(robot ,R), P, Q, T-1),T = 1..m.
at(object(shelf, S), P+X, Q+Y, T):- object(shelf,S),occurs(object(robot, R), move(X, Y), T), at(object(robot, R), P, Q, T-1),carry(R, S, T-1),S!=nada,T = 1..m.

% Two robots cannot be at the same node together at the same time
:- at(object(robot, R1), X, Y, T), at(object(robot, R2), X, Y, T), R1!=R2,T=0..m.

% Constraint when carrying shelf
%:- at(object(robot, R), X, Y, T), object(shelf, S1), carry(R, S1, T), at(object(shelf, S2), X, Y, T), S1!=S2.
:- at(object(shelf, S1), X, Y, T), at(object(shelf, S2), X, Y, T), S1!=S2,T=0..m.

% Two robots cannot switch locations among each other
:- at(object(robot, R1), X, Y, T-1), at(object(robot, R2), P, Q, T-1), at(object(robot, R1), P, Q, T),at(object(robot, R2), X, Y, T),R1!=R2,T=1..m. 

% Robots cannot move outside the node grid
:- at(object(robot ,R), P, Q, T),not node(P,Q),T=1..m.
{occurs(object(robot, R), move(X, Y), T)}:- object(robot,R),move(X,Y),T=1..m.

%%%%%%%%%%%%%%%%%%%%%%%
%% Pickup definition %%
%%%%%%%%%%%%%%%%%%%%%%%
% effect of Pickup is Robot R carrying shelf S
carry(R, S, T) :- occurs(object(robot,R),pickup,T), at(object(robot, R), X, Y, T-1), at(object(shelf, S), X, Y, T-1),T = 1..m.

:-occurs(object(robot,R),pickup,T),carry(R,S,T-1),S!=nada,T = 1..m.
% Robot R can pickup shelf S if R and S are at the same node at T-1
{occurs(object(robot,R),pickup,T)} :- object(robot,R),at(object(robot, R), X, Y, T-1), at(object(shelf, S), X, Y, T-1),T = 1..m.

% Robot cannot carry two different shelves
%:- carry(R, S1, T), carry(R, S2, T), S1!=S2.

%%%%%%%%%%%%%%%%%%%%%%%%
%% Putdown Definition %%
%%%%%%%%%%%%%%%%%%%%%%%%


%effect of and preconditions of action putdown
at(object (shelf ,S),X,Y,T):- occurs(object(robot,R),putdown,T),at(object (robot ,R),X,Y,T-1),carry(R,S,T-1),T = 1..m.
carry(R,nada,T):- occurs(object(robot,R),putdown,T),T = 1..m.

%shelves cannot be putdown on highway
:-occurs(object(robot,R),putdown,T),at(object (robot ,R),X,Y,T-1),highway(X,Y),T = 1..m.
{occurs(object(robot,R),putdown,T)} :- object(robot,R),carry(R,S,T-1),S!=nada,T = 1..m.

%%%%%%%%%%%%%%%%%%%%%%%%
%% Deliver Definition %%
%%%%%%%%%%%%%%%%%%%%%%%%

%matching X and Y coords between robot, matching I (product id) between deliver and order and shelf, matching P (picking station) for order and P, delivered amount is either U (shelf amt) or E (order amt)
{occurs(object(robot,R),deliver(O,I,E),T)}:- at(object(robot,R),X,Y,T-1), pickingStation(P,X,Y), orderPS(O,P), carry(R,S,T-1), U>E,on(I,shelf,S,U,T-1), order(O,I,E,T-1),T = 1..m.
{occurs(object(robot,R),deliver(O,I,U),T)}:- at(object(robot,R),X,Y,T-1), pickingStation(P,X,Y), orderPS(O,P), carry(R,S,T-1), U<=E,on(I,shelf,S,U,T-1), order(O,I,E,T-1),T = 1..m.
:- occurs(object(robot,R),deliver(O,I,A),T), object(robot,R),A=0,T = 1..m.
:- occurs(object(robot,R),deliver(O,I,A),T), object(robot,R),order(O,I,E,T-1), A>E,T = 1..m.
% subtracts A (delivery amt) from U (shelf amt), N = shelf num
on(I,shelf,N,U-A,T) :- occurs(object(robot,R),deliver(O,I,A),T), on(I,shelf,N,U,T-1),T = 1..m.
order(O,I,E-A,T):- occurs(object(robot,R),deliver(O,I,A),T), order(O,I,E,T-1),T = 1..m.
:- order(O,I,E,T), E<0,T = 1..m.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Commonsense law of inertia%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{on(N,K,S,U,T+1)} :- on(N,K,S,U,T), T = 0..m-1.
{at(object (N ,I),X,Y,T+1)} :- at(object (N ,I),X,Y,T), T = 0..m-1.
{carry(R, S, T+1)} :- carry(R, S, T), T = 0..m-1.
{order(O,I,E,T+1)}:- order(O,I,E,T), T = 0..m-1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uniqueness and Existence of value constraints%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-not 1{at(object (robot ,R),X,Y,T)}1, object (robot ,R),T = 1..m.
:-not 1{at(object (shelf ,S),X,Y,T)}1,object(shelf,S),S!=nada,T = 1..m.
:-not 1{carry(R,S,T)}1, object (robot ,R),T = 1..m.

:-not 1{order(O,I,E,T)}1,order(O,I,U,0), T = 1..m.


action(move(X,Y)):-move(X,Y).
action(pickup).action(putdown).
:- occurs(object(robot,R),deliver(O,I,P),T),occurs(object(robot, R), A, T),action(A),T = 1..m.
0{occurs(object(robot, R), A, T):action(A)}1:-object (robot ,R),T = 1..m.

%%%%%%%%%%%
%% Goals %%
%%%%%%%%%%%
%:- not order(O,I,E,m),init ( object (order ,O) , value (line , pair (I ,U))), E=0 .

#show occurs/3.
#show at/4.
#show order/4.
%#show carry/3.
