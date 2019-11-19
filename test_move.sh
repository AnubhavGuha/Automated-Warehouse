printf "\n"
printf "     ***** RUNNING TEST (MOVE POS X) *****\n"
printf "\n"
clingo warehouse.lp actionTests/move_negx.asp -c t=1 -t4

printf "\n"
printf "     ***** RUNNING TEST (MOVE NEG X) *****\n"
printf "\n"
clingo warehouse.lp actionTests/move_posx.asp -c t=1 -t4

printf "\n"
printf "     ***** RUNNING TEST (MOVE POS Y) *****\n"
printf "\n"
clingo warehouse.lp actionTests/move_posy.asp -c t=1 -t4

printf "\n"
printf "     ***** RUNNING TEST (MOVE NEG Y) *****\n"
printf "\n"
clingo warehouse.lp actionTests/move_negy.asp -c t=1 -t4