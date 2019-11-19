init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(2,1))).
init(object(node,3),value(at,pair(3,1))).

init(object(robot,1),value(at,pair(1,1))).

% goal
:- at(object(robot, R),3,1,T).