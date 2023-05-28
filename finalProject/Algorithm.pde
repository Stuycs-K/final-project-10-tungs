
// The algorithms that I implement will probably extend this Algorithm class
class Algorithm {
  int MAX_NODES = 100; 
  Graph graph;
  ArrayList<ArrayList<Edge>> adj; 
  ArrayList<Node> nodes;
  ArrayList<Edge> edges;
  
  ArrayDeque<ArrayList<Transition>> list; // List of visual transitions to be processed 
  ArrayList<Transition> current; // current transition arraylist
  
  // Algorithm state variables
  boolean done = false; 
  
  // Graph visualizer variables
  color initialColor = color(255, 0, 0);
  color processingColor = color(0, 255, 0);
  color visitedColor = color(0, 0, 255); 
  
  color visited_color = color(0, 0, 255);
  color[] state_colors;
  
  
  int delay = 0, start = 0; 
  boolean waiting = false; 
  
  // Pause execution for this many milliseconds
  // Necessary condition: Synchronize this with the draw() function
  // to allow for "multithread execution"
  public void wait(int t){
   
  }
  
  public Algorithm(Graph graph){
    
    // Initialize information for a particular algorithm 
    this.graph = graph;
    adj = this.graph.adj;
    nodes = this.graph.nodes;
    edges = this.graph.edges;
    
    list = new ArrayDeque<ArrayList<Transition>>(); 
    current = new ArrayList<Transition>(); 
    
    state_colors = new color[MAX_NODES]; 
    
    // Initial colors for states
    // These may (or may not) be updated in specific algorithms 
    state_colors[0] = initialColor;
    state_colors[1] = processingColor;
    state_colors[2] = visitedColor; 
    
  }
  
  // ---------
 
  // Algorithm utility methods
  
  // This should be completed by specific algorithm
  void begin(){
    
  }
  
  void reset(){
    
  }
 
  // ------------
  // Graph visualizer methods
  void addTransition(Node node, color c1, color c2){
    current.add(new Transition(node, c1, c2)); 
  }
  
  void addTransition(Edge e, color c1, color c2){
    current.add(new Transition(e, c1, c2));
  }
  
  // Add a change in state from one to another 
  void addState(Node node, int i, int j){
    addTransition(node, state_colors[i], state_colors[j]); 
  }
  
  void addState(Edge e, int i, int j){
    addTransition(e, state_colors[i], state_colors[j]); 
  }
  
  // Add batch of transitions to deque 
  void addBatch(){
    if (current.size() == 0){
      println("Note: Current batch doesn't have any transitions");
      return; 
    }
    list.addFirst(current);
    
    current.clear();
    current = new ArrayList<Transition>(); 
  }
  
  // -------
}
