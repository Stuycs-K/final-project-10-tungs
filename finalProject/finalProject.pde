import java.util.ArrayDeque; 
// Initial variables
color initialColor = color(255, 0, 0);
color backgroundColor = color(255, 255, 255); 

color selectedColor = color(0, 0, 0); // color(0, 255, 0);
color hoverColor = color(0, 0, 255); 
color clickedColor = color(0, 0, 255); 

int border_thickness = 2; 

int initialSize = 50; 
// --------------------

// Mode/Algorithm variables
boolean bidirectional = false; 

// Essential variables
ArrayList<Node> nodes;
ArrayList<Edge> edges;

// Boolean variables
boolean mouseDown = false;
int mode = 0; // might be used later for node add/remove, edge add/remove

// Numerical variables
int tag = 0;
int movable = 0, addNode = 1, deleteNode = 2, addEdge = 3, deleteEdge = 4; 
int bipartiteAlgorithm = 5, cycleDetectionAlgorithm = 6, topoSortAlgorithm = 7; 

// String variables
String[] mode_names = {"Move edge/node (Default)", "Add node", "Delete node", "Add edge", "Delete edge", "Bipartite coloring algorithm", "Cycle detection algorithm", "Topological sort algorithm"};

// State variables
Node current, selected; // current/selected nodes 
ArrayList<Node> edge_pair; // pair of nodes to add an edge between 

// Graph visualizer variables
int delay = 1000, pause_time = 0; 
int start = -1; 
boolean started = false, paused = false; 
ArrayDeque<ArrayList<Transition>> transitions;
ArrayList<Transition> processing;

// The graph
Graph graph;
Bipartite bipartite;
CycleDetection cycle;
TopoSort topoSort;
// Setup

/*
Current plan (stage 1):
- First test how edges and nodes work
- I'll be using arraylists for both as well
- When I make the graph class, edge and node addition/deletion
will be done implicitly by calling graph methods, as opposed to directly
editing an arraylist in the main program

Current things done:
- Wrote display function for nodes and edges
- Wrote all modes (see github commits for info)
- Wrote graph class

Current plan (stage 1.5):
- Test graph class and make sure that it works as intended
*/

// Everything below here:
// I am rewriting the stuff that I commented out (involving user input to customize graph), but using
// the methods that I moved to my Graph class.
void setup(){
  size(1000, 500);
  
  graph = new Graph(bidirectional); 
  nodes = graph.nodes;
  edges = graph.edges;
  edge_pair = new ArrayList<Node>();
  
  transitions = new ArrayDeque<ArrayList<Transition>>(); 
  processing = new ArrayList<Transition>(); 
  
  bipartite = new Bipartite(graph); 
  cycle = new CycleDetection(graph);
  topoSort = new TopoSort(graph); 
  
  
  strokeWeight(border_thickness);
  ellipseMode(CENTER);
  shapeMode(CENTER);
  textMode(CENTER); 
  textAlign(CENTER); 
 
  
  // Test node/edge visibility
  int dx = 100, dy = 30; 
  int times = 2; 
  for (int i = 0; i < times; i++){
    graph.addNode(initialSize, new PVector(width/2 + dx * i, height/2), initialColor);
    if (i == 0) continue; 
    //graph.addNode(initialSize, new PVector(width/2 - dx * i, height/2), initialColor);
  }
  
  for (int i = 0; i < nodes.size() - 1; i++)
    graph.addEdge(nodes.get(i), nodes.get(i+1)); 
    
  println(graph); 
}

void draw(){
  background(backgroundColor);
  
  // Display nodes
  for (int i = 0; i < nodes.size(); i++){
    Node node = nodes.get(i);
    
    
    // If dragged currently, display border color 
    // If selected currently (edge addition candidate), also display border color 
    if (node == current) stroke(selectedColor); 
    if (node.selected) stroke(clickedColor); 
    node.display(); 
    stroke(0); // reset stroke color, if node == current 
  }
  
  // Display edges
  for (Edge e : edges) e.display();
  
   // Display text
  fill(0); 
  text("Current mode: " + mode_names[mode], 10, 10, 100, 100);
  
  // Process graph visual transitions 
  // Note to self: Might be helpful to implement handling multithreading requests
  
  
  // Currently: Trying to debug transitions and making sure every transition occurs properly
  // Okay, debug is done
  if (!transitions.isEmpty() && !started && !paused){
    println("Starting"); 
    started = true;
    processing = transitions.removeFirst();
    assert(processing.size() > 0); 
    
    
    for (Transition t : processing){
      println(t); 
      if (t.node != null){
         // assert(t.node.processing == false); 
         t.node.processing = true;
      } 
      if (t.edge != null){
        assert(t.edge.processing == false); 
        t.edge.processing = true; 
      }
    }
    start = millis(); 
    println("Set inactive transitions to active"); 
  }
  
  if (paused){
    if (millis() - start > pause_time){
      paused = false;
      println("Set active transitions to not active"); 
    }
  }
  
  if (started && !paused && processing.size() > 0){
    if (millis() - start > delay){
      started = false;
      
      
      for (Transition t : processing){
        if (t.node != null) {
          assert(t.node.processing == true); 
          t.node.processing = false; 
          t.node.c = t.c2; 
        } 
        if (t.edge != null){
           assert(t.edge.processing == true); 
          t.edge.processing = false; 
          t.edge.c = t.c2; 
        }
      }
     
      processing.clear(); 
      
      start = millis(); 
      paused = true; 
      return; 
    }
    
    assert(start != -1);
    for (Transition t : processing){
      // println("Hello there"); 
      float dx = (((float) millis()) - start) / delay;
      
      if (t.type == 0){
         Node node = t.node;
         node.c = lerpColor(t.c1, t.c2, dx); 
         
         //if (!node.processing) node.processing = true; 
      } else if (t.type == 1){
         Edge e = t.edge; 
         e.c = lerpColor(t.c1, t.c2, dx); 
         
         // if (!e.processing) e.processing = true; 
      }
    }
  }
}

// Graph visualizer functions
void resetTransitions(){
  processing.clear();
  transitions.clear();
  
  // Hopefully these work as intended
  started = false;
  paused = false; 
}
// ---------

// -----------------

// Utility functions: Updated to be compatible with graph class
public void mousePressed(){
  mouseDown = true;
  int currentMode = mode; // make reference in case mode changes
  
  // If you can click on the node 
  // Mode 1: Default
  // Hopefully, since add/remove nodes are done once per mouse press, this won't conflict with other modes
  if (currentMode == movable)
    if (current == null){
      for (int i = 0; i < nodes.size(); i++){
        Node node = nodes.get(i);
        if (node.inPosition(mouseX, mouseY)){
          current = node;
          return; 
        }
      }
    }
    
   // Mode 2: add Node 
   if (currentMode == addNode){
     graph.addNode(initialSize, new PVector(mouseX, mouseY), initialColor); 
     // println(graph); 
     return; 
   }
   
   // Mode 3: delete Node 
   // May want to test this method later 
   if (currentMode == deleteNode){
    for (int i = nodes.size() - 1; i >= 0; i--)
      if (nodes.get(i).inPosition(mouseX, mouseY)){
        Node node = nodes.get(i); 
        
        // Remove all edges connected to node
        graph.deleteNode(node);
        println(graph); 
        println("Done deleting node: " + node.id); 
        return; 
      }
  }
  
  // Mode 4: add Node
  // May want to test later
  
  // Mode 4: add edge between two nodes
  if (currentMode == addEdge){
    Node node = null; 
    for (int i = 0; i < nodes.size(); i++)
      if (nodes.get(i).inPosition(mouseX, mouseY))
        node = nodes.get(i);
   
    if (node == null) return; 
    
    // If the node is currently selected, deselect it 
    if (edge_pair.indexOf(node) != -1){
      edge_pair.remove(node);
      node.selected = false; 
      return; 
    } else {
      node.selected = true;
      edge_pair.add(node); 
    }
    
    // If there are two nodes selected, make an edge between the nodes
    if (edge_pair.size() == 2){
      Node a = edge_pair.get(0), b = edge_pair.get(1); 
      
      // search for edge between (a, b)
      // Add edge if and only if the edge does not exist 
      Edge e = graph.findEdge(a, b);
      if (e == null){
        graph.addEdge(a, b); 
        println(graph);
        println("Added edge between nodes: " + a.id + " " + b.id);
      } else {
        println("Tried to add existing edge between nodes: " + a.id + " " + b.id); 
      }
      
      for (int i = edge_pair.size() - 1; i >= 0; i--){
        edge_pair.get(i).selected = false;
        edge_pair.remove(i); 
      }
    }
    
    return; 
  }
  
  // Mode 5: delete Edge
  if (currentMode == deleteEdge){
    for (int i = edges.size() - 1; i >= 0; i--){
      Edge e = edges.get(i); 
      if (e.inPosition(mouseX, mouseY)){
        graph.deleteEdge(e); 
        println(graph);
        println("Deleted edge between nodes: " + e.a.id + " " + e.b.id); 
      }
    }
  }
  
  // Mode 6 (testing): Bipartite algorithm
  if (currentMode == bipartiteAlgorithm){
    resetTransitions();
    
    bipartite.reset(); 
    bipartite.begin(); 
    assert(bipartite.list.size() > 0); 
    println("Done with bipartite algorithm"); 
    
    bipartite.pushTransitions(transitions); 
    assert(transitions.size() > 0); 
  }
  
  // Mode 6 (testing): Cycle detection algorithm
  if (currentMode == cycleDetectionAlgorithm){
    resetTransitions();
    
    cycle.reset();
    cycle.begin();
    println("Done with cycle detection algorithm");
    
    cycle.pushTransitions(transitions);
    assert(transitions.size() > 0); 
  }
  
  // Mode 7 (testing): Topological sort algorithm
  if (currentMode == topoSortAlgorithm){
    resetTransitions();
    
    topoSort.reset();
    topoSort.begin();
    
    topoSort.pushTransitions(transitions); 
  }
  // Maybe more methods later 
}

public void mouseReleased(){
  //println("released"); 
  //if (current != null) println("Removing pointer to node"); 
  mouseDown = false;
  current = null; 
}

public void mouseDragged(){
  if (current == null) return; 
  
  // I might also include some sort of interactive mouse hover in this method 
  current.position.x = mouseX;
  current.position.y = mouseY;
}

public void keyPressed(){
  // Reset pointers for adding edges 
  if (mode == addEdge){
    for (int i = 0; i < edge_pair.size(); i++)
      edge_pair.get(i).selected = false;
    edge_pair.clear(); 
  }
  
  mode = (mode + 1) % mode_names.length; 
  
  
  // Test graph visual transitioning 
  if (1 + 1 == 2) return; 
  int i = (int)(random(1) * nodes.size());
  if (nodes.get(i).processing == true){
    println("Node already transitioning: " + i);
    println("States: ");
    if (started) print("Started ");
    if (paused) print("Paused ");
    return; 
  }
  
  if (!(nodes.get(i).c == color(255, 0, 0) || nodes.get(i).c == color(0, 0, 255)))
    println("Color of node: " + red(nodes.get(i).c) + " " + green(nodes.get(i).c)  + " " + blue(nodes.get(i).c)); 
    
  color q = (nodes.get(i).c == color(255, 0, 0)) ? color(0, 0, 255) : color(255, 0, 0); 
  
  
  ArrayList<Transition> p = new ArrayList<Transition>(); 
  p.add(new Transition(nodes.get(i), nodes.get(i).c, q)); 
  int j = i;
  // while (j == i) j = (int)(random(1) * nodes.size()); 
  // p.add(new Transition(nodes.get(j), nodes.get(j).c, (nodes.get(j).c == color(255, 0, 0) ? color(0, 0, 255) : color(255, 0, 0)))); 
  transitions.addFirst(p);
 
  nodes.get(i).processing = true; 
  
}
