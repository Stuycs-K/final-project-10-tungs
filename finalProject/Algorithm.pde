
// The algorithms that I implement will probably extend this Algorithm class
class Algorithm {
  int MAX_NODES = 100; 
  Graph graph;
  ArrayList<ArrayList<Edge>> adj; 
  ArrayList<Node> nodes;
  ArrayList<Edge> edges;
  
  // Algorithm state variables
  boolean done = false; 
  
  
  int delay = 0, start = 0; 
  boolean waiting = false; 
  
  // Pause execution for this many milliseconds
  // Necessary condition: Synchronize this with the draw() function
  // to allow for "multithread execution"
  public void wait(int t){
   
  }
  
  public Algorithm(Graph graph){
    
    // Initialize information for a particular algorithm 
    this.graph = graph;
    adj = this.graph.adj;
    nodes = this.graph.nodes;
    edges = this.graph.edges;
  }
  
  // Utility methods 
  // Reset graph to default conditions
  // Also may stop the simulation 
  void reset(){
    
  }
  
  // ---------
  
  
  // Algorithm-specific methods
  // Or I might just make different algorithms have different functions 
  void function(){
    
  }
  
  // ---------
  
  // Algorithm utility methods
  void run(){
    
  }
  
  void quit(){
    
  }
  
 
  // ------------
  
  // User display methods
  void transition(){
    
  }
  
  // -------
}
