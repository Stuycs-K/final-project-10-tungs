import java.util.Collections;
// I don't know how much time I have to work on Convex Hull,
// but if I have enough time this week, I'll try to implement this algorithm.

/* Demo code I wrote 
// This is reference for the java algorithm 
vector<Point> points;

int dist(Point p) {return p.x*p.x + p.y*p.y;}
Point operator - (Point a, Point b) {return {a.x - b.x, a.y - b.y};}
int cross(Point a, Point b){
    return a.x * b.y - a.y * b.x; 
}
int cross(Point a, Point b, Point c){
    return cross(b - a, c - a);
}

void sortOrder(vector<Point> &hull){
    sort(all(points), [&](Point a, Point b){
        if (a.y != b.y) return a.y < b.y;
        return a.x < b.x; 
    }); 
    hull.pb(points[0]);
    
    Point hinge = points[0]; 
    sort(all(points), [&](Point a, Point b){
        Point x = a - hinge, y = b - hinge;
        int dir = cross(x, y);
        return dir != 0 ? dir > 0 : dist(x) < dist(y); 
    }); 
}

signed main(){
    int N; cin >> N; points.resize(N); 
    for (int i = 0; i < N; i++){
        cin >> points[i].x >> points[i].y;
    }
    vector<Point> hull;
    sortOrder(hull); 
   
    // <= 0 to avoid collinear points
    cout << "Hinge: " << hull[0].x << " " << hull[0].y << endl; 
    for (int i = 1; i < N; i++){
        cout << "Point: " << points[i].x << " " << points[i].y << endl; 
        while (hull.size() > 1 && cross(hull[hull.size() - 2], hull.back(), points[i]) < 0){
            cout << "Cross product: " << cross(hull[hull.size() - 2], hull.back(), points[i]) << endl;
            hull.pop_back();
        }
        hull.pb(points[i]); 
    }
    cout << hull.size() << "\n";
    for (Point p : hull) cout << p.x << " " << p.y << "\n"; 
}

*/ 
class ConvexHull extends Algorithm {
   // Convex hull utility methods
   float cross(PVector a, PVector b){
     return a.x * b.y - a.y * b.x; 
   }
   
   float cross(PVector a, PVector b, PVector c){
     return cross(PVector.sub(b, a), PVector.sub(c, a)); 
   }
   
   float cross(Node a, Node b, Node c){
     return cross(a.position, b.position, c.position); 
   }
   
   float dist(PVector p){
     return sq(p.x) + sq(p.y); 
   }
   // --------
   
  
  // State variables specific to algorithm
   ArrayList<Node> hull;
   ArrayList<Edge> edgeList; 
   // Point list is just nodes 
   
  // Graph visualizer variables
  color activeColor = color(255, 255, 0);
  color edgeColor = color(0, 255, 0); 
  color defaultColor = color(255, 255, 255); 
  // --------------------
  
  // Constructor
  public ConvexHull(Graph graph){
    super(graph);
    hull = new ArrayList<Node>();
  }
  // ------------
  
  // Custom functions: sortPoints() and generateHull() 
  /*
  void sortOrder(vector<Point> &hull){
    sort(all(points), [&](Point a, Point b){
        if (a.y != b.y) return a.y < b.y;
        return a.x < b.x; 
    }); 
    hull.pb(points[0]);
    
    Point hinge = points[0]; 
    sort(all(points), [&](Point a, Point b){
        Point x = a - hinge, y = b - hinge;
        int dir = cross(x, y);
        return dir != 0 ? dir > 0 : dist(x) < dist(y); 
    }); 
}

  */
  
  // For both methods, assume nodes are not empty 
  void sortPoints(){
    Collections.sort(nodes, new Comparator<Node>(){
      public int compare(Node A, Node B){
        PVector a = A.position, b = B.position;
        if (a.y != b.y) return (a.y < b.y) ? -1 : 1;
        
        if (a.x == b.x) return 0;
        if (a.x < b.x) return -1;
        return 1; 
      }
    }); 
    Node hinge = nodes.get(0);
    hull.add(hinge);
    
    Collections.sort(nodes, new Comparator<Node>(){
      public int compare(Node A, Node B){
        PVector hinge = hull.get(0).position; 
        PVector a = A.position, b = B.position;
        PVector x = PVector.sub(a, hinge), y = PVector.sub(b, hinge); 
        
        // Floating point.. something to note 
        float dir = cross(x, y);
        if (dir != 0) return (dir > 0) ? -1 : 1;
        
        if (dist(x) == dist(y)) return 0;
        if (dist(x) < dist(y)) return -1;
        return 1;
      }
    });
    
    
  }
  
  void generateHull(){
    // Sort points
    sortPoints();
    
    // Test to see if points are in counterclockwise order
    /*
    for (Node node : nodes)
      addTransition(node, node.DEFAULT, activeColor);
    
    batchProcessing = false;
    for (Node node : nodes)
      addTransition(node, activeColor, node.DEFAULT);
    addBatch();
    batchProcessing = true;
    */
    
    batchProcessing = false; 
    for (Edge e: edges)
      addTransition(e, e.DEFAULT, defaultColor);
    addBatch();
    batchProcessing = true;
      
    // Generate convex hull 
    Node origin = hull.get(0);
    PVector hinge = origin.position;
    addTransition(origin, origin.DEFAULT, activeColor); 
    
    batchProcessing = false;
    for (int i = 1; i < nodes.size(); i++){
      while (hull.size() > 1 && cross(hull.get(hull.size() - 2), hull.get(hull.size() - 1), nodes.get(i)) < 0){
        // Remove point from convex hull if it forms concave polygon 
        Node node = hull.get(hull.size() - 1);
        addTransition(node, activeColor, node.DEFAULT); 
        hull.remove(hull.size() - 1); 
      }
      
      // Push the point into convex hull
      Node node = nodes.get(i); 
      hull.add(node); 
      addTransition(node, node.DEFAULT, activeColor); 
    }
  }
  
  // ----------
  
  // Utility functions
  
  void begin(){
    generateHull();
  }
  
  void reset(){
    super.reset();
    hull.clear();
    edgeList.clear(); 
  }
  
  // ------------
  
  void randomizeColors(){
    super.randomizeColors();
    activeColor = color(random(255), random(255), random(255)); 
    edgeColor = color(random(255), random(255), random(255)); 
  }
}
