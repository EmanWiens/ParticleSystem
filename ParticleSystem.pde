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

int pCount = 200;
final float maxSpeeds = 5;
final float maxMass = 5, minMass = 1;
final float maxDiam = 2;
Container container;
final float maxLoops = 60;

void setup() {
  size(500,500,P3D);  
  setupParticlesInSpiral();
  container = new Container(400, 400);
}

void draw() {
  background(255);
  container.widthC = (int)(width * .8f);
  container.heightC = (int)(height * .8f);
  
  if (!start) {
    fill(0);
    String temp = "Press space to start";
    text(temp, width / 2 - textWidth(temp) / 2, textAscent());
  }
  
  for (int i = 0; i < p.size(); i++) {
    stroke(color(p.get(i).r, p.get(i).g, p.get(i).b));
    
    if (start) {
      p.get(i).updatePosition();
    }
    p.get(i).draw();
  }
  
  container.draw(); 
}

void keyPressed() {
  if (key == ' ') {
    start = !start;
  }
}

void setupParticlesInSpiral() {
  float x, y;
  float angleOfRotation = 0;
  int layer = 0;
  int layerParticleCount = 0;
  float mass;
  Particle temp = new Particle(-100, -100, 0, 0, maxMass * maxDiam / 2, -1);
  
  for (int i = 0; i < pCount; i++) {
    x = float(width)/2 + temp.diameter * layer * cos(angleOfRotation * i);
    y = float(height)/2 + temp.diameter * layer * sin(angleOfRotation * i);
    mass = random(minMass, maxMass);
    
    p.add(new Particle(x, y, random(-maxSpeeds, maxSpeeds), random(-maxSpeeds, maxSpeeds), mass, i));
    layerParticleCount++;
    
    if (i == 0 || angleOfRotation * (layerParticleCount + 1) > 2 * PI) {
      layer++;
      layerParticleCount = 0;
      angleOfRotation = 2*PI * temp.diameter * layer / temp.diameter;
      angleOfRotation = 2*PI / (int)angleOfRotation;
    }
  }
}
