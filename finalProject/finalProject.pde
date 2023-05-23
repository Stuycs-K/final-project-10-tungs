// Initial variables
color initialColor = color(255, 0, 0);
color backgroundColor = color(255, 255, 255); 

color selectedColor = color(0, 0, 0); // color(0, 255, 0);
color hoverColor = color(0, 0, 255); 

int border_thickness = 2; 

int initialSize = 50; 
// --------------------

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
- Mode 1: I can drag nodes around
- Mode 2: I can add new nodes
*/

public void removeEdges(Node node){
  for (int i = edges.size() - 1; i >= 0; i--){
    Edge e = edges.get(i);
    if (e.a == node || e.b == node) edges.remove(i); 
  }
}

void setup(){
  size(1000, 500); 
  
  nodes = new ArrayList<Node>();
  edges = new ArrayList<Edge>(); 
  
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
    

    if (node == current) stroke(selectedColor); 
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

// Event functions
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
  mode = (mode + 1) % mode_names.length; 
}
