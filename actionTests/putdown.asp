init(object(robot,1),value(at,pair(3,3))).
init(object(shelf,2),value(at,pair(4,3))).

carry(1,2,0).
occurs(object(robot,1),putdown,0).


% goal
not at(object (shelf ,2),3,3,1).