/*
  Emanuel W.
  Nov 22, 2018
  This is my Particle System. The particles start in a spiral and 
  bounce off one another and the walls. 
  Press space to start the animation. 
  Each particle slightly changes color on each bounce.
*/

ArrayList<Particle> p = new ArrayList<Particle>();
boolean start = false;

final int pCount = 100;
final float maxSpeeds = 1;
final float maxMass = 1, minMass = 1;
Container container;

void setup() {
  size(1800,900,P3D);  
  setupParticlesInSpiral();
  container = new Container(200, 200); 
  frameRate(120);
}

void draw() {
  background(255);
  
  for (int i = 0; i < p.size(); i++) {
    stroke(color(p.get(i).r, p.get(i).g, p.get(i).b));
    
    if (start)
      p.get(i).updatePosition();
    p.get(i).draw();
  }
  
 container.draw(); 
}

void keyPressed() {
  if (key == ' ')
    start = !start;
}

void setupParticlesInSpiral() {
  float x, y;
  float angleOfRotation = 0;
  int layer = 0;
  int layerParticleCount = 0;
  float mass;
  Particle temp = new Particle(-100, -100, 0, 0, 1, -1);
  
  for (int i = 0; i < pCount; i++) {
    x = float(width)/2 + temp.diameter * layer * cos(angleOfRotation * i);
    y = float(height)/2 + temp.diameter * layer * sin(angleOfRotation * i);
    mass = random(minMass, maxMass);
    
    p.add(new Particle(x, y, random(-maxSpeeds, maxSpeeds), 
          mass * random(-maxSpeeds, maxSpeeds), mass, i));
    layerParticleCount++;
    
    if (i == 0 || angleOfRotation * (layerParticleCount + 1) > 2*PI) {
      layer++;
      layerParticleCount = 0;
      angleOfRotation = 2*PI * temp.diameter * layer / temp.diameter;
      angleOfRotation = 2*PI / (int)angleOfRotation;
    }
  }
}
