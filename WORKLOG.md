# Work Log

## Dev Log (this is 3 pages on google docs, so scroll down for my commit history
Part 1: Working features

- Key Controls
 - Press any key, aside from ‘r’, to go to the “next mode.” Modes are as follows:
 - 1-5: Utility modes
  - 1: Move around nodes by mouse drag
  - 2: Add a node on screen by mouse click, the node will appear there
  - 3: Delete a node via mouse click, if a node is located there
  - 4: Add an edge between two nodes (you can deselect the first node) by clicking on two nodes  
  - : Remove an edge via mouse click, if an edge is located there
 
 - 6-10: Algorithm modes
  - They are, in that order: Bipartite coloring, cycle detection, topological sort, spanning tree, and convex hull. See my README in my final project repo on details about how these algorithms work specifically.


- If you click on the screen while in an algorithm mode, the algorithm is precomputed, and then the visualization of the algorithm automatically starts. As mentioned in my README:
How the visuals appear depends on the specific algorithm, but for all algorithms, a change in the color of a node represents a change in its "state", whether that's from being unvisited -> visited, processed -> finished (e.g. for topological sort), and so on and so forth. (And for convex hull / spanning tree, green edges = edges added).


- Press ‘r’ to reset a graph visualization while it is currently being shown. (Resets all visual effects, in other words)


- Press 1 to go to the first utility mode, as a keyboard shortcut.
- Press 2 to go to the first algorithm mode, as a keyboard shortcut.


- Text Boxes and User Options
 - In addition to the visuals, I've also included a "text box" that tells the user what's currently occuring in the algorithm as the algorithm is visualized for the user. (e.g. nodes being visited, or a cycle was detected, etc.)
Users can also reset the graph or delete all edges, or change the directionality of edges via text buttons. They can also randomize the colors of node states of all algorithms (via text button), if that is something that they are interested in. 


- Other technical features
 - All edges are either directed or undirected, and the user can switch edge types whenever they want to, via a text button. 


- Part 2: Broken features/bugs
 - I’ve tested my code pretty thoroughly, and I haven’t detected any “broken” features or bugs. Of course, this doesn’t mean that my code definitely does not have any bugs; it’s just that I haven’t seen any bugs. 

 - Which brings me to these two points:
  - 1) Do things in order. In other words, try not to use another algorithm if an algorithm is already being visualized, and you haven’t reset it yet. 
  -> That being said, I did implement measures to override the current algorithm visualization if you decide to do this.


   -> I also prevent the user from deleting nodes if an algorithm is currently being visualized.


  - 2) If you do 1), then you shouldn’t encounter any bugs. If you don’t, maybe you’ll run into an assertion error? I don’t know, but if you really try to mess with my code, then you might, considering I have a lot of assertions in my code that I used for debugging reasons. 
  -> That being said, I haven’t run into any assertion errors.


  - 3) You might encounter bugs if you use an algorithm that may produce unexpected results for a certain edge type (for example, a bipartite coloring is meant for undirected graphs, and can produce unexpected results for a directed graph). This is mentioned in the text box of my graph visualizer.


- Part 3: Resources that I used
 - I mentioned the below in my prototype, my README, and the Convex Hull and Algorithm classes (as comments):


 - I have to give credit to USACO.guide for teaching me how certain algorithms work, including DSU (used in Spanning Tree) and Convex Hull. The sample code they provided also helped me write my c++ code snippets (They were pre-written before the final project, when I was doing competitive programming), which I then used as reference to write my java code. 

 - The particular links to DSU and Convex Hull are:
  - https://usaco.guide/gold/dsu?lang=cpp
  - https://usaco.guide/plat/convex-hull?lang=cpp


- As an another note that I’ve mentioned a lot of times already (see README for info):
 - The c++ code for DSU and Convex Hull that I have commented out in these two classes (which I used as a reference to write my java code) were used by me when I submitted code to cses.fi, an online problem judge.

- This means that the code snippets may or may not be detected as “plagiarism,” which I definitely am not doing. My username on cses.fi is Coding Sucks, and here are the links to specific problems that I submitted code for, in which I used either DSU or Convex hull code snippets:


- Spanning Tree
 - https://cses.fi/problemset/result/5413923/
 - https://cses.fi/problemset/result/6155448/

- Convex Hull
 - https://cses.fi/problemset/result/6185951/

## GROUP MEMBER 1
Stanley Tung (I'm working by myself)
For info on the specifics, check my commits: They mention what I mention in this worklog.
**For updated prototype, a google docs version of my devlog, and other stuff, please see "Group Info." **


### Day 1: Monday, May 22nd 
Classwork:
- created essential classes for graph visualizer (Node, Graph, Edge, Algorithm)
- Started writing Node class (I was writing out methods that I mentioned in my UML diagram)
- Started structuring my main program (add setup, draw, space for important setup variables and event functions, e.g. mousePressed)

Homework:
- Wrote edge and node classes (I might add more to them later) 
  - Wrote edge and node display methods: They display properly (edges change when nodes move) 
- Current main program involves: Arraylist of nodes and edges that change based on user input.
  - Added both default (setup - e.g. node color) and important (e.g. mode of user input) variables to main program
  
- Wrote five different modes of user input:
  - 1: Mouse drag / default: User can click and drag nodes around the screen. 
  - 2: Add node: User can click on a location and a node will be added. 
  - 3: Remove node: User can click on a location. If a node exists, it will be deleted, and so will its edges. 
  - 4: Add edge: User has to select two nodes (highlighted) to add edge. The first node can be deselected. 
  - 5: Delete edge: User can click to delete an edge if it exists near click location. 
In terms of how much I tested the five modes:
   - I'm pretty confident they all work fine. #4 is the most technical and it works as of now, but I'll see if
   something happens with it later on.

- Started working on graph class 
  - Basic information: adjacency list, nodes, edges, etc...
  - Started formatting methods (addNode, removeNode, etc...)
  
### Day 2: Tuesday, May 23rd 
Classwork:
- Fixed issue with mode 4, or add edge: Before if you clicked on two nodes already with an edge, a new edge is still created. I've fixed that issue by prohibiting redundant edges (edges are bidirectional for now, but that may change for different algorithms I decide to implement)

- Started to move methods from my main program (findEdge, removeEdges; i.e. helper functions) into the Graph class so that I can call the methods from a graph in main program later on. I also plan to store nodes, edges, etc.. all into the graph class.

Homework - Graph class:
- Wrote addNode(), deleteNode(), addEdge(), deleteEdge(): I haven't tested them, but I will doing that later. I also wrote some other versions of deleteEdge() and addNode() with different parameters.

- Wrote toString() of adjacency list to help with later debugging 

- My graph class currently relies on these things for information storing:
 - Nodes have a 1-1 correspondence with integer id
 - Edges are stored in both adjacency list and array list

- Commented out my main program code except for setup so that I can test my graph class later 

Main Branch: Merge #1
- At this point, I will merge my demo branch into my main branch, since I've commented out my code (for now) and I'll be testing my graph class later on.

### Day 3: Wednesday, May 24th
Classwork:
- Started rewriting user input in the main program to be processed using graph class methods. 
  - I am currently testing graph.addNode(), addEdge(), removeNode(), and removeEdge() 
  -
- Figured out an issue with deleteNode() (Some edges are not removed for some reason), which I will need to fix

Homework:
- Today was a busy day for me, so I did not have any time to work on the project for homework.

### Day 4: Thursday, May 25th
Classwork:
- Fixed issue with edges not being properly deleted from graph class, when I call removeEdges() within the class.
 - I wasn't deleting the correct edge since I did not send the correct reference to the adjacency list, but I've fixed that by editing removeEdges in the graph class.

- Finished adding and testing other user input methods (add node, remove edge, add edge) to be compatible with methods inside the graph class. My graph seems to be functional (for now), but future bugs may or may not occur. (Hopefully not)

- At this point: I'm going to start writing algorithms for my graph visualizer. I started this in class by writing the Algorithm class.
 - Started organizing Algorithm methods (run(), quit(), etc...)
 - algorithms will likely extend the Algorithm class

Homework:
Main Branch: Merge #2
- Since I've tested my graph methods for compatability with user input and it seems to be functional, I'll merge my demo code into the main branch. 
- Once I've tested the algorithm class, I'll do another merge, but that'll take a while.

- Started working on writing Algorithms
   - Started writing code for Bipartite coloring algorithm
    - This can be done with DFS + some extra arrays for storing states

- There's a larger issue, though: How do I synchronize the graph visualizer with the execution of my algorithm?
 - I spent a hour on this issue which is why I didn't commit that much
   - I figured out that waiting() in the code itself pauses the entire program, whereas I want more of a multithreading effect
   
- I'm probably going to have to resort to storing all graph visual transitions in a queue and then updating the graph in the draw() function

### Day 5: Friday, May 26th
Classwork:
- Continued writing base code for algorithms -- base code as in the algorithm themselves. I need to write that first before I implement the visual aspect of the algorithm visualizer.
   - I worked on base code for two algorithms:
    - Cycle detection (I wrote the code, but didn't test it)
    - Topological sort (I finished the psuedocode, but didn't get to write the code yet)
 
 - Over the weekend I'll likely write some algorithms and then test them all, before deciding how to visualize the algorithms.
 
 Homework:
 - It's a Friday and I haven't gotten any rest, so I am not working today.

### Day 6: Saturday, May 27th
Classwork: N/A (it's the weekend)

Homework (I did a bunch of stuff, so I'm just going to reiterate what I mentioned in my git commits):

Algorithm classes:
- Rewrote Bipartite coloring algorithm's DFS - I also decided, at this point, to rely entirely on node instance variables to determine node states,
  e.g. visited or unvisited, and so on

- Topological sort class: Organized code better, added new variables (arraylists for sorting order), and a recursion
  stack to display a cycle if it exists. Then I completed the code

- Cycle detection class: It's the same idea as the topological sort, so I used that code and then edited it a bit.

- Technical stuff:
  - Added "done" variable to Algorithm class so algorithm can end early if it needs to

Visual updates:
- Wrote code to visualize arrows of directed edges using some vectors -- Also made
   the "bidirectional" global setting in main program compatible with determining directionality of edges

- Created Transition class for visual updates of graph visualizer
  - Transition has info: (Node/edge, initial color, target color) and the object will transition colors using linear interpolation
  - Wrote a feedback loop in draw() function to process transitions sequentially (one transition per time step)
   - I later modified this to process transitions in "batches" -- all transitions in the same "batch" will simultaneously
     occur per time step

- In Algorithm:
 - Added methods addTransition(node or edge), addState(node or edge) -> transitions colors based on change in states, 
   with each state corresponding to a change in color
   
- Added reset() method to reset graph to original state before algorithm occured

### Day 7: Sunday, May 28th
Classwork: N/A (it's the weekend)

Homework:
- Made processing transitions in draw() more efficient

Merge #3: (This was when I only supported Bipartite coloring algorithm)
- Merged to main branch since I had written 3 algorithms and one of them was visually compatible.
- Also removed old code from main program


- Graph visualizations:
- Added support for Bipartite graph visualization and tested it -- now this algorithm can be
  visualized on the graph!
    - The graph colors nodes with 2 colors such that no node has neighbors of the same color
    - If a bipartite coloring does not exist, the last node will be colored as green 

- Added support for Cycle detection graph visualization
  - Visited nodes are colored blue, and if a cycle exists, the cycle is simultaneously colored green
  
- Added support for Topological sort graph visualization
  - The code is similar to cycle detection; visited nodes are colored (purple), and if a cycle exist,
   it is labeled green. The catch here is that if a topological sort exists, then nodes will be colored
   in the order of the topological sort at the end of the graph visualization.

- Added support for Minimum Spanning Tree graph visualization
 - This uses Disjoint-Set Union to merge connected components together while the spanning tree is constructed
 - Different components have different colors; when a component merges into another, all of its nodes' colors
   are replaced with the larger component's colors
 - Edges that are in the MST are marked green
 
 - The colors that I decide to use are arbitrary, and I might include support for color customization (probably not, though)
   if I have enough time to do so.
 
 Text labels:
 - Added support (kind of, I'm still testing it to make it work) for displaying weight labels of edges, although my code
 currently does not let users determine weight of edges
 
 - Made TextBox class to display what's going on in algorithm as the graph visualization occurs
   - Added pushMessage() and addMessage() in Algorithm class, which is similar to Transition class
   - Then, I added support for displaying text messages of Bipartite coloring algorithm as the graph runs

### Day 8: Monday, May 29th
Classwork: N/A (it's Memorial Day)

Homework: 
- Improved messages for Bipartite coloring algorithm by modifying DFS code
- I didn't do anything else today, since I had other things to do. 

## Day 9: Tuesday, May 30th
Classwork:
- Fixed issue with graph visualization not being reset when you press 'r' key, and you are currently in a mode that is not an Algorithm
- Added text message support for Cycle detection and topological sort -- They now output messages of what's going on,
as
- Updated worklog for Monday, May 29th (Day 8) 

Homework:
- I was very tired, so I did not work (in terms of HW) on this day.

## Day 10: Wednesday, May 31st
Classwork:
Main branch: Merge #4:
- Merged to main branch: At this point, I support graph visualization and text output for 4 algorithms: Bipartite coloring,
Cycle detection, Topological sort, and Spanning Tree

Homework:
- Wrote a textbox that allows uers to change edge types (from directed/undirected and vice versa), but ran into some issues
  - For one, it was pretty buggy to turn directed edges into undirected edges
  - I was trying to debug it, but I figured it would be better if I just reset the entire graph to make things convenient 
  
## Day 11, Thursday, June 1st
Classwork: N/A (it's Regents)

Homework:
- Fixed textbox so that it lets user change edge types without any issues 
  - The graph is reset when this occurs, to avoid technical issues
  - 
- Also added two additional textboxes:
 - One textbox allows you to reset the graph without changing edge modes
 - Another textbox allows you to delete all the edges in the graph

- Fixed an issue with cycle detection in directed graphs
  - It turns out I need to mark nodes are "done" after it is done processing; otherwise, extraneous "cycles" might be detected.
 
 Main Branch: Merge #5:
- At this point, I've added text boxes so the user can:
   - Know what's going on in the algorithm
   - Change type of edges (directed or undirected)
   - Reset graph or remove all edges from graph
   - And a textbox is there to tell reader about keyboard short cuts

- I've also finished my graph visualizations for the 4 algorithms that
I've described previously.

- So I think I'm pretty much done with all the essential things
that I need to include in my graph visualizer. I'll be focusing on more
of "miscellaneous" things if I have the time to do so, in terms of adding
more to my graph visualizer project.

Additional note: I think with Merge #5, that's going to be my demo for this project.
I might add more stuff later, but I think what I have so far includes all the things that
I need to include in my project.


## Days 12-14: From Friday, June 2nd to Sunday, June 4th
- I didn't have any time to work on the project on these days. (I have a bunch of tests coming up!!!)
- However, I did notice one issue with my code as I was running my demo code.
   - I need to call deleteNodes() to remove nodes from arraylist, in my method for resetting the graph.
- Hopefully I'll have some time to work on the project next week, but I'll see.   

- An update, since I did some work on Sunday:
 - Added textbox option for users to randomize state colors of nodes
 - Added method in main program to let users scale size of textboxes if they want to change size of the screen


## Day 15: Monday, June 5th
Classwork: N/A (Class presentations)

Homework: 
- Started working on Convex Hull class
  - Wrote demo code (in a different coding language) as a reference for my convex hull code
  - Wrote utility methods (cross product, length of vector)
  - Wrote constructor and some algorithm variables (e.g. arraylist for convex hull)  
  - Finished writing sortPoints(), which sorts points in counterclockwise order
   - (My convex hull algorithm, if I have enough time, is going to use a stack to find the convex hull.)
  
## Day 16: Tuesday, June 6th
- I didn't have any time to work on the project, as I needed to study for other assessments. 
- I'll likely implement convex hull (if I have time) on Thursday, when there's a day off from school. 

## Day 17: Wednesday, June 7th
- I will start off by noting that Days 15-16 are should actually be days 16-17, since I I started "Day 15"'s work
after 12:00 AM, but I decided to call Day 15 "Monday" anyways. 

Classwork: N/A (Class presentations)

Homework:
- Finished writing code for Convex Hull class
  - Wrote begin(), reset() for Convex Hull
   - Tested if methods (sortPoints() and generateHull()) worked with visual transitions
  - Added code to visualize points and edges in convex hull
  - Added text message support for Convex HUll algorithm

## Day 18: Thursday, June 8th
Classwork: N/A (no school today)

Homework:
- Modified convex hull algorithm to return if there's no nodes in the graph
 -  Credit to USACO.guide for teaching me the idea of Convex Hull
 -  Credit to USACO.guide for teaching me idea of DSU, which is used in Spanning Tree
 -  NOTE: See the classes for more info concerning the fact that the code snippets that I have for these
 respective classes are on cses.fi (online judge where you submit code to problems), as I used these
 code snippets to submit code on cses.fi. FYI, My username is Coding Sucks.
 
- Modified README to explain how convex hull algorithm works

Merge #6:
- At this point, I've implemented five algorithms to be visualized, and I have text boxes where users
can customize the graph (e.g. randomize colors of node colors, reset graph, change directionality of graph),
so I think I am about done with the project. I will be merging my demo branch into the main branch (possibly
more than once if I find some bugs in my code).

## Day 19: Friday, June 9th
- Drew updated UML diagram
- Wrote updated prototype document 
- Made a note about how my C++ reference code (that I wrote) for convex hull in the Convex Hull class,
might be detected as "plagiarism" (again, I wrote the code) on the internet. In particular I submitted
the code to cses.fi to test if the reference code is correct or not. See my code submission link in the README. (Username: Coding Sucks)

My project is pretty much done at this point, so I don't expect to do much work over the weekend! 

## Days 20-21: Saturday/Sunday
- I realized my topological sort was displayed in the opposite order, so I fixed that
- NOTE: I only edited from the main branch from Days 19-21 because I was done with the code aspect of my project. All the edits were to
update the README, worklog, or give credit to sources like USACO.guide.
- Tested code for bugs (doesn't seem to be any, at least from my side) 

**For my devlog (all working features, etc..) as well as my updated prototype, please see "Group Info."** 
