init(object(shelf,2),value(at,pair(3,2))).
init(object(pickingStation,1),value(at,pair(3,3))).
init(object(robot,1),value(at,pair(3,2))).
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,pair(1,1))).
init(object(product,1),value(on,pair(2,1))).

carry(1,2,0).
occurs(object(robot,1),move(0,1),1).
occurs(object(robot,1),deliver(1,1,1)).

#show order/4.

% goal
%:-not order(1,1,1,0).
%:-not on(1,shelf,2,1,m).
