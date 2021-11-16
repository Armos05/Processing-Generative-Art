ArrayList<Planet> planets = new ArrayList<Planet>();
ArrayList<Planet> planetsB = new ArrayList<Planet>();
ArrayList<Planet> planetsT = new ArrayList<Planet>();

void setup() {
  size(500, 500);
  Planet planet1 = new Planet();
  planet1.s = 0.002;
  planet1.r = 35;
  planets.add(planet1);
}

float traceOrbit = 500;
float traceOrbit2 = 100;
float rSun = 250;
int i;

void draw() {
  translate(width/2, height/2);
  rotate(radians(-25));
  background(233);
  planetsB = new ArrayList<Planet>();
  planetsT = new ArrayList<Planet>();
  for (Planet planet : planets) {
    planet.setCoords(millis(), traceOrbit, traceOrbit2);
    if (planet.overLapping()) {
      planetsB.add(planet);
    } else {
      planetsT.add(planet);
    }
  }
  printHalfSun(false);
  printTrace();
  for (Planet planet : planetsT) {
    planet.display();
  }
  for (Planet planet : planetsB) {
    planet.display();
  }
  printHalfSun(true);
  makeNoise();
}


void printHalfSun(boolean top) {
  strokeWeight(4);
  if (top) {
    fill(0);
    stroke(233);
    arc(0, 0, rSun, rSun, PI, TWO_PI);
  } else {
    fill(0);
    stroke(233);
    arc(0, -0.3, rSun, rSun, 0, PI);
  }
}

void printTrace() {
  noFill();
  stroke(233);
  strokeWeight(12);
  ellipse(0, 0, traceOrbit, traceOrbit2); 

  noFill();
  stroke(0);
  strokeWeight(4);
  ellipse(0, 0, traceOrbit, traceOrbit2);
}

void mousePressed() {
  Planet planet1 = new Planet();
  planet1.s = random(0.0001, 0.004);
  planet1.r = random(20, 70);
  planets.add(planet1);
}

void keyPressed(){
  planets = new ArrayList<Planet>();
}

void makeNoise() {
  rotate(radians(25));
  noStroke();
  strokeWeight(1);
  for (int i = -width/2; i < width/2 - 1; i += 5) {
    for (int j = -height/2; j < height/2 - 1; j += 5) {
      fill(random(100, 255), random(20, 40));
      rect(random(i - 5, i), random(j - 5, j), random(1, 2), random(1 ,2));
    }
  }
  for (int i = 0; i < 15; i++) {
    fill(random(0, 255), 255);
    rect(random(-width, width/2), random(-height, height/2), 2, 2);
  }
}
