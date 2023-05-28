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
   void dfs(){
     
   }
}
