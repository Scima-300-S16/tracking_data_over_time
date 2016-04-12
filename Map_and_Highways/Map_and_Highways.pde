


float NOISE_SCALE = 0.004f;
int STEP = 20;
int count;
PImage bg;
int ARRAY_SIZE = 50;
 
int pointIndex = 0;
float[][] points = new float[50][];
 
public void setup() {
  bg = loadImage("Interstate_Highway.jpg");
  size (1000, 715);
  strokeWeight(4);
  noFill();
  count = (int) (width * 1.5 / STEP);
}
 
void drawPerlinCurve(float x, float y, float phase, float step, int count, float initAngle, int myColour) {
  pushStyle();
  stroke(0);
  beginShape();
  for (int i = 0; i < count; i++) {
    curveVertex(x, y);
    float angle = 2 * PI * noise(x * NOISE_SCALE, y * NOISE_SCALE, phase * NOISE_SCALE) + initAngle;
    x += cos(angle) * step;
    y += sin(angle) * step;
  }
  endShape();
  popStyle();
}
 
void draw() {
  pushStyle();
  background(bg);
  fill(32, 64);
  rect(0, 0, width, height);
  popStyle();
 
  float phase = frameCount / 2f;
 
  if (pointIndex == 0) {
    pushStyle();
    fill(0);  
    textSize(60);
    text("Draw your own highway!", 25, 25+50);
    popStyle();
    return;
  }
 
  int actualPoints = (pointIndex < ARRAY_SIZE) ? pointIndex : ARRAY_SIZE;
  for (int i = 0; i < actualPoints; i++) {
    int myColour = lerpColor(color(204, 51, 0), color(102, 153, 51), i / (float) actualPoints);
    drawPerlinCurve(points[i][0], points[i][1], phase, STEP, count, points[i][2], myColour);
  }
}
 
void mousePressed() {
  addLine();
}
 
void addLine() {
  int currentIndex = pointIndex % ARRAY_SIZE + 1;
  float[] newPoint = new float[3];
  newPoint[0] = mouseX;
  newPoint[1] = mouseY;
  if (pointIndex > 1) {
    float vectorX = newPoint[0] - points[(pointIndex - 2) % ARRAY_SIZE][0];
    float vectorY = newPoint[1] - points[(pointIndex - 2) % ARRAY_SIZE][1];
    newPoint[2] = PI / 2 + atan(vectorY / vectorX);
  } else {
    newPoint[2] = 0;
  }
  points[currentIndex - 1] = newPoint;
  pointIndex++;
}

