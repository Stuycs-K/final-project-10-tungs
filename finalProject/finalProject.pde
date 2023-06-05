import java.util.ArrayDeque; 
// Initial variables
color initialColor = color(255, 0, 0);
color backgroundColor = color(255, 255, 255); 

color selectedColor = color(0, 0, 0); // color(0, 255, 0);
color hoverColor = color(0, 0, 255); 
color clickedColor = color(0, 0, 255); 

int border_thickness = 2;  
int textSize = 18; 

int initialSize = 50; 
// --------------------

// Mode/Algorithm variables
boolean bidirectional = true; 
boolean weighted = false;

// Essential variables
ArrayList<Node> nodes;
ArrayList<Edge> edges;

// Boolean variables
boolean mouseDown = false;
int mode = 0; // might be used later for node add/remove, edge add/remove

// Numerical variables
int tag = 0;
int movable = 0, addNode = 1, deleteNode = 2, addEdge = 3, deleteEdge = 4, resetGraph = 5;

// String variables
String[] mode_names = {"Move edge/node (Default)", "Add node", "Delete node", "Add edge", "Delete edge"};
String[] algorithm_names = {"Bipartite coloring", "Cycle detection", "Topological sort", "Spanning tree"};
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
SpanningTree minTree; 

ArrayList<Algorithm> algorithms;
Algorithm center;

// Textbox variables
TextBox info; 
ArrayDeque<String> messages;
String resultText = ""; 

TextBox info_label;

TextBox note;
TextBox note_label;

TextBox undirectedOption;
TextBox undirectedOption_label; 

TextBox removeEdges;
TextBox removeGraph;

TextBox title;

TextBox randomColors;
TextBox randomColors_label; 
ArrayList<TextBox> text;


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
  // size(1000, 500);
  size(2000, 1000);
  
  graph = new Graph(bidirectional, weighted); 
  nodes = graph.nodes;
  edges = graph.edges;
  edge_pair = new ArrayList<Node>();
  
  transitions = new ArrayDeque<ArrayList<Transition>>(); 
  processing = new ArrayList<Transition>(); 
  
  
  bipartite = new Bipartite(graph); 
  cycle = new CycleDetection(graph);
  topoSort = new TopoSort(graph); 
  minTree = new SpanningTree(graph);
  
  algorithms = new ArrayList<Algorithm>();
  algorithms.add(bipartite);
  algorithms.add(cycle);
  algorithms.add(topoSort);
  algorithms.add(minTree); 
  
  center = new Algorithm(graph); 
  
  
  // Textbox
  info = new TextBox(100 + 10 + 40, 100 + 20 + 100, 250, 100); 
  text = new ArrayList<TextBox>(); 
  messages = new ArrayDeque<String>();
  
  info_label = new TextBox(100 + 10 + 40, 100 + 5 + 30, 200, 90); 
  info_label.transparent = true;
  info_label.text = "Output of graph algorithm"; 
  
  note = new TextBox(100 + 10 + 40, 100 + 20 + 130 + 200, 250, 200); 
  note.text = "Press any key: Change mode, Click mouse: activate mode \n \n 1: Go to utility modes \n 2: Go to algorithm modes \n Press 'r' to reset graph visuals"; 
  
  note_label = new TextBox(100 + 10 + 40, 100 + 20 + 210, 250, 200);
  note_label.transparent = true; 
  note_label.text = "Some useful key shortcuts"; 
  
  undirectedOption = new TextBox(width - (100 + 10 + 40), 100 + 20 + 100, 200, 90);
  undirectedOption.text = "Current edge type: " + ( (bidirectional) ? "Undirected" : "Directed"); 
  
  undirectedOption_label = new TextBox(width - (100 + 10 + 40), 100 + 5 + 20, 200, 90); 
  undirectedOption_label.text = "Click to change edge type (Resets entire graph)"; 
  undirectedOption_label.transparent = true; 
  
  removeEdges = new TextBox(width - (100 + 10 + 40), 100 + 20 + 100 + 120, 200, 90);
  removeEdges.text = "Click to remove all edges from graph";
  
  removeGraph = new TextBox(width - (100 + 10 + 40), 100 + 20 + 100 + 120 + 120, 200, 90);
  removeGraph.text = "Click to reset the graph"; 
  
  title = new TextBox(width/2, 100, width/2, 100);
  title.text = "Graph Visualizer -- See your favorite algorithms firsthand!"; 
  title.transparent = true;
  
  randomColors = new TextBox(100 + 10 + 40, 100 + 20 + 210 + 200 + 100, 250, 100);
  randomColors.text = "Click to randomize colors of node states of all algorithms";
  
  text.add(info); 
  text.add(info_label); 
  text.add(note); 
  text.add(note_label); 
  text.add(undirectedOption); 
  text.add(undirectedOption_label); 
  text.add(removeEdges); 
  text.add(removeGraph); 
  text.add(title); 
  text.add(randomColors);
  
  strokeWeight(border_thickness);
  ellipseMode(CENTER);
  shapeMode(CENTER);
  textMode(CENTER); 
  textAlign(CENTER, CENTER); 
  
  rectMode(CENTER); 
 
  
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
  
  // Process textboxes
  for (TextBox t : text) t.display(); 

  
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
  textSize(textSize); 
  String current = (mode < mode_names.length) ? (mode_names[mode]) : 
  (algorithm_names[mode - mode_names.length]);
  
  String extra = (mode < mode_names.length) ? ("\n(Utility, " + 
  (mode+1) + " / " + (mode_names.length)) : 
  ("\n(Algorithm, " + (mode - mode_names.length + 1) + " / " + algorithm_names.length);
  extra += ")"; 
  
  text("Current mode: " + current, 10 + 100, 10 + 20, 100 + 100, 100);
  text(extra, 10 + 100, 40 + 20, 100 + 100, 140);
  
  
  // Process graph visual transitions 
  if (!transitions.isEmpty() && !started && !paused){
    // println("Starting"); 
    started = true;
    processing = transitions.removeFirst();
    assert(processing.size() > 0); 
    
    // Update text messages
      if (!messages.isEmpty()){
        info.text = messages.removeFirst();
        // println("Current processing: " + transitions.size() +  " " + info.text); 
      }
      
        
        
    
    for (Transition t : processing){
      // println(t); 
      if (t.node != null){
         // assert(t.node.processing == false); 
         t.node.processing = true;
      } 
      if (t.edge != null){
        // assert(t.edge.processing == false); 
        t.edge.processing = true; 
      }
    }
    start = millis(); 
    //println("Set inactive transitions to active"); 
  }
  
  if (paused){
    if (millis() - start > pause_time){
      paused = false;
      //println("Set active transitions to not active"); 
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
      
      if (transitions.isEmpty())
        info.text = resultText; 
      /*
      // Update text messages
      if (!messages.isEmpty())
        info.text = messages.removeFirst(); 
      */ 
      
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
  messages.clear(); 
  info.text = ""; 
  resultText = ""; 
  
  // Hopefully these work as intended
  started = false;
  paused = false; 
}
// ---------

// -----------------

void resetGraph(){
  resetTransitions();
  
  // Call delete nodes
  for (int i = nodes.size() - 1; i >= 0; i--){
    Node node = nodes.get(i);
    graph.deleteNode(node); 
  }
  
  nodes.clear(); 
  edges.clear();
  
  // Clear adjacency list 
  for (ArrayList<Edge> Edges : graph.adj)
    Edges.clear();
}

// Utility functions: Updated to be compatible with graph class
public void mousePressed(){
  mouseDown = true;
  int currentMode = mode; // make reference in case mode changes
  
  // Textbox
  if (info.inPosition(mouseX, mouseY)) println("Clicked on text box"); 
  
  if (undirectedOption.inPosition(mouseX, mouseY)){
    bidirectional = !bidirectional;
    graph.undirected = !graph.undirected; 
    assert(bidirectional == graph.undirected); 
    //for (Edge e : edges) e.undirected = graph.undirected; 
    
    resetGraph();
    
    undirectedOption.text = "Current edge type: " + ( (bidirectional) ? "Undirected" : "Directed"); 
      
    println(graph); 
    println("Changed mode of edge"); 
    return;
  } else if (removeEdges.inPosition(mouseX, mouseY)){
    // resetGraph(), but without removing the nodes
    resetTransitions();
    
    edges.clear();
    for (ArrayList<Edge> Edges : graph.adj)
      Edges.clear(); 
    
    return; 
  } else if (removeGraph.inPosition(mouseX, mouseY)){
    resetGraph(); 
    return; 
  }
  
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
    if (processing.size() > 0 || transitions.size() > 0){
      println("Can't delete node while graph visualization is occuring"); 
      return; 
    }
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
    if (processing.size() > 0 || transitions.size() > 0){
      println("Can't delete edge while graph visualization is occuring"); 
      return; 
    }
    
    for (int i = edges.size() - 1; i >= 0; i--){
      Edge e = edges.get(i); 
      if (e.inPosition(mouseX, mouseY)){
        graph.deleteEdge(e); 
        println(graph);
        println("Deleted edge between nodes: " + e.a.id + " " + e.b.id); 
      }
    }
  }
  
  
   // If an algorithm is selected
  if (currentMode >= mode_names.length){
    resetTransitions();
    Algorithm algorithm = algorithms.get(currentMode - mode_names.length);
    
    algorithm.reset();
    algorithm.begin();
    println("Done with: " + algorithm_names[currentMode - mode_names.length]);
    
    algorithm.pushTransitions(transitions);
    algorithm.pushMessages(messages); 
    resultText = algorithm.resultText; 
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
  
  
 
  if (key == '1'){
    mode = 0; 
  } else if (key == '2'){
    mode = mode_names.length; 
  } else if (key != 'r') {
    int len = mode_names.length + algorithm_names.length;
    mode = (mode + 1) % len; 
 
  }
  
  if (mode >= mode_names.length){
      Algorithm a = algorithms.get(mode - mode_names.length);
      info.text = (a.works_directed && a.works_undirected) ? (algorithm_names[mode - mode_names.length] + " works for both undirected/directed graphs")
      : (algorithm_names[mode - mode_names.length] + " may produce unexpected results for the mode: " + (!a.works_directed ? "Directed" : "Undirected")); 
  } else {
    if (messages.isEmpty()) info.text = ""; 
  }

 
  if (key == 'r'){
    if (mode >= mode_names.length){
      algorithms.get(mode - mode_names.length).reset(); 
      resetTransitions(); 
      println("Reset"); 
    } else {
      center.reset(); 
      resetTransitions(); 
    }
  }
  
  
}
