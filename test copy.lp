
%%%%%%%%%%%%%%%%%%%%
%% Grid Specifics %%
%%%%%%%%%%%%%%%%%%%%
node(N,X,Y):- init ( object (node ,N) , value (at , pair (X ,Y))).
highway(N,X,Y):- init ( object (highway ,N) , value (at , pair (X ,Y))).
pickingStation(N,X,Y):- init ( object (pickingStation ,N) , value (at , pair (X ,Y))).

%%%%%%%%%%%%%%%%%%%%%
%% Shelf and Robot %%
%%%%%%%%%%%%%%%%%%%%%
object(N,Y):- init ( object (N ,Y) , value (at , pair (X ,Y))), N!=node, N!=highway, N!=pickingStation.

% Initial position of shelves and robots
at(object (N ,Y),X,Y,0):- init ( object (N ,Y) , value (at , pair (X ,Y))), N!=node, N!=highway, N!=pickingStation.

% a robot can only take one action at a time (robot cannot move to two locations or move and pickup shelf at same time)
occurs(object(robot, R), A1, T), occurs(object(robot, R), A2, T).

% Robot R carrying shelf S
carry(R, S, T+1) :- object(robot, R), object(shelf, S), occurs(object(robot,R),pickup,T).

%%%%%%%%%%%%%
%% Product %%
%%%%%%%%%%%%%
product(N):-init ( object ( product ,N) , value (on , pair (S ,U))).

% U units of Product N on shelf S
on(N,S,U,0):-init ( object (product ,N) , value (on , pair (S ,U))).

%on(N,pickingStation,P,0,0):- init(object(order,N),value(pickingStation,P)),init(object(order,N),value(line,pair(4,1)))..

%%%%%%%%%%%%
%% Orders %%
%%%%%%%%%%%%
order(N,X,I,U):-init ( object (order ,N) , value (pickingStation ,X)), init ( object (order ,N) , value (line , pair (I ,U))).


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


%%%%%%%%%%%
%% Goals %%
%%%%%%%%%%%
:- not on(I,pickingStation,P,S,m),S = #sum{U,N : order(N,P,I,U)},product(I),pickingStation(P,X,Y).


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
#show on/4.
#show order/4.