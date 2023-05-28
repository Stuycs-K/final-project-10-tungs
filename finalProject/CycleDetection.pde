import java.util.ArrayDeque;

public class CycleDetection extends Algorithm {
  
  
  // State variables specific to algorithm
  ArrayDeque<Node> stack, cycle; // Nodes in topological sort
  boolean cycle_found = false; // If a cycle was found 
  
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
       if (j == prev) continue; 
       
       // State: 0: Not visited / 1: Visited 
       if (next.state == 1){
         while (!stack.isEmpty() && stack.getFirst() != next)
           cycle.addFirst(stack.removeFirst());
           
         cycle.addFirst(next);
         stack.clear();
         
         done = true; 
         return; 
       } else if (next.state == 0) {
         next.state = 1; 
         dfs(j, i); 
       }
     }
     // Remove the node from stack 
     // Note: node should be first in stack at this moment 
     assert(stack.getFirst() == curr);
     stack.removeFirst(); 
  }
}
