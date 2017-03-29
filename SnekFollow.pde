/**
 * Follow 3  
 * based on code from Keith Peters. 
 * 
 * A segmented line follows the mouse. The relative angle from
 * each segment to the next is calculated with atan2() and the
 * position of the next is calculated with sin() and cos().
**/
 
ArrayList<PVector> segments;
float[] x = new float[80];
float[] y = new float[80];
float segLength = 11;
PVector velocity;
PVector target;
float snakeLength;
color red;
color green;


void setup() {
  velocity = new PVector(2.378, 1.375);
  target = new PVector(width/2, height/2);
  size(640, 360);
  strokeWeight(9);
  stroke(0,150,0);
  snakeLength = 10;
}

void draw() {
  background(0);
  dragSegment(0, target.x, target.y);
  for(int i=0; i<snakeLength; i++) {
    float segSize = map(snakeLength, 0, 80, 30, 10); 
    strokeWeight(segSize+i);
    dragSegment(i+1, x[i], y[i]);
  }
  target.add(velocity);
  if (target.x > width || target.x < 0){
    velocity.rotate(random(PI));
  }
  if (target.y > height || target.y < 0){
    velocity.rotate(random(PI));
  }
  if (snakeLength<79){
    if(frameCount%40 == 0){
      snakeLength++;
      velocity.x += .1;
      velocity.y += .1;
    }
  }
}

void dragSegment(int i, float xin, float yin) {
  float dx = xin - x[i];
  float dy = yin - y[i];

  float angle = atan2(dy, dx);  
  x[i] = xin - cos(angle) * segLength;
  y[i] = yin - sin(angle) * segLength;
  if(i%2 == 0){
    segment(x[i], y[i], angle, red);
  }
  else{segment(x[i], y[i], angle, green);}
}

void segment(float x, float y, float a, color c) {
  pushMatrix();
  translate(x, y);
  rotate(a);
  fill(c);
  line(0, 0, segLength, 0);
  popMatrix(); asd
}

void keyPressed(){
  if(keyCode == RIGHT){
    velocity.rotate(QUARTER_PI*.5);
  }
  if(keyCode == LEFT){
    velocity.rotate(-QUARTER_PI*.5);
  }
}