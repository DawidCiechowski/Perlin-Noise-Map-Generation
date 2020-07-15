
//Global Variables
int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;

float flying = 0;

float[][] terrain;

//Main loop
void setup() {
  
  //Size of the window
  size(600, 600, P3D);
  cols = w / scl;
  rows = h/ scl;
  
  //Array holding terrain metrics
  terrain = new float[cols][rows];
}


void draw() {
  //Speed of camera traveling 
  flying -= 0.07;

  float yoff = flying;
  
  //Map the perlin noise values to the array.
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }


  background(0);
  strokeWeight(1);
  stroke(200, 180, 45);
  noFill();

  //Translate the camera view
  translate(width/2, height/2+50);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  
  //Nested loop for drawing triangle strips at given vertecies
  for (int y = 0; y < rows-1; y++) {
    color(240, 233, 45);
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
  
}