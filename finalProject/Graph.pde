
class Graph {
  int MAX_NODES = 100; 
  int N = 0; 
  
  ArrayList<ArrayList<Edge>> adj; 
  boolean[] vis, state, exists;
  Node[] rep; // if a node belongs to a certain id
  
  ArrayList<Node> nodes;
  ArrayList<Edge> edges;
  
  // Initial states of the graph 
  boolean undirected = true; 
  
  // Constructor
  public Graph(){
    // For existence of a node, check exists[] array 
    for (int i = 0; i < MAX_NODES; i++)
      adj.add(new ArrayList<Edge>());  

    vis = new boolean[MAX_NODES]; state = new boolean[MAX_NODES]; 
    exists = new boolean[MAX_NODES]; 
    
    rep = new Node[MAX_NODES]; 
    
    nodes = new ArrayList<Node>(); 
    edges = new ArrayList<Edge>(); 
    
  }
  
  public Graph(boolean undirected){
    this(); 
    this.undirected = undirected;
  }
  // --------------
  
  // Setup functions
  
  // Find least id that is not occupied yet 
  public int find_id(){
    for (int i = 0; i < MAX_NODES; i++)
      if (!exists[i]) return i; 
    
    return -1;
  }
  
  
  // ----------------
  
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

// Find edge given two nodes a, b 
public Edge findEdge(Node a, Node b) {return findEdge(a, b, this.edges);} 
public Edge findEdge(Node a, Node b, ArrayList<Edge> edges){
  for (int i = edges.size() - 1; i >= 0; i--){
    Edge e = edges.get(i);
    
    // Account for directed/undirected edges 
    if ((!undirected && (e.a == a && e.b == b))
       || (undirected && ( (e.a == a && e.b == b) || (e.a == b && e.b == a)))){
          println("Edge found"); return e; 
        }
  }
  return null; 
}


  // ---------------
  
  // Utility functions
  public void addNode(Node node){
   if (exists[node.id] || rep[node.id] != null) throw new IllegalArgumentException("Error: Can't add existing node in graph");
   
   // Make the node existent
   exists[node.id] = true;
   rep[node.id] = node; // Add to representative 
   nodes.add(node); 
  }
  
  // Add a node, but not manually 
  // i.e. pass constructor to the function, and it does the rest 
  public void addNode(int size, PVector position, color c){
    int id = find_id(); 
    if (id == -1) throw new IllegalStateException("Error: Tried to add node to a full adjacency list"); 
    
    Node node = new Node(size, position, c, id);
    addNode(node); 
  }
  
  public Node deleteNode(Node node){
    if (!exists[node.id] || rep[node.id] == null) throw new IllegalArgumentException("Error: Can't remove a nonexistent node"); 
    
    // First, remove edges in adjacency list and edge list 
    removeEdges(node);
    
    // Then, delete the node from existence 
    exists[node.id] = false;
    rep[node.id] = null;  // Remove from representative 
    nodes.remove(node); 
    
    // Return the node's reference in case it is needed
    return node; 
  }
  
  public void addEdge(Node a, Node b){
    Edge e = findEdge(a, b); 
    if (e != null) throw new IllegalArgumentException("Error: Tried to add existing edge in graph");
    if (!exists[a.id] || !exists[b.id]) throw new IllegalArgumentException("Error: Tried to add edge between nonexistent nodes in graph");
    
    Edge eFront = new Edge(a, b), eBack = new Edge(b, a); 
    // Add to adjacency list
    // Add to both lists if edge is undirected 
    adj.get(a.id).add(eFront); 
    if (undirected) adj.get(b.id).add(eBack); 
    
    // Add to edge list 
    edges.add(eFront);
  }
  
  public Edge deleteEdge(Edge e){
    if (e.a == null || e.b == null) throw new IllegalStateException("Error: Edge contains null nodes");
    if (!exists[e.a.id] || !exists[e.b.id]) throw new IllegalArgumentException("Error: Edge contains nodes that are not marked as existent");
    if (edges.indexOf(e) == -1) throw new IllegalStateException("Error: Tried to remove an edge that doesn't exist in edge list");
    
    // Remove edge from adjacency list 
    // Also account for undirected/directed edges 
    adj.get(e.a.id).remove(findEdge(e.a, e.b));
    if (undirected) adj.get(e.b.id).remove(findEdge(e.a, e.b)); 
    
    // The edge in edge list is not redundant, i.e. if (a, b) exists, then (b, a) should not exist 
    edges.remove(e); 
    
    // Return edge's reference if needed 
    return e; 
  }
  
  // Delete edge between (a, b) 
  public Edge deleteEdge(Node a, Node b){
    if (!exists[a.id] || !exists[b.id]) throw new IllegalArgumentException("Error (deleteEdge version #2): Edge contains nodes that are not marked as existent");
    return deleteEdge(findEdge(a, b, adj.get(a.id))); 
  }
  
  // For convenience, why not add another deleteEdge method for node ids
  public Edge deleteEdge(int a, int b){
    if (rep[a] == null || rep[b] == null) throw new IllegalStateException("Error: representative of nodes to be deleted are null"); 
    return deleteEdge(rep[a], rep[b]); 
  }
  
  // -----------
  
}
