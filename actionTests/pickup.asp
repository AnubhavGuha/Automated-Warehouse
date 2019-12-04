init(object(robot,1),value(at,pair(3,3))).
init(object(shelf,2),value(at,pair(3,3))).

occurs(object(robot,1),pickup,0).

% goal
:- not carry(1,2,1).