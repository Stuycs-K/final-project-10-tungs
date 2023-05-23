// Initial variables
color intialColor = color(255, 0, 0);
int border_thickness = 20;

int initialSize = 200; 
// --------------------

// Essential variables
ArrayList<Node> nodes;
ArrayList<Edge> edges;

// Boolean variables
boolean mouseDown = false;
int mode = 0; // might be used later for node add/remove, edge add/remove

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
*/
void setup(){
  nodes = new ArrayList<Node>();
  edges = new ArrayList<Edge>(); 
  
  strokeWeight(border_thickness);
  ellipseMode(CENTER);
  shapeMode(CENTER);
}
// -------------

// Update the screen
void draw(){
  for (int i = 0; i < nodes.size(); i++){
    Node node = nodes.get(i);
    node.display(); 
  }
}

// -------------

// Event functions
public void mousePressed(){
  
}
