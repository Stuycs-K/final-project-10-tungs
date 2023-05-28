
class Bipartite extends Algorithm {
  
  // State variables specific to algorithm
  boolean valid; // Determines if bipartite coloring is valid
  
  // Graph visualizer variables
  color group1Color = color(255, 0, 0);
  color group2Color = color(0, 0, 255);
  
  // int tag[];
  
  // --------------------
  
  // Constructor
  public Bipartite(Graph graph){
    super(graph);
    
    state_colors[1] = group1Color; 
    state_colors[2] = group2Color; 
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
    //println("Visited DFS: " + i); 
    
    ArrayList<Edge> adj = graph.adj.get(i);
    Node curr = graph.rep[i]; 
    assert(curr.id == i); 
    assert(curr != null); 
    
    for (Edge e : adj){
      Node next = e.b;
      int j = next.id;
      
      // State = 1: First group / 2 : Second group 
      if (next.state == 0){
        next.state = (curr.state == 1) ? 2 : 1; // Assign opposite group to node
        
        // Visual transitions
        addState(next, 0, next.state); 
        // -----
        
        dfs(j); 
      } else if (curr.state == next.state) {
        valid = false; // Bipartite partition cannot exist 
        done = true; 
        
        return; 
      }
    }
  }
  // ---------------
  
  // Utility methods 
  void begin(Node node){
    node.state = (int) (random(2)); // Assign arbitrary group to starting node
    addState(node, 0, node.state);
    
    dfs(node.id); 
    for (Node i : nodes)
      if (i.state == 0) dfs(i.id); 

    // Push graph visual transitions
    
  }
  
  void begin() {
    //int i = (int) (random(1) * nodes.size());
    //begin(nodes.get(i)); 
    for (Node node : nodes){
      if (node.state != 0) continue;
      node.state = (int) (random(2));
      addState(node, 0, node.state);
      dfs(node.id); 
    }
  }
  
  void reset(){
    super.reset();
    valid = true; 
  }
  // ---------
}
