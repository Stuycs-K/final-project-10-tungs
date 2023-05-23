
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
    
    float dx = b.position.x - a.position.x, dy = b.position.y - a.position.y; 
    float mag = sqrt(sq(dx) + sq(dy)); 
    dx /= mag; dy /= mag; 
    
    line(a.position.x + dx * a.size / 2, a.position.y + dy * a.size / 2,
         b.position.x - dx * b.size / 2, b.position.y - dy * b.size / 2); 
    fill(DEFAULT); 
  }
}
