
class Edge {
  color DEFAULT = color(0, 0, 0); 
  color EDGE_COLOR = color(0, 0, 0); 
  float ARROW_SIZE = 10, BUFFER = 0; 
  float TEXT_BUFFER = 10; 
  
  
  Node a, b;
  PVector posA, posB;
  int size, weight; // technically thickness
  boolean undirected; 
  color c;
  float SQRT_3 = sqrt(3); 
  boolean processing; 
  boolean weighted; 
  
  // Constructor 
  public Edge(Node a, Node b){
    this.a = a;
    this.b = b; 
    this.weight = 0; 
    this.undirected = true; 
    c = EDGE_COLOR; 
    processing = false; 
    weighted = false; 
  }
  
  public Edge(Node a, Node b, boolean undirected){
    this(a, b);
    this.undirected = undirected; 
  }
  
  public Edge(Node a, Node b, int weight){
    this(a, b);
    this.weight = weight; 
  }
  
  // -------------
  
  // Display methods
  public void display(){
    fill(255, 255, 255);
    float dx = b.position.x - a.position.x, dy = b.position.y - a.position.y; 
    float mag = sqrt(sq(dx) + sq(dy)); 
    dx /= mag; dy /= mag; 
    
    stroke(c); 
    line(a.position.x + dx * a.size / 2, a.position.y + dy * a.size / 2,
         b.position.x - dx * b.size / 2, b.position.y - dy * b.size / 2); 
    
    if (!undirected){
      PVector line = (new PVector(b.position.x - a.position.x, b.position.y - a.position.y)).normalize(); 
      PVector normal = line.copy().rotate(PI/2); 
      
      PVector p1 = new PVector(b.position.x - dx * (b.size / 2 + BUFFER), b.position.y - dy * (b.size / 2 + BUFFER));
      PVector p2 = PVector.add(p1, PVector.add(PVector.mult(line, -ARROW_SIZE * SQRT_3 / 2), PVector.mult(normal, -ARROW_SIZE * 1/2)));
      PVector p3 = PVector.add(p1, PVector.add(PVector.mult(line, -ARROW_SIZE * SQRT_3 / 2), PVector.mult(normal, +ARROW_SIZE * 1/2)));
      triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y); 
    }
    
    if (weighted){
      PVector line = (new PVector(b.position.x - a.position.x, b.position.y - a.position.y)).normalize(); 
      PVector normal = line.copy().rotate(PI/2); 
      
      
      PVector mid = new PVector((a.position.x + b.position.x) / 2, (a.position.y + b.position.y) / 2);
      PVector pos = PVector.mult(normal, -TEXT_BUFFER);
     
      
      float theta = atan2(line.y, line.x); 
   
      translate(mid.x, mid.y); 
      rotate(theta);
      text("Weight: " + weight, pos.x, pos.y); 
     
      rotate(-theta); 
      translate(-mid.x, -mid.y); 
    }
         
    fill(DEFAULT); 
    
    stroke(EDGE_COLOR); 
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
    float epsilon = 0.002 * Math.max(1.0, border_thickness / 5); 
    if ( (1 - match) <= epsilon)
       if (Math.max(PVector.dist(mouse, posA), PVector.dist(mouse, posB)) 
           <= PVector.dist(posA, posB)){
             println("match: " + match); 
             return true; 
           }
    return false; 
  }
}
