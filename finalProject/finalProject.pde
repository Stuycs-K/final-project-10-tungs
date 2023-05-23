// Initial variables
color intialColor = color(255, 0, 0);
// --------------------

// Essential variables
ArrayList<Node> nodes;
ArrayList<Edge> edges;

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
  
}
// -------------

// Update the screen
void draw(){
  
}

void mouseDragged(){
  
  // for (int i = 0; i < nodes.size(); i++)
}
// -------------
