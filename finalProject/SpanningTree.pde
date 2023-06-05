import java.util.Collections;
import java.util.Comparator; 

/*
struct DSU {
    vector<int> e;
    DSU(int N) {e = vector<int>(N, -1);}
    int get(int x) {return e[x] < 0 ? x : e[x] = get(e[x]);} // path compression 
    int same_set(int a, int b) {return get(a) == get(b);}
    int size(int x) {return -e[get(x)];}
    
    bool unite(int x, int y){ // small to large merging
        x = get(x), y = get(y);
        if (x == y) return false;
        if (e[x] > e[y]) swap(x, y);
        e[x] += e[y]; e[y] = x; return true;// Merge y into x 
    }
    
    bool unite_manually(int x, int y){
      
    
};
*/
class DSU {
  int[] e;
  public DSU(int N) {
    e = new int[N]; 
    for (int i = 0; i < e.length; i++)
      e[i] = -1;
  }
 
  void swap(int x, int y){
    int data = e[x];
    e[x] = e[y]; e[y] = data;
  }
  
  int get(int x){
   if (e[x] < 0){
     return x; 
   }
   e[x] = get(e[x]);
   return e[x]; 
  }
  
  boolean same_set(int a, int b) {return get(a) == get(b);}
  int size(int x) {return -e[get(x)];}
  
  boolean unite(int x, int y){
     x = get(x); y = get(y);
     if (x == y) return false;
     if (e[x] > e[y]) swap(x, y);
     e[x] += e[y]; e[y] = x; return true;// Merge y into x 
  }
  
  boolean unite_manually(int x, int y){
    e[x] += e[y]; e[y] = x; return true; 
  }
  
  void reset(){
    for (int i = 0; i < e.length; i++)
      e[i] = -1; 
  }
}

class SpanningTree extends Algorithm {
  
  // State variables specific to algorithm
  int weight_sum = 0; // sum of weights of spanning tree 
  int num_nodes = 0;
  DSU dsu; 
  
  // Graph visualizer variables
  color treeColor = color(255, 255, 0); 
  color edgeColor = color(0, 255, 0); 
  color baseEdgeColor = color(220, 220, 220); 
  // int tag[];
  color[] component_colors; 
  
  // --------------------
  
  // Constructor
  public SpanningTree(Graph graph){
    super(graph);
   
    state_colors[1] = treeColor; 
    dsu = new DSU(MAX_NODES); 
    
    component_colors = new color[MAX_NODES];
    for (int i = 0; i < MAX_NODES; i++)
      component_colors[i] = color(random(255), random(255), random(255)); 
    
    batchProcessing = false; 
    
    works_directed = false; 
  }
  // ------------
  
  // Custom function
  /* Minimum spanning tree - Kruskal's algorithm
  Sort edges by some order
  For every edge:
    if (nodes not in same component):
      set nodes as active, if not active already
      add weight of edge to sum
  */
  void calculateTree(){
    // Sort edges by some order
    // In this case, in increasing order
    Collections.sort(edges, new Comparator<Edge>(){
      public int compare(Edge a, Edge b){
       int w1 = a.weight, w2 = b.weight;
       if (w1 < w2) return -1;
       if (w1 == w2) return 0;
       return 1; 
      }
    });
    if (!graph.weighted) Collections.shuffle(edges); 
 
    for (Node node : nodes){
      addTransition(node, node.DEFAULT, component_colors[node.id]); 
    }
    for (Edge e : edges)
      addTransition(e, e.DEFAULT, baseEdgeColor); 
    addBatch(); 
    // Text output 
    addMessage("Initialize: Set nodes to represent separate components"); 
    

    
    for (Edge e : edges){
      // if (e.undirected && e.hide) continue; 
      if (done) break; 
      if (!dsu.same_set(e.a.id, e.b.id)){
        weight_sum += e.weight;
        
        int repA = dsu.get(e.a.id), repB = dsu.get(e.b.id);
        if (dsu.e[repA] > dsu.e[repB]){
          int data = repA;
          repA = repB; repB = data; 
          // repA is larger component 
          // Now e[repA] <= e[repB]
        }
        int rep = repB, target = repA; 
       
        for (Node node : nodes){
          if (dsu.get(node.id) == rep)
            // addTransition(node, component_colors[rep], component_colors[target]);
            addTransition(node, color(255, 255, 255), component_colors[target]);
        }
        addTransition(e, e.EDGE_COLOR, edgeColor);
        addBatch(); 
        println("United: " + rep + " " + target);
        
        dsu.unite_manually(target, rep); 
        // Text output
        addMessage("United nodes of components: " + target + " and " + rep); 
        // ---
        if (target != dsu.get(e.a.id)){
          println("Check: " + target + " " + dsu.get(e.a.id)); 
        }
        //assert(target == dsu.get(e.a.id)); 
        if (dsu.size(target) == nodes.size()){
          done = true;
          println("Done finding MST"); 
        }
     
    }
  }
  for (Node node : nodes){
    println("Component of node = " + node.id + ": " + dsu.get(node.id)); 
  }
  
  resultText = "Spanning tree (forest) has been found in the graph";
 }
  // ---------------
  void begin(){
    assert(batchProcessing == false); 
    calculateTree(); 
  }

  void reset(){
    super.reset();
    dsu.reset(); 
    
    weight_sum = 0;
    num_nodes = 0; 
  }
  // ---------
  
  void randomizeColors(){
    super.randomizeColors();
    for (Node node : nodes){
      component_colors[node.id] = color(random(255), random(255), random(255)); 
    }
  }
  
}
