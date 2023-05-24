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
boolean bidirectional = true; 

// Essential variables
ArrayList<Node> nodes;
ArrayList<Edge> edges;

// Boolean variables
boolean mouseDown = false;
int mode = 0; // might be used later for node add/remove, edge add/remove

// Numerical variables
int tag = 0;
int movable = 0, addNode = 1, deleteNode = 2, addEdge = 3, deleteEdge = 4; 

// String variables
String[] mode_names = {"Move edge/node (Default)", "Add node", "Delete node", "Add edge", "Delete edge"};

// State variables
Node current, selected; // current/selected nodes 
ArrayList<Node> edge_pair; // pair of nodes to add an edge between 

// The graph
Graph graph;
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
  
  graph = new Graph();
  nodes = graph.nodes;
  edges = graph.edges;
  edge_pair = new ArrayList<Node>();
  
  strokeWeight(border_thickness);
  ellipseMode(CENTER);
  shapeMode(CENTER);
  
  // Test node/edge visibility
  int dx = 30, dy = 30; 
  graph.addNode(initialSize, new PVector(width/2, height/2), initialColor);
  graph.addNode(initialSize, new PVector(width/2 - dx, height/2), initialColor);
  graph.addNode(initialSize, new PVector(width/2 + dx, height/2), initialColor);
  
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
}


// Everything below here....
// Currently still in testing! Because I moved all of my methods to the graph class, and I'll need to test that alot. 
/*
public void removeEdges(Node node){
  for (int i = edges.size() - 1; i >= 0; i--){
    Edge e = edges.get(i);
    if (e.a == node || e.b == node) {edges.remove(i); return;}
  }
}

public Edge findEdge(Node a, Node b){
  for (int i = edges.size() - 1; i >= 0; i--){
    Edge e = edges.get(i);
     
    if ((!bidirectional && (e.a == a && e.b == b))
       || (bidirectional && ( (e.a == a && e.b == b) || (e.a == b && e.b == a)))){
          println("Edge found"); return e; 
        }
  }
  return null; 
}

void setup(){
  size(1000, 500);
  
  graph = new Graph(); 
  
  nodes = new ArrayList<Node>();
  edges = new ArrayList<Edge>(); 
  edge_pair = new ArrayList<Node>(); 
  
  strokeWeight(border_thickness);
  ellipseMode(CENTER);
  shapeMode(CENTER);
  
  
  // Before I make a graph, I'll test node/edge visibility
  // with an arraylist for both in the main program 
  int dx = 30, dy = 30; 
  nodes.add(new Node(initialSize, new PVector(width/2, height/2), initialColor, tag++));
  nodes.add(new Node(initialSize, new PVector(width/2 - dx, height/2), initialColor, tag++));
  nodes.add(new Node(initialSize, new PVector(width/2 + dx, height/2), initialColor, tag++));
  
  for (int i = 0; i < nodes.size() - 1; i++)
    edges.add(new Edge(nodes.get(i), nodes.get(i+1))); 
}
// -------------

// Update the screen
void draw(){
  background(backgroundColor); 
  for (int i = 0; i < nodes.size(); i++){
    Node node = nodes.get(i);
    


    // If dragged currently, display border color 
    // If selected currently (edge addition candidate), also display border color 
    if (node == current) stroke(selectedColor); 
    if (node.selected) stroke(clickedColor); 
    node.display(); 
    stroke(0); // reset stroke color, if node == current 
    
   
    
    //delay(100);
    //println(node.position.x + " " + node.position.y); 
    //println(mouseX + " " + mouseY); 
  }
  
  for (int i = 0; i < edges.size(); i++){
    Edge edge = edges.get(i);
    edge.display(); 
  }
  
  // Display text
  fill(0); 
  text("Current mode: " + mode_names[mode], 10, 10, 100, 100);
  
}

// -------------

// Utility functions

// ---------------

// Event functions
int cnt = 0;
public void mousePressed(){
  mouseDown = true;
  int currentMode = mode; // make a reference in case mode changes 
 
  
  // If you can click on the node 
  // Mode 1: Default
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
     Node node = new Node(initialSize, new PVector(mouseX, mouseY), initialColor, tag++);
     nodes.add(node); 
   }
   
   // Mode 3: delete Node
   if (currentMode == deleteNode){
    for (int i = nodes.size() - 1; i >= 0; i--)
      if (nodes.get(i).inPosition(mouseX, mouseY)){
        Node node = nodes.get(i); 
       
        // Remove all edges connected to node
        // I would use removeIf, but apparently processing doesn't support lambda expressions
        removeEdges(node); 
        nodes.remove(i);
        
    
        return; 
      }
  }
  
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
      // Add the edge if and only if the edge does not already exist 
      Node a = edge_pair.get(0), b = edge_pair.get(1); 
      Edge e = findEdge(a, b); 
      if (e == null) edges.add(new Edge(a, b)); 
      
      for (int i = edge_pair.size() - 1; i >= 0; i--){
        edge_pair.get(i).selected = false;
        edge_pair.remove(i); 
      }
    }
    
    return; 
  }
  
  
  // Mode 5: delete Edge
  if (currentMode == deleteEdge){
    for (int i = edges.size() - 1; i >= 0; i--)
      if (edges.get(i).inPosition(mouseX, mouseY)){
        Edge e = edges.get(i);
        println(cnt++); 
        edges.remove(i); 
      }
  }
   
  
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
}
*/
