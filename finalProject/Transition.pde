
class Transition {
  // Types of visual transitions:
  // Node, edge (currently only supporting these two) 
  int type;
  Node node;
  Edge edge;
  int NODE = 0, EDGE = 1; 
  
  // Visual transitions for colors
  color c1, c2;
  
  public Transition(color c1, color c2){
    this.c1 = c1;
    this.c2 = c2; 
  }
  
  public Transition(Node node, color c1, color c2){
    this(c1, c2);
    this.type = NODE;
    this.node = node; 
  }
  
  public Transition(Edge edge, color c1, color c2){
    this(c1, c2);
    this.type = EDGE;
    this.edge = edge; 
  }
}
