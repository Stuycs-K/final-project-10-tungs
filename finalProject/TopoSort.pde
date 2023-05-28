import java.util.ArrayDeque;

public class TopoSort extends Algorithm {
  
  
   // State variables specific to algorithm
   ArrayDeque<Node> order, stack, cycle; // Nodes in topological sort
  
  
   
   // -------------
   
   // Constructor
   public TopoSort(Graph graph){
     super(graph);
     
     order = new ArrayDeque<Node>(); stack = new ArrayDeque<Node>();
     cycle = new ArrayDeque<Node>(); 
   }
   
   // ----------

   // Custom function 
   /* Topological sort 
   (Note: the idea is same as cycle detection)
   Set state of node = 1
   Push node to stack
   
   For every neighbor:
     set state of node = 1
     if (neighbor.state == 1):
       Cycle found, sort cannot exist
       Output cycle using stack 
     else if (!visited):
      dfs(neighbor); 
  
   Remove node from stack
   If a topological sort exists, the graph must be a directed acyclic graph 
   */
   void dfs(int i){
     if (done) return;
     
     ArrayList<Edge> adj = graph.adj.get(i);
     Node curr = graph.rep[i]; 
     assert(curr != null);
     
     stack.addFirst(curr);
     for (Edge e : adj){
       Node next = e.b;
       int j = next.id;
       
       // State: 0: Not visited / 1: Processing / 2: Already visited
       if (next.state == 1){
         while (!stack.isEmpty() && stack.getFirst() != next)
           cycle.addFirst(stack.removeFirst());
           
         cycle.addFirst(next);
         stack.clear();
         return; 
       } else if (next.state == 0) {
         next.state = 1; 
         dfs(j); 
       }
     }
     curr.state = 2;
     // Push node into topological ordering 
     order.addFirst(curr);
     assert(stack.getFirst() == curr);
     stack.removeFirst(); 
   }
   
   
}
