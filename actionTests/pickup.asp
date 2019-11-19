object(robot,1).
object(shelf, 2).
at(object (robot ,1),3,3,0).
at(object (shelf ,2),3,3,0).
occurs(object(robot,1),pickup,0).

% goal
:- not carry(1,2,1).