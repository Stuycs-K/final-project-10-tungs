
class Graph {
  int MAX_NODES = 100; 
  int N = 0; 
  
  ArrayList<ArrayList<Edge>> adj; 
  boolean[] vis, state, exists;
  
  ArrayList<Node> nodes;
  ArrayList<Edge> edges;
  
  // Initial states of the graph 
  boolean undirected = false;
  
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
  // 1. Remove from adjacency list
  // By default: in adj[i], a = the node, and b = to other node 
  ArrayList<Edge> list = adj.get(node.id);
  for (int i = list.size() - 1; i >= 0; i--){
    Edge e = list.get(i); 
    ArrayList<Edge> other = adj.get(e.b.id); 
    
    // This specific format allows for removal of both directed/undirected edges 
    if (findEdge(node, e.b, other) != null) other.remove(e); 
    list.remove(i); 
  }
  
  // 2. Remove from edge list 
  for (int i = edges.size() - 1; i >= 0; i--){
    Edge e = edges.get(i);
    if (e.a == node || e.b == node) edges.remove(i); 
  }
}

public Edge findEdge(Node a, Node b) {return findEdge(a, b, this.edges);} 
public Edge findEdge(Node a, Node b, ArrayList<Edge> edges){
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
  public void addNode(Node node){
   if (exists[node.id]) throw new IllegalArgumentException("Error: Can't add existing node in graph");
   
   // Make the node existent
   exists[node.id] = true;
   nodes.add(node); 
  }
  
  public Node deleteNode(Node node){
    if (!exists[node.id]) throw new IllegalArgumentException("Error: Can't remove a nonexistent node"); 
    
    // First, remove edges in adjacency list and edge list 
    removeEdges(node);
    
    // Then, delete the node from existence 
    exists[node.id] = false;
    nodes.remove(node); 
    
    
    // 2. Remove in the edge list
    
    // Return the node's reference in case it is needed
    return node; 
  }
  
  public void addEdge(Node a, Node b){
    
  }
  
  public Edge deleteEdge(Edge e){
    
    return e; 
  }
  
  
  // -----------
  
}
