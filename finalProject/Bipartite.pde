
class Bipartite extends Algorithm {
  
  // State variables specific to algorithm
  boolean valid; // Determines if bipartite coloring is valid
  
  // int tag[];
  
  // --------------------
  
  
  
  // Constructor
  public Bipartite(Graph graph){
    super(graph);
  }
  // ------------
  
 
  // Custom function
  /* Bipartite coloring
  For every node:
    if neighbor = same: return false
    else:
       State: color neighbor as opposite tag
       Transition: display transition to state / move to neighbor 
       dfs(neighbor)
  */
  void dfs(int i){
    if (done) return;
    
    ArrayList<Edge> adj = graph.adj.get(i);
    Node curr = graph.rep[i]; 
    assert(curr != null); 
    
    for (Edge e : adj){
      Node next = e.b;
      int j = next.id;
      
      // State = 1: First group / 2 : Second group 
      if (next.state == 0){
        next.state = (curr.state == 1) ? 2 : 1; // Assign opposite group to node
        dfs(j); 
      } else if (curr.state == next.state) {
        valid = false; // Bipartite partition cannot exist 
        done = true; 
        
        return; 
      }
    }
  }
  // ---------------
  
  void transition(){
  }
  
  void run(){
    
  }
  
  void reset(){
    
  }
  
  
}
