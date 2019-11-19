%%%%%%%%%%%
%% Goals %%
%%%%%%%%%%%
:- not on(I,pickingStation,P,S,m),S = #sum{U,N : order(N,P,I,U)},product(I),pickingStation(P,X,Y).