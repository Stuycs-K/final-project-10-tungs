
class Graph {
  int MAX_NODES = 100; 
  int N = 0; 
  
  ArrayList<ArrayList<Edge>> adj; 
  boolean[] vis, state, exists;
  
  ArrayList<Node> nodes;
  ArrayList<Edge> edges;
  
  boolean undirected; 
  
  // Constructor
  public Graph(){
    // For existence of a node, check exists[] array 
    for (int i = 0; i < MAX_NODES; i++)
      adj.add(new ArrayList<Edge>());  

    vis = new boolean[MAX_NODES]; state = new boolean[MAX_NODES]; 
    exists = new boolean[MAX_NODES]; 
    
    nodes = new ArrayList<Node>(); 
    edges = new ArrayList<Edge>(); 
  }
  
  public Graph(boolean undirected){
    this(); 
    this.undirected = undirected;
  }
  // --------------
  
  // Helper functions
public void removeEdges(Node node){
 
}

public Edge findEdge(Node a, Node b){
  for (int i = edges.size() - 1; i >= 0; i--){
    Edge e = edges.get(i);
     
    if ((!bidirectional && (e.a == a && e.b == b))
       || (bidirectional && ( (e.a == a && e.b == b) || (e.a == b && e.b == a)))){
          println("Edge found"); return e; 
        }
  }
  return null; 
}
  
  // ---------------
  
  // Utility functions
  public boolean addNode(int id){
   if (exists[id]) throw new IllegalArgumentException("Error: Can't add existing node in graph");
   
   // Make the node existent
   exists[id] = true;
   
   return true; 
  }
  
  public boolean deleteNode(int id){
    if (!exists[id]) throw new IllegalArgumentException("Error: Can't remove a nonexistent node"); 
    
    // Remove all edges in the node
    return false; 
  }
  
  public boolean addEdge(Node a, Node b){
    
    return false; 
  }
  
  public boolean deleteEdge(){
    return false;
  }
  
  
  // -----------
  
}
