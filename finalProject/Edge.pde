
class Edge {
  color DEFAULT = color(255, 255, 255);
  color EDGE_COLOR = color(0, 0, 0); 
  
  Node a, b;
  PVector posA, posB;
  int size, weight; // technically thickness
  
  // Constructor 
  public Edge(Node a, Node b){
    this.a = a;
    this.b = b; 
    this.weight = 0; 
  }
  
  public Edge(Node a, Node b, int weight){
    this(a, b);
    this.weight = weight; 
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
  
  // ----------------
  
  // Utility methods
  // Idea: approximate if mouse position is close to line
  public boolean inPosition(int x, int y){
     // Get modified positions of nodes 
    float dx = b.position.x - a.position.x, dy = b.position.y - a.position.y; 
    float mag = sqrt(sq(dx) + sq(dy)); 
    dx /= mag; dy /= mag; 
    
    posA = new PVector(a.position.x + dx * a.size / 2, a.position.y + dy * a.size / 2);
    posB = new PVector(b.position.x - dx * b.size / 2, b.position.y - dy * b.size / 2);
    
    PVector mouse = new PVector(x, y); 
    PVector line = new PVector(posB.x - posA.x, posB.y - posA.y); 
    PVector curr = new PVector(x - posA.x, y - posA.y);
   
    float match = abs(line.dot(curr) /(line.mag() * curr.mag())); // this is cos(angle) in radians
    float epsilon = 0.001 * Math.max(1.0, border_thickness / 5); 
    if ( (1 - match) <= epsilon)
       if (Math.max(PVector.dist(mouse, posA), PVector.dist(mouse, posB)) 
           <= PVector.dist(posA, posB)){
             println("match: " + match); 
             return true; 
           }
    return false; 
  }
}
