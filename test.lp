  

%%%%%%%%%%%%%%%%%%%%
%% Grid Specifics %%
%%%%%%%%%%%%%%%%%%%%
node(X,P,Q):- init ( object (node ,X) , value (at , pair (P ,Q))).
highway(X,P,Q):- init ( object (highway ,X) , value (at , pair (P ,Q))).
pickingStation(X,P,Q):- init ( object (pickingStation ,X) , value (at , pair (P ,Q))).

%%%%%%%%%%%%%%%%%%%%%
%% Shelf and Robot %%
%%%%%%%%%%%%%%%%%%%%%
object(X,Y):- init ( object (X ,Y) , value (at , pair (P ,Q))), X!=node, X!=highway, X!=pickingStation.

% Initial position of shelves and robots
at(object (X ,Y),P,Q,0):- init ( object (X ,Y) , value (at , pair (P ,Q))), X!=node, X!=highway, X!=pickingStation.

%%%%%%%%%%%%%
%% Product %%
%%%%%%%%%%%%%
product(X):-init ( object ( product ,X) , value (on , pair (S ,U))).

% U units of Product X on shelf S
on(X,S,U,0):-init ( object (product ,X) , value (on , pair (S ,U))).

%%%%%%%%%%%%
%% Orders %%
%%%%%%%%%%%%
order(X,P,I,U):-init ( object (order ,X) , value (pickingStation ,P)), init ( object (order ,X) , value (line , pair (I ,U))).

%%%%%%%%%%%
%% Carry %%
%%%%%%%%%%%
carry(R, S, 1) :- object(robot, R), object(shelf, S), occurs(object(robot,R),pickup,t).

%#show object/2.
%#show at/4.
%#show on/4.
%#show order/4.