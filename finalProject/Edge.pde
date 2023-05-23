
class Edge {
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
    line(a.position.x, a.position.y, b.position.x, b.position.y);
  }
  
  
}
