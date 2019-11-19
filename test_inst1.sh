printf "\n"
printf "     ***** RUNNING TEST (INST 1) *****\n"
printf "\n"
clingo warehouse.lp simpleinstances/projectgoal.lp simpleinstances/inst1.asp -c t=1 -t4


printf "\n"
printf "     ***** DISPLAYING TARGET OUTPUT (INST 1) *****\n"
printf "\n"
cat simpleInstances/output1.txt