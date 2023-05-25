
// The algorithms that I implement will probably extend this Algorithm class
class Algorithm {
  Graph graph;
  ArrayList<ArrayList<Edge>> adj; 
  ArrayList<Node> nodes;
  ArrayList<Edge> edges;
  
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
}
