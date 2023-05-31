
class TextBox {
  PVector position;
  float x, y; 
  int sizeX, sizeY; 
  color DEFAULT = color(255, 255, 255);
  color STROKE_COLOR = color(0, 0, 0); 
  color TEXT_COLOR = color(0, 0, 0); 
  String text; 
  
  boolean transparent = false; 
  
  // Constructors
  public TextBox(PVector position, int sizeX, int sizeY){
    this.position = position;
    x = position.x; y = position.y;
    this.sizeX = sizeX;
    this.sizeY = sizeY; 
    text = ""; 
  }
  
  public TextBox(float x, float y, int sizeX, int sizeY){
    this(new PVector(x, y), sizeX, sizeY); 
  }
  
  public TextBox(float x, float y, int sizeX, int sizeY, String text){
   this(x, y, sizeX, sizeY);
   this.text = text; 
  }
  // -------
  
  // Utility methods
  boolean inPosition(int x2, int y2){
    float x1 = x, y1 = y;
    boolean X = x2 >= x1 - sizeX/2 && x2 <= x1 + sizeX/2;
    boolean Y = y2 >= y1 - sizeY/2 && y2 <= y1 + sizeY/2;
    
    if (X && Y) println("Clicked"); 
    return X && Y;
  }
  
  // ----------
  
  // Display methods
  void display(){
    fill(DEFAULT);
    stroke(STROKE_COLOR);
    
    if (!transparent)
      rect(x, y, sizeX, sizeY);
    
    
    fill(TEXT_COLOR); 
    text(text, x, y, sizeX, sizeY);
   
    // Note order of fill/stroke might affect output of other visual aspects
    // (Probably wont be an issue though)
  }
  // ---------
}
