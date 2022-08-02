void setup() {
  size(880,420);
}

void draw(){
  if(mousePressed){
    fill(random(0,255));
  } else {
    fill(random(0,255));
  }
  ellipse(mouseX, mouseY, 80,80);
}
