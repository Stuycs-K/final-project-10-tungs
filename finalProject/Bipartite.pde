
class Bipartite extends Algorithm {
  
  // Algorithm state info
  boolean valid; // Is the bipartite coloring valid
  
  
  // Custom state info
  int tag[]; 
  // ----
  public Bipartite(Graph graph){
    super(graph); 
    tag = new int[MAX_NODES]; 
  }
  
  
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
    ArrayList<Edge> adj = graph.adj.get(i);
    for (Edge e : adj){
      Node next = e.b;
      int j = next.id; 
      if (tag[j] == 0){
        // Assign neighbor node opposite tag
        tag[j] = (tag[i] == 1) ? 2 : 1;
        
        wait(delay);
        dfs(j); 
      } else if (tag[i] == tag[j]) {
        // Bipartite coloring cannot exist 
      } // If already visited node, do nothing 
    }
  }
  
  void transition(){
  }
  
  void run(){
    
  }
  
  void reset(){
    
  }
  
  
}
