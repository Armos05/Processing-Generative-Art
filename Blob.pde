class MetaBall {
  private PVector pos;
  private float radius;
  private PVector dir;
  private float speed;
  
  MetaBall(float r, float speed) {
    this.dir = new PVector(random(-1, 1), random(-1, 1));
    this.dir.normalize();
    this.dir.mult(speed);
    this.pos = new PVector(0, 0);
    this.radius = r;
    this.speed = speed;
  }
  
  void update() {
    pos.add(dir);
    
    if (abs(pos.x) > width/2) {
      dir.x *= -1;
    }
    if (abs(pos.y) > height/2) {
      dir.y *= -1;
    }
  }
}

float fRate = 30;
float fCount = 450; // 15sec
float fDiv = 3; // 150 frames

PImage canvas;
int numBalls = 9;
MetaBall balls[];
float minSize = 8.0f;
float maxSize = 20.0f;
float hW, hH;

void setup() {
  size(640, 640);
  smooth();

  frameRate(fRate);

  // drawing pixels into a canvas on this one
  canvas = createImage(width, height, ALPHA);
  canvas.loadPixels();
  
  hW = width/2;
  hH = height/2;
  
  balls = new MetaBall[numBalls];
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new MetaBall(random(minSize, maxSize*1.5f), 2.4);
  }
}

color colorLookup(float i) {
  // input should be 0 to 1
  // these conditions set the banding ranges for colors and cause different looks
  if (i < 0.25) {
    return color(248,248,248);
  } else if (i < 0.4) {
    return color(221,221,221);
  } else if (i < 0.55) {
    return color(122,207,221);
  } else if (i < 0.8) {
    return color(15,32,67);
  } else {
    return color(213,164,88);
  }
}

void draw() {
  if (frameCount > fCount)
    noLoop();
  background(0);
  
  for (int i = 0; i < numBalls; i++) {
    balls[i].update();
  }
  
  for (int i = 0; i < height * width; i++) {
    float col = 0.0f;
 
    for (int m = 0; m < numBalls; m++) {
      int y = floor(i / width); // faster than using int
      int x = i % width;
 
      float xx = (balls[m].pos.x + hW) - x;
      float yy = (balls[m].pos.y + hH) - y;
 
      col += balls[m].radius / sqrt( xx * xx + yy * yy);
    }
    
    canvas.pixels[i] = colorLookup(col);
  }
  
  canvas.updatePixels();
  image(canvas, 0, 0);
  
  //// video
  saveFrame("output/frame########.png");
  //// gif
  //if (frameCount % fDiv == 0) saveFrame("output/frame####.gif");
}
