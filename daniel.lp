occurs(object(robot,r),pickup,t) :- 

on(shelf, robot, t+1) :- occurs(object(robot,’r’),pickup,’t’)
