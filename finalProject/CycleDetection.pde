import java.util.ArrayDeque;

public class CycleDetection extends Algorithm {
  
  
  // State variables specific to algorithm
  ArrayDeque<Node> stack, cycle; // Nodes in topological sort
  boolean cycle_found = false; // If a cycle was found 
  
  color cycleColor = color(0, 255, 0); 
  
  // ---------
  
  // Constructor
  public CycleDetection(Graph graph){
    super(graph);
    
    stack = new ArrayDeque<Node>(); cycle = new ArrayDeque<Node>(); 
  }
  // -------------
  
  // Custom function
  /* Cycle detection
  For every node:
    Note: the idea is same as cycle detection)
    Push node to stack
   
    For every neighbor:
      if (neighbor.visited):
        Cycle found, sort cannot exist
        Output cycle using stack 
      else if (!visited):
         neighbor.state = 1; 
         dfs(neighbor); 

   Remove node from stack
  */
  void dfs(int i, int prev){
     if (done) return;
     
     ArrayList<Edge> adj = graph.adj.get(i);
     Node curr = graph.rep[i]; 
     assert(curr != null);
     
     stack.addFirst(curr);
     for (Edge e : adj){
       Node next = e.b;
       int j = next.id;
       // If graph is undirected, this is not a cycle 
       if (j == prev && graph.undirected) continue; 
       
       // State: 0: Not visited / 1: Visited 
       if (next.state == 1){
         if (done) return; // Guard clause in case unexpected behavior occurs
         
         while (!stack.isEmpty() && stack.getFirst() != next)
           cycle.addFirst(stack.removeFirst());
         // Node should be in stack at this point 
         // assert(stack.getFirst() == next);
         
         cycle.addFirst(next);
         stack.clear();
         
         done = true; 
         cycle_found = true; 
         return; 
       } else if (next.state == 0) {
         next.state = 1; 
         
         // Visual Transitions
         addState(next, 0, 1); 
         // ---------
         dfs(j, i); 
       }
     }
     // Another guard clause
     if (done) return;
     // node.state = 2;
     
     // Remove the node from stack 
     // Note: node should be first in stack at this moment 
     assert(stack.getFirst() == curr);
     stack.removeFirst(); 
  }
  
  // ---------------
  
  // Utility methods
  void begin() {
    for (Node node : nodes){
       if (node.state != 0) continue;
       if (done) break;
       node.state = 1;
       addState(node, 0, node.state);
       dfs(node.id, -1); 
    }
     
     // If a cycle is found, label nodes as in cycle
     if (cycle_found){
       assert(cycle.size() > 0);
       batchProcessing = false; 
       while (!cycle.isEmpty()){
         Node node = cycle.removeFirst();
         addTransition(node, state_colors[node.state], cycleColor);
       }
       
       // Set batch processing back to true 
       // Nodes in cycle should be displayed simultaneously 
       batchProcessing = true;
       addBatch();
     }
     super.begin(); 
  }
  
  void reset(){
    super.reset();
    cycle_found = false; 
    
    // Clear stacks 
    stack.clear();
    cycle.clear(); 
  }
  // ---------
}
