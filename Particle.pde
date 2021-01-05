class Particle {
  float x, y;
  PVector v;
  float diameter;
  int id;
  float mass;
  float r, g, b;
  boolean red = true, green = false, blue = false;
  boolean collided = false;

  public Particle(float x, float y, float vX, float vY, float mass, int id) {
    this.x = x;
    this.y = y;
    v = new PVector(vX, vY);
    this.id = id;
    this.mass = mass;
    diameter = mass * maxDiam;
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
  }

  boolean updatePosition() {
    x += v.x;
    y += v.y;
    
    checkForParticleCollision();
    boolean temp = updateFromWallCollision();
    fixOverlap();
    return temp;
  }
  
  void fixOverlap() {
    float dx, dy, radii;
    boolean noOverlap = false;
    
    while (!noOverlap) {
      for (int i = 0; i < p.size(); i++) {
        if (i != id) {
          dx = p.get(i).x - x;
          dy = p.get(i).y - y;
          
          radii = p.get(i).diameter / 2 + diameter / 2;
          
          noOverlap = true;
          if (sq(dx) + sq(dy) < sq(radii)) {
            noOverlap = false;
            
            if (p.get(i).x < x) { 
              x++; // += abs(v.x);
              p.get(i).x--; // -= abs(p.get(i).v.x);
            }
            else {
              x--; // -= abs(v.x);
              p.get(i).x++; // / += abs(p.get(i).v.x);
            }
            
            if (p.get(i).y < y) { 
              y++; // += abs(v.x);
              p.get(i).y--; // -= abs(p.get(i).v.x);
            }
            else {
              y--; // -= abs(v.x);
              p.get(i).y++; // / += abs(p.get(i).v.x);
            }
          }
        }
      }
    }
  }

  private boolean updateFromWallCollision() {
    boolean updated = false;
    // out on x
    if (x + diameter / 2 > container.rightMost()) {
      v.x = -v.x;
      updated = true;
      
      x = container.rightMost() - diameter / 2;
    } else if (x - diameter / 2 < container.leftMost()) {
      v.x = -v.x;
      updated = true;
      
      x = container.leftMost() + diameter / 2;
    }

    // on y
    if (y + diameter / 2 > container.lowerMost()) {
      v.y = -v.y;
      updated = true;
      
      y = container.lowerMost() - diameter / 2;
    } else if (y - diameter / 2 < container.upperMost()) {
      v.y = -v.y;
      updated = true;
      
      y = container.upperMost() + diameter / 2;
    }

    return updated;
  }
  
  void checkForParticleCollision() {
    float dx, dy, radii;
    
    for (int i = 0; i < p.size(); i++) {
      if (i != id) {
        dx = p.get(i).x - x;
        dy = p.get(i).y - y;
        
        radii = p.get(i).diameter / 2 + diameter / 2;
        
        if (sq(dx) + sq(dy) < sq(radii)) {
          updateFromParticleCollision(p.get(i));
          
          changeColor(this);
          changeColor(p.get(i));
        }
      }
    }
  }
  
  private void changeColor(Particle part) {
    if (part.red) {
      part.r++; 
      part.g--; 
      part.b--;
      
      if (part.g < 0)
        part.g = 0;
      if (part.b < 0)
        part.b = 0;
      
      if (part.r >= 255) {
        part.red = false;
        part.green = true; 
      }
    } 
    
    if (part.green) {
      part.r--; 
      part.g++; 
      part.b--;
      
      if (part.r < 0)
        part.r = 0;
      if (part.b < 0)
        part.b = 0;
      
      if (part.g >= 255) {
        part.green = false;
        part.blue = true;
      }
    } 
    
    if (part.blue) {
      part.r--; 
      part.g--; 
      part.b++;
      
      if (part.r < 0)
        part.r = 0;
      if (part.g < 0)
        part.g = 0;
      
      if (part.b >= 255) {
        part.blue = false;
        part.red = true;
      }
    }
  }

  private void updateFromParticleCollision(Particle p2) {
    // calculate where they are going
    // test if those paths intersect
    PVector n, un, ut, vec1n, vec2n, vec1t, vec2t;
    float v1n, v2n, v1t, v2t;
    
    if (id != p2.id) {
      n = new PVector(p2.x - x, p2.y - y);
      un = n.copy().normalize();
      ut = new PVector(-un.y, un.x);
      
      v1n = un.copy().dot(v);
      v1t = ut.copy().dot(v);
      
      v2n = un.copy().dot(p2.v);
      v2t = ut.copy().dot(p2.v);
      
      float copyOfv1n = v1n;
      v1n *= mass - p2.mass;
      v1n += 2 * p2.mass * v2n;
      v1n /= mass + p2.mass;
      
      v2n *= p2.mass - mass;
      v2n += 2 * mass * copyOfv1n;
      v2n /= mass + p2.mass;
      
      vec1n = un.copy().mult(v1n);
      vec1t = ut.copy().mult(v1t);
      
      vec2n = un.copy().mult(v2n);
      vec2t = ut.copy().mult(v2t);
      
      v = vec1n.add(vec1t);
      p2.v = vec2n.add(vec2t);
    }
  }

  void draw() {
    strokeWeight(diameter);
    point(x, y);
  }
}
