
class Bipartite extends Algorithm {
  
  // State variables specific to algorithm
  boolean valid; // Determines if bipartite coloring is valid
  
  // Graph visualizer variables
  color group1Color = color(255, 0, 0);
  color group2Color = color(0, 0, 255);
  color badColor = color(0, 255, 0); 
  
  
  
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
        if (done) return; 
        next.state = (curr.state == 1) ? 2 : 1; // Assign opposite group to node
        
        // Visual transitions
        addState(next, 0, next.state); 
        addMessage("Travel from node " + i + " -> node " + j + ", Assign group of node " + j + " = " + next.state);
        // -----
        
        dfs(j); 
      } else if (curr.state == next.state) {
        if (done) return; // This is possible based on DFS traversal
        
        valid = false; // Bipartite partition cannot exist 
        done = true; 
        
        println("Odd cycle detected in bipartite"); 
        addTransition(next, state_colors[next.state], badColor); 
        addMessage("At node " + i + ": Odd cycle detected, bipartite coloring cannot exist"); 
        
        resultText = "Bipartite coloring cannot exist in graph"; 
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
      if (done) break; // Terminate process if a odd cycle is found
      node.state = 1 + (int) (random(2)); 
      addState(node, 0, node.state);
      addMessage("Started search from node " + node.id + ", Assign group of " + node.id + " = " + node.state); 
      dfs(node.id); 
    }
    super.begin(); 
    
    if (!done) println("Bipartite coloring exists in graph"); 
    if (!done) resultText = "Completed bipartite coloring of graph";
  }
  
  void reset(){
    super.reset();
    valid = true; 
  }
  // ---------
}
