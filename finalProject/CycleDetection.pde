import java.util.ArrayDeque;

public class CycleDetection extends Algorithm {
  // Algorithm state info
  
  // Custom state info
  ArrayDeque<Node> stack, cycle; 
  boolean[] in_stack; 

  
  
  public CycleDetection(Graph graph){
    super(graph);
    
    // Custom state info
    in_stack = new boolean[MAX_NODES]; 
    stack = new ArrayDeque<Node>(); //  cycle = new ArrayDeque<Node>(); 
  }
  
  /* Custom function
  Cycle detection:
  For every node:
    if (neighbor = same) return
    else:
      State: label neighbor as visited
      Transition: Display transition moving to the next neighbor
      Add neighbor to recursion stack
      
      if neighbor already visited:
        mark cycle as complete
        
      
    After all dfs:
      Pop the node from the stack 
  */
  void dfs(int i){
    if (done) return;
    
    ArrayList<Edge> adj = graph.adj.get(i);
    Node curr = graph.rep[i];  
    assert(curr != null);
    
    // Add node to stack 
    stack.addFirst(curr); 
    for (Edge e : adj){
      Node next = e.b;
      int j = next.id; 
      
      // Cycle found if node already visited 
      if (graph.vis[j]){
        while (!stack.isEmpty() && stack.getFirst() != curr){
          cycle.addLast(stack.removeFirst()); 
        }
        cycle.addLast(stack.removeFirst());
        stack.clear();
       
        return; 
      } else {
        graph.vis[j] = true;
        dfs(j);
      }
    }
    
    // At this point, the front of stack should include node 
    assert(stack.getFirst() == curr);
    stack.removeFirst();
    
  }
}
