import java.util.ArrayDeque;
import java.util.Collections;

public class TopoSort extends Algorithm {
  
   // State variables specific to algorithm
   ArrayDeque<Node> order, stack, cycle; // Nodes in topological sort
   color cycleColor = color(0, 255, 0); 
   color sortColor = color(0, 100, 100); 
   boolean valid; // Is there a topological sort
  
   
   // -------------
   
   // Constructor
   public TopoSort(Graph graph){
     super(graph);
     
     order = new ArrayDeque<Node>(); stack = new ArrayDeque<Node>();
     cycle = new ArrayDeque<Node>(); 
     
     works_undirected = false; 
   }
   
   // ----------

   // Custom function 
   /* Topological sort 
   (Note: the idea is same as cycle detection)
   Push node to stack
   
   For every neighbor:
     if (neighbor.state == 1):
       Cycle found, sort cannot exist
       Output cycle using stack 
     else if (!visited):
      neighbor.state = 1; 
      dfs(neighbor); 
  
   Remove node from stack
   If a topological sort exists, the graph must be a directed acyclic graph 
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
       if (j == prev && graph.undirected) continue; 
       
       // State: 0: Not visited / 1: Processing / 2: Already visited
       if (next.state == 1 && prev != -1){
         if (done) return; 
         while (!stack.isEmpty() && stack.getFirst() != next)
           cycle.addFirst(stack.removeFirst());
           
         cycle.addFirst(next);
         stack.clear();
         
         // Visual Transitions

         // -----------
         
         done = true; 
         valid = false;
         return; 
       } else if (next.state == 0) {
         next.state = 1; 
         
         // Visual Transitions
         addState(next, 0, 1); 
         addMessage("Travel from node " + i + "-> node " + j + " (Node " + j + ": State = processing)"); 
         // ---------
         
         dfs(j, i); 
       }
     }
     // Guard clause
     if (done) return;
  
     curr.state = 2;
     // Visual transitions
     addState(curr, 1, 2); 
     // --------
     
     // Push node into topological ordering 
     order.addLast(curr);
     assert(stack.getFirst() == curr);
     // Visual Transitions
        addMessage("Node " + curr.id + ": Mark as done processing"); 
     // --------
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
     
     // If topological sort does not exist, label nodes in cycle 
     if (!valid){
       assert(cycle.size() > 0);
       batchProcessing = false; 
       
       // Add text message
       addMessage("Cycle detected in the graph"); 
       
       while (!cycle.isEmpty()){
         Node node = cycle.removeFirst();
         addTransition(node, state_colors[node.state], cycleColor);
       }
       
       // Set batch processing back to true 
       // Nodes in cycle should be displayed simultaneously 
       batchProcessing = true;
       addBatch();
     } else {
       // add text message
       addMessage("Topological sort found. Now displaying the sort order: ");
       
       while (order.size() > 0){
         Node node = order.removeFirst(); 
         addTransition(node, state_colors[node.state], sortColor);
         
         addMessage("Current node in topological sort: Node: " + node.id); 
       }
     }
     
     if (valid) 
       resultText = "Topological sort successfully displayed in order";
     else
       resultText = "Topological sort cannot exist, since a cycle was found";
       
  }
  
  void reset(){
    super.reset();
    valid = true; 
    
    // Clear stacks 
    stack.clear();
    cycle.clear(); 
    order.clear(); 
  }
  // ---------
   
   
}
