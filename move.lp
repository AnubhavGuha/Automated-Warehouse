%%%%%%%%%%%%%%%%%%%%%
%% Move definition %%
%%%%%%%%%%%%%%%%%%%%%
at(object(robot, R), P+X, Q+Y, T):- occurs(object(robot, R), move(X, Y), T), at(object(robot ,R), P, Q, T-1).

% Two robots cannot be at the same node together at the same time
:- at(object(robot, R1), P, Q, T), at(object(robot, R2), P, Q, T), R1!=R2.

% Constraint when carrying shelf
