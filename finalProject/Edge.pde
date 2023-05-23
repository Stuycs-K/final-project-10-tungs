
class Edge {
  color DEFAULT = color(255, 255, 255);
  color EDGE_COLOR = color(0, 0, 0); 
  
  Node a, b;
  int size; // technically thickness
  
  // Constructor 
  public Edge(Node a, Node b){
    this.a = a;
    this.b = b; 
  }
  
  // -------------
  
  // Display methods
  public void display(){
    fill(EDGE_COLOR); 
    line(a.position.x, a.position.y, b.position.x, b.position.y);
    fill(DEFAULT); 
  }
  
  
}
