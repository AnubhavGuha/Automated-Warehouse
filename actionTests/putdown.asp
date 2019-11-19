object(robot,1).
at(object (robot ,1),3,3,0).
object(shelf, 2).
carry(1,2,0).
occurs(object(robot,1),putdown,0).

% goal
not at(object (shelf ,2),3,3,1).