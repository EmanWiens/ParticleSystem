class Container {
  private int widthC, heightC; 
  public Container(int w, int h) {
    heightC = h; 
    widthC = w;
  }
  
  public void setWidth(int newW) { widthC = newW; }
  public void setHeight(int newH) { heightC = newH; }
  public int getWidth() { return widthC; }
  public int getHeight() { return heightC; }
  
  public float leftMost() { return width / 2 - widthC / 2; }
  public float rightMost() { return width / 2 + widthC / 2; }
  
  public float upperMost() { return height / 2 - heightC / 2; }
  public float lowerMost() { return height / 2 + heightC / 2; }
  
  public void draw() {
    float centerX = width / 2;
    float centerY = height / 2;
    
    float x1 = centerX - widthC / 2; 
    float x2 = centerX + widthC / 2;
    float y1 = centerY - heightC / 2; 
    float y2 = centerY + heightC / 2;
    
    strokeWeight(1);
    line(x1, y1, x1, y2);
    line(x2, y1, x2, y2);
    
    line(x1, y1, x2, y1);
    line(x1, y2, x2, y2);
  }
}
