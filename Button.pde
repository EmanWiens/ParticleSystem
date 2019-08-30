class Button {
  int rectX, rectY;      // Position of square button
  int rectSize = 90;     // Diameter of rect
  color rectColor, baseColor;
  color rectHighlight;
  color currentColor;
  boolean rectOver = false;
  
  public Button(int x, int y, String name) {
    rectColor = color(0);
    rectHighlight = color(51);
    baseColor = color(102);
    currentColor = baseColor;
    rectX = x-rectSize-10;
    rectY = y-rectSize/2;
  }
  
  public void draw() {
    update(mouseX, mouseY);
    
    if (rectOver) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    stroke(255);
    rect(rectX, rectY, rectSize, rectSize);
  }
  
  void update(int x, int y) {
    if ( overRect(rectX, rectY, rectSize, rectSize) ) {
      rectOver = true;
    }
  }
  
  void mousePressed() {
    if (rectOver) {
      currentColor = rectColor;
    }
  }
  
  boolean overRect(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}
