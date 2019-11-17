%%% PROFESSOR EXAMPLE
init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(2,1))).
init(object(node,3),value(at,pair(3,1))).
init(object(node,4),value(at,pair(4,1))).
init(object(node,5),value(at,pair(1,2))).
init(object(node,6),value(at,pair(2,2))).
init(object(node,7),value(at,pair(3,2))).
init(object(node,8),value(at,pair(4,2))).
init(object(node,9),value(at,pair(1,3))).
init(object(node,10),value(at,pair(2,3))).
init(object(node,11),value(at,pair(3,3))).
init(object(node,12),value(at,pair(4,3))).
init(object(node,13),value(at,pair(1,4))).
init(object(node,14),value(at,pair(2,4))).
init(object(node,15),value(at,pair(3,4))).
init(object(node,16),value(at,pair(4,4))).

init(object(highway,4),value(at,pair(4,1))).
init(object(highway,8),value(at,pair(4,2))).
init(object(highway,12),value(at,pair(4,3))).
init(object(highway,13),value(at,pair(1,4))).
init(object(highway,14),value(at,pair(2,4))).
init(object(highway,15),value(at,pair(3,4))).
init(object(highway,16),value(at,pair(4,4))).

init(object(pickingStation,1),value(at,pair(1,3))).
init(object(pickingStation,2),value(at,pair(3,1))).

init(object(robot,1),value(at,pair(4,3))).
init(object(robot,2),value(at,pair(2,2))).

init(object(shelf,1),value(at,pair(3,3))).
init(object(shelf,2),value(at,pair(2,1))).
init(object(shelf,3),value(at,pair(2,3))).
init(object(shelf,4),value(at,pair(2,2))).
init(object(shelf,5),value(at,pair(3,2))).
init(object(shelf,6),value(at,pair(1,2))).

init(object(product,1),value(on,pair(3,1))).
init(object(product,2),value(on,pair(4,1))).
init(object(product,3),value(on,pair(6,4))).
init(object(product,4),value(on,pair(5,1))).
init(object(product,4),value(on,pair(6,1))).

init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,pair(1,1))).
init(object(order,1),value(line,pair(3,4))).
init(object(order,2),value(pickingStation,2)).
init(object(order,2),value(line,pair(2,1))).
init(object(order,3),value(pickingStation,2)).
init(object(order,3),value(line,pair(4,1))).



%%%%%%%%%%%%%%%%%%%%
%% Grid Specifics %%
%%%%%%%%%%%%%%%%%%%%
node(N,X,Y):- init ( object (node ,N) , value (at , pair (X ,Y))).
highway(N,X,Y):- init ( object (highway ,N) , value (at , pair (X ,Y))).
pickingStation(N,X,Y):- init ( object (pickingStation ,N) , value (at , pair (X ,Y))).

%%%%%%%%%%%%%%%%%%%%%
%% Shelf and Robot %%
%%%%%%%%%%%%%%%%%%%%%
object(N,I):- init ( object (N ,I) , value (at , pair (X ,Y))), N!=node, N!=highway, N!=pickingStation.

% Initial position of shelves and robots
at(object (N ,I),X,Y,0):- init ( object (N ,I) , value (at , pair (X ,Y))), N!=node, N!=highway, N!=pickingStation.

% Robot R carrying shelf S
carry(R, S, T+1) :- object(robot, R), object(shelf, S), occurs(object(robot,R),pickup,T).


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
#show order/4.
#show on/5.


