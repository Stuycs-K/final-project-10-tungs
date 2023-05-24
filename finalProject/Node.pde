
class Node {
  color DEFAULT = color(255, 255, 255);
  int size, id, label, number, state; // I'm just going to list some variables 
  PVector position;
  boolean mouseDown, selected, visited;
  color c;
  
  // Constructor
  public Node(int size, PVector position, color c, int id){
    this.size = size;
    this.position = position;
    this.c = c;
    this.id = id;
  }
  
  
  // Utility methods
  public boolean inPosition(int x, int y){
    // (x, y) = mouse position
    return sq(position.x - x) + sq(position.y - y) <= sq(size); 
  }
  // -----------
  
  
  
  // -----------
  
  // Set state methods 
  public void setState(int state){
    
  }
  
  public void setColor(color c){
    this.c = c; 
  }
  
  // ----------
  
  
  // ----------
  
  // Display methods
  public void display(){
    fill(c); 
    circle(position.x, position.y, size); 
    fill(DEFAULT); 
  }
}