printf "\n"
printf "     ***** RUNNING TEST (MOVE POS X) *****\n"
printf "\n"
clingo warehouse.lp actionTests/move_posx.asp -c m=20 -t4

printf "\n"
printf "     ***** RUNNING TEST (MOVE NEG X) *****\n"
printf "\n"
clingo warehouse.lp actionTests/move_negx.asp -c m=20 -t4

printf "\n"
printf "     ***** RUNNING TEST (MOVE POS Y) *****\n"
printf "\n"
clingo warehouse.lp actionTests/move_posy.asp -c m=20 -t4

printf "\n"
printf "     ***** RUNNING TEST (MOVE NEG Y) *****\n"
printf "\n"
clingo warehouse.lp actionTests/move_negy.asp -c m=20 -t4