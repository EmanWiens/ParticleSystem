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

final int pCount = 1000;
final float maxSpeeds = .25;
final float maxMass = 1, minMass = .25;
float beforeMilli = 0, afterMilli = 0, diffMilli = 0;
float frameR = 60;

void setup() {
  size(640,640,P3D);  
  setupParticlesInSpiral();
}

void draw() {
  frameRate(frameR);
  background(255);
  beforeMilli = millis();
  
  for (int i = 0; i < p.size(); i++) {
    stroke(color(p.get(i).r, p.get(i).g, p.get(i).b));
    
    if (start)
      p.get(i).updatePosition(diffMilli);
    p.get(i).draw();
  }

  afterMilli = millis();
  diffMilli = afterMilli - beforeMilli;
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
