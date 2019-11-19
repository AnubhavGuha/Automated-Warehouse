
%%%%%%%%%%%%%%%%%%%%
%% Grid Specifics %%
%%%%%%%%%%%%%%%%%%%%
node(N,X,Y):- init ( object (node ,N) , value (at , pair (X ,Y))).
highway(H,X,Y):- init ( object (highway ,H) , value (at , pair (X ,Y))).
pickingStation(P,X,Y):- init ( object (pickingStation ,P) , value (at , pair (X ,Y))).

%%%%%%%%%%%%%%%%%%%%%
%% Shelf and Robot %%
%%%%%%%%%%%%%%%%%%%%%
object(N,I):- init ( object (N ,I) , value (at , pair (X ,Y))), N!=node, N!=highway, N!=pickingStation.

% Initial position of shelves and robots
at(object (N ,I),X,Y,0):- init ( object (N ,I) , value (at , pair (X ,Y))), N!=node, N!=highway, N!=pickingStation.

% Robot R carrying shelf S
carry(R, S, T+1) :- object(robot, R), object(shelf, S), occurs(object(robot,R),pickup,T).

% Object cannot be in two locations at once
:- at(object (N ,I),X1,Y1,T), at(object (N ,I),X2,Y2,T), X1 != X2.
:- at(object (N ,I),X1,Y1,T), at(object (N ,I),X2,Y2,T), Y1 != Y2.

%%%%%%%%%%%%%
%% Product %%
%%%%%%%%%%%%%
product(N):-init ( object ( product ,N) , value (on , pair (S ,U))).

% U units of Product N on shelf S
on(N,shelf,S,U,0):-init ( object (product ,N) , value (on , pair (S ,U))).

%on(N,pickingStation,P,0,0):- init(object(order,N),value(pickingStation,P)),init(object(order,N),value(line,pair(4,1)))..

%%%%%%%%%%%%
%% Orders %%
%%%%%%%%%%%%
order(N,P,I,U):-init ( object (order ,N) , value (pickingStation ,P)), init ( object (order ,N) , value (line , pair (I ,U))).
on(I,pickingStation,P,0,0):- order(N,P,I,U).


%%%%%%%%%%%%%%%%%%%%%
%% Move definition %%
%%%%%%%%%%%%%%%%%%%%%
move(1,0).
move(0,1).
move(-1,0).
move(0,-1).
at(object(robot, R), P+X, Q+Y, T):- occurs(object(robot, R), move(X, Y), T), at(object(robot ,R), P, Q, T-1).

% Two robots cannot be at the same node together at the same time
:- at(object(robot, R1), X, Y, T), at(object(robot, R2), X, Y, T), R1!=R2.

% Constraint when carrying shelf
:- at(object(robot, R), X, Y, T), object(shelf, S1), carry(R, S1, 1), at(object(shelf, S2), X, Y, T), S1!=S2.

% Two robots cannot switch locations among each other
:- at(object(robot, R1), X, Y, T), at(object(robot, R2), P, Q, T), at(object(robot, R1), P, Q, T+1), at(object(robot, R2), X, Y, T+1), X!=P, Y!=Q. 

%%%%%%%%%%%%%%%%%%%%%%%
%% Pickup definition %%
%%%%%%%%%%%%%%%%%%%%%%%

% Robot R can pickup shelf S at T+1 if not carrying at T
{occurs(object(robot,R),pickup,T)} :- at(object(robot, R), X, Y, T), at(object(shelf, S), X, Y, T).

% Robot cannot carry two different shelves
:- carry(R, S1, T), carry(R, S2, T), S1!=S2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Commonsense law of inertia%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{on(N,K,S,U,T+1)} :- on(N,K,S,U,T), T = 0..m-1.
{at(object (N ,I),X,Y,T+1)} :- at(object (N ,I),X,Y,T), T = 0..m-1.
{carry(R, S, T+1)} :- carry(R, S, T), T = 0..m-1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uniqueness and Existence of value constraints%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-not 1{at(object (N ,I),X,Y,T)}1, object (N ,I), T = 1..m.

#show object/2.
#show at/4.
#show order/4.
#show on/5.