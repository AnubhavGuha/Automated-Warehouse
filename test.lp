
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