
public class TopoSort extends Algorithm {
  // Algorithm state info
  
  // Custom state info
  
  public TopoSort(Graph graph){
   super(graph);
   
   
   
  }
  
  /* Custom function
  Topological sort
    Set state of node = 1
    
    For every neighbor: 
      if (visited) return
      
      if (state of neighbor = 1):
         Cycle found, sort cannot exist; return
      else:
         dfs(neighbor)
      
      set state of node = visited (done) 
      add node to vector of nodes
      
   If a cycle does not exist, then reverse the vector and return the topological sort 
   i.e. the graph must be a Directed Acyclic Graph 
  */ 
  void dfs(){
    
    
  }
 

}
