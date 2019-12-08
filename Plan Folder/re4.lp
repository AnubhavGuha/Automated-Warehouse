occurs(object(robot,1),action(move,(0,-1)),1). 
occurs(object(robot,2),action(move,(0,-1)),1). 
occurs(object(robot,1),action(move,(-1,0)),3). 
occurs(object(robot,2),action(move,(-1,0)),3). 
occurs(object(robot,2),action(move,(0,1)),5). 
occurs(object(robot,1),action(move,(0,1)),6).
occurs(object(robot,2),action(move,(1,0)),6).
 

occurs(object(robot,1),action(move,(-1,0)),7). 
occurs(object(robot,2),action(move,(0,-1)),8). 
occurs(object(robot,1),action(move,(-1,0)),9). 
occurs(object(robot,2),action(move,(1,0)),9). 
occurs(object(robot,1),action(putdown,()),5). 
occurs(object(robot,2),action(putdown,()),4). 
occurs(object(robot,2),action(pickup,()),2). 
occurs(object(robot,1),action(pickup,()),4). 
occurs(object(robot,2),action(pickup,()),7). 
occurs(object(robot,1),action(pickup,()),8). 
occurs(object(robot,1),action(deliver,(1,1,1)),10). 
occurs(object(robot,2),action(deliver,(2,2,1)),10). 
occurs(object(robot,2),action(deliver,(3,2,2)),10).
