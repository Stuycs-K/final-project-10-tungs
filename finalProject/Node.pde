
class Node {
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
  public void renderNode(){
    
  }
  
  public void moveNode(){
    
  }
  
  public void checkClicked(){
    
  }
  // -----------
  
  // Set state methods 
  public void setState(int state){
    
  }
  
  public void setColor(color c){
    this.c = c; 
  }
  
  // ----------
  
  
}
