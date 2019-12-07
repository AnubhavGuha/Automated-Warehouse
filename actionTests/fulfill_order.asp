% Robot in node1 picks up shelf in node2 and crosses highway in node 3 to deliver to pickup in node 4
% inits table
init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(2,1))).
init(object(node,3),value(at,pair(3,1))).
init(object(node,4),value(at,pair(4,1))).

% inits robot 1
init(object(robot,1),value(at,pair(1,1))).

%% SHELF
% inits shelf 1
init(object(shelf,1),value(at,pair(2,1))).
% inits product 1 on shelf 1 of amount 2
init(object(product,1),value(on,pair(1,2))).

% inits highway
init(object(highway,4),value(at,pair(3,1))).

%% PICKING STATION AND ORDER
% inits pickingstation 3
init(object(pickingStation,3),value(at,pair(4,1))).
% defines order 4 as product 1 of amount 2
init(object(order,4),value(line,pair(1,2))).
% inits order 4 at pickingstation 3
init(object(order,4),value(pickingStation,3)).

# order 4 at pickingstation 3 of product 1 has amount 0
:- not order(4,3,1,0).