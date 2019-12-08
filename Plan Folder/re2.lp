
occurs(object(robot,1),action(move,(-1,0)),1). 
occurs(object(robot,2),action(move,(0,1)),1). 
occurs(object(robot,1),action(move,(0,-1)),2). 
occurs(object(robot,2),action(move,(-1,0)),3). 
occurs(object(robot,1),action(move,(1,0)),4). 
occurs(object(robot,1),action(move,(0,1)),5). 
occurs(object(robot,2),action(move,(0,-1)),5). 
occurs(object(robot,1),action(move,(0,1)),6).
occurs(object(robot,1),action(move,(-1,0)),7). 
occurs(object(robot,2),action(move,(1,0)),7).
occurs(object(robot,1),action(move,(-1,0)),8). 
occurs(object(robot,1),action(move,(-1,0)),9). 
occurs(object(robot,2),action(move,(1,0)),9).
occurs(object(robot,1),action(move,(0,-1)),10). 
occurs(object(robot,2),action(move,(0,-1)),10).
occurs(object(robot,2),action(putdown,()),6). 
occurs(object(robot,2),action(pickup,()),2). 
occurs(object(robot,1),action(pickup,()),3).
occurs(object(robot,2),action(pickup,()),8). 
occurs(object(robot,2),action(deliver,(1,1,1)),4).
occurs(object(robot,2),action(deliver,(2,2,1)),11). 
occurs(object(robot,1),action(deliver,(1,3,2)),11).



