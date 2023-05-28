
class Transition {
  // Types of visual transitions:
  // Node, edge (currently only supporting these two) 
  int type;
  int NODE = 0, EDGE = 1; 
  
  // Visual transitions for colors
  color c1, c2;
  
  public Transition(int type){
    this.type = type;
  }
  
  public Transition(int type, color c1, color c2){
    this.type = type;
    this.c1 = c1; this.c2 = c2; 
  }
  
}
