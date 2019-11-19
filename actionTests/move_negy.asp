init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(1,2))).
init(object(node,3),value(at,pair(1,3))).

init(object(robot,1),value(at,pair(1,3))).

% goal
:- at(object(robot, R),1,1,T).