object(robot,1).
at(object (robot ,1),3,2,0).
object(shelf, 2).
init(object(shelf,2),value(at,pair(3,2))).

init(object(pickingStation,1),value(at,pair(3,3))).
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,pair(1,1))).
init(object(product,1),value(on,pair(2,1))).


occurs(object(robot,1),pickup,0).
occurs(object(robot,1),
occurs(object(robot,1),deliver(1,1,1),1).


% goal
not at(object (shelf ,2),3,3,1).