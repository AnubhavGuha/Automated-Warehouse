# cse579_autowarehouse
__[Final Project Report Link](https://drive.google.com/file/d/1ePJYVsW2RGq6_JAHh-t9gOMyVIYSZ0KO/view?usp=sharing)__
> Team Members: Yi-Chuan Lin, Anubhab Guha, Daniel Pilgrim-Minaya, Kanisk Bashyam
 
----
## Running Scenarios

Every Scenario run needs the following properties:

1. __Warehouse Definition__
2. __Initializations and Goal__
3. __Output__
4. __Time Parameter__

| Property | Description |
| ------ | ----------- |
| Warehouse Definition   | Core of the project, contained in warehouse.lp |
| Initializations and Goal | Initialization functions for objects (init()'s) to define a warehouse scenario, additional goal clause
| Output    | Display output of satisfiable solutions for scenario |
| Time Parameter    | Definition for m (max timestep) |
---

Example Runs
---
### Inst1 Scenario
Warning: Not functional yet
```
clingo warehouse.lp simpleinstances/inst1.asp output/occurs_result.lp -t4
```
| Property | Option Used |
| ------| -----------|
| Warehouse Definition   | Standard Warehouse, __warehouse.lp__ |
| Initializations and Goal | Used professor's given scenario in __simpleinstances/inst1.asp__, automatically includes goal clause in __simpleinstances/projectgoal.lp__  |
| Output    | Only display Occur actions, like in professor's output example __output/projectgoal.lp__  |
| Time Parameter    | Minimalization function, not decided on yet |


---
### Test Move Positive X Scenario
```
clingo warehouse.lp actionTests/move_posx.asp output/debug.lp -c m=20 -t4
```
| Property | Option Used |
| ------| -----------|
| Warehouse Definition   | Standard Warehouse, __warehouse.lp__ |
| Initializations and Goal | Uses Move Pos X scenario and goal clause in __actionTests/move_posx.asp__  |
| Output    | Uses Debug Display Output in __output/debug.lp__  |
| Time Parameter    | Allows 20 movements starting at timestep 0 and ending at timestep 20 |

One can also test all actions with 
```
./test_all_actions.sh 
```


