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


%%%%%%%%%%%%%%%%%%%%%%%%
%% Deliver Definition %%
%%%%%%%%%%%%%%%%%%%%%%%%

on(i,S,U-u,t+1):-occurs(object(robot,r),deliver(o,i,u),t),at(object(shelf,S),P,Q,t).

% update order
order(o,P,i,U-u):-occurs(object(robot,r),deliver(o,i,u),t).
%constraints added so items on shelf or order go negative
:-order(o,P,i,u),u<0.
:-on(i,S,u,t),u<0,object(shelf,S).



%disallow deliver if robot is not at pickupstation.
:-occurs(object(robot,r),deliver(o,i,u),t),at(object(robot, r), P, Q, t),at(object(pickingStation, Q), X, Y, t),P!=X,Q!=Y.

%don't allow deliver wrong order
:-occurs(object(robot,r),deliver(o,i,u),t), on(x,S,U,t),x!=i.

%don't allow deliver of wrong item.
:-occurs(object(robot,r),deliver(o,i,u),t), order(o,P,r,u),i!=r,object(pickingStation,P).


%%%%%%%%%%%%%%%%%%%%%%%%
%% Putdown Definition %%
%%%%%%%%%%%%%%%%%%%%%%%%


%effect of and preconditions of action putdown
at(object (shelf ,S),X,Y,T+1):- occurs(object(robot,R),putdown,T),at(object (robot ,R),X,Y,T), carry(R,S,T).
:- occurs(object(robot,R),putdown,T),carry(R,S,T+1), T = 0..m-1.
%shelves cannot be putdown on highway
:-occurs(object(robot,R),putdown,T),at(object (robot ,R),X,Y,T),highway(N,X,Y).

{occurs(object(robot,R),putdown,T)} :- object(robot,R),T = 0..m-1.

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

%%%%%%%%%%%
%% Goals %%
%%%%%%%%%%%
:- not on(I,pickingStation,P,S,m),S = #sum{U,N : order(N,P,I,U)},product(I),pickingStation(P,X,Y).

#show object/2.
#show at/4.
#show order/4.
#show on/5.