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
% the pickingstation P associated with order O
orderPS(O,P):-init ( object (order ,O) , value (pickingStation ,P)).

order(O,I,U,0):-init ( object (order ,O) , value (line , pair (I ,U))).



%%%%%%%%%%%%%%%%%%%%%
%% Move definition %%
%%%%%%%%%%%%%%%%%%%%%
% Possible directions for Move action
move(1,0).move(0,1).move(-1,0).move(0,-1).
% Effect of Move action
at(object(robot, R), P+X, Q+Y, T):- object(robot,R), occurs(object(robot, R), move(X, Y), T), at(object(robot ,R), P, Q, T-1),T = 1..m.
at(object(shelf, S), P+X, Q+Y, T):- object(shelf,S),occurs(object(robot, R), move(X, Y), T), at(object(robot, R), P, Q, T-1),carry(R, S, T-1),S!=nada,T = 1..m.

% Two robots cannot be at the same node at the same time
:- at(object(robot, R1), X, Y, T), at(object(robot, R2), X, Y, T), R1!=R2,T=0..m.

% Two shelves cannot be at the same node at the same time
:- at(object(shelf, S1), X, Y, T), at(object(shelf, S2), X, Y, T), S1!=S2,T=0..m.

% Two robots cannot switch locations among each other
:- at(object(robot, R1), X, Y, T-1), at(object(robot, R2), P, Q, T-1), at(object(robot, R1), P, Q, T),at(object(robot, R2), X, Y, T),R1!=R2,T=1..m. 

% Robots cannot be outside the node grid
:- at(object(robot ,R), P, Q, T),not node(P,Q),T=1..m.

{occurs(object(robot, R), move(X, Y), T)}:- object(robot,R),move(X,Y),T=1..m.

%%%%%%%%%%%%%%%%%%%%%%%
%% Pickup definition %%
%%%%%%%%%%%%%%%%%%%%%%%
% Effect of Pickup is Robot R carrying shelf S
% Robot R can only pickup a shelf S if R and S are on the same node at time T-1
carry(R, S, T) :- occurs(object(robot,R),pickup,T), at(object(robot, R), X, Y, T-1), at(object(shelf, S), X, Y, T-1),T = 1..m.

% Robot cannot pick up a shelf if it is already carrying another shelf
:-occurs(object(robot,R),pickup,T),carry(R,S,T-1),S!=nada,T = 1..m.

% Robot R can pickup shelf S if R and S are at the same node at T-1
{occurs(object(robot,R),pickup,T)} :- object(robot,R),at(object(robot, R), X, Y, T-1), at(object(shelf, S), X, Y, T-1),T = 1..m.


%%%%%%%%%%%%%%%%%%%%%%%%
%% Putdown Definition %%
%%%%%%%%%%%%%%%%%%%%%%%%

% Effect of action putdown
at(object (shelf ,S),X,Y,T):- occurs(object(robot,R),putdown,T),at(object (robot ,R),X,Y,T-1),carry(R,S,T-1),T = 1..m.
% Set robot R to carrying nothing after putdown action
carry(R,nada,T):- occurs(object(robot,R),putdown,T),T = 1..m.

%shelves cannot be putdown on highway
:-occurs(object(robot,R),putdown,T),at(object (robot ,R),X,Y,T-1),highway(X,Y),T = 1..m.

{occurs(object(robot,R),putdown,T)} :- object(robot,R),carry(R,S,T-1),S!=nada,T = 1..m.

%%%%%%%%%%%%%%%%%%%%%%%%
%% Deliver Definition %%
%%%%%%%%%%%%%%%%%%%%%%%%

% Preconditions of action deliver: robot R is at the same node with the pickingstation, and the order matches the shelf R is carrying
% The units of delivery is the smaller value of units on shelf and needed units to fulfill the order
{occurs(object(robot,R),deliver(O,I,E),T)}:- at(object(robot,R),X,Y,T-1), pickingStation(P,X,Y), orderPS(O,P), carry(R,S,T-1), U>E,on(I,shelf,S,U,T-1), order(O,I,E,T-1),T = 1..m.
{occurs(object(robot,R),deliver(O,I,U),T)}:- at(object(robot,R),X,Y,T-1), pickingStation(P,X,Y), orderPS(O,P), carry(R,S,T-1), U<=E,on(I,shelf,S,U,T-1), order(O,I,E,T-1),T = 1..m.

% No deliver action for zero unit item
:- occurs(object(robot,R),deliver(O,I,A),T), object(robot,R),A=0,T = 1..m.
:- occurs(object(robot,R),deliver(O,I,A),T), object(robot,R),order(O,I,E,T-1), A>E,T = 1..m.

% Subtracts A (delivery amt) from U (shelf amt), N = shelf num
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


% Only one occurs per robot R at time T
action(move(X,Y)):-move(X,Y).
action(pickup).action(putdown).
:- occurs(object(robot,R),deliver(O,I,P),T),occurs(object(robot, R), A, T),action(A),T = 1..m.
0{occurs(object(robot, R), A, T):action(A)}1:-object (robot ,R),T = 1..m.


#show occurs/3.

