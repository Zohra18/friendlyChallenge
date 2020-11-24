/*

 Autumn Challenge !
 
 This challenge consists in creating an animated background based on our though and vision of what "autumn" represents.
 
 My vision of an animated background would be : 
 Landscape : Foreground is composed of a simple cosy grass place and a tree, then some wheat farms and stuff far away, very background is a mountain.
 Animations : Falling leaves, sun and clouds (with sunrays), birds
 Extra ideas : A key could change the weather ? Or the time (night / day) ? (We will see if I have time to do it since I BEGIN 22 days late lmao)
 Good luck cuz I wont put comments on that code.
 
 */

PImage sky;
PImage sun;
PImage cloud;
PImage landscape;
PImage tree;

Boolean day = true;

void setup() {

  size(1100, 600);
  background(50);

  sky = loadImage("sky.png");
  sun = loadImage("sun.png");
  cloud = loadImage("cloud.png");
  landscape = loadImage("landscape.png");
  tree = loadImage("tree.png");

  println("==========  SETUP DONE  ===========");
}


//
//
//
void draw() {

  background(50);

  image(sky, 0, 0, width, height);

  image(sun, 0, 0, width, height);
  image(cloud, 0, 0, width, height);
  image(landscape, 0, 0, width, height);
  image(tree, 0, 0, width, height);
}


void keyPressed() {

  if (key==' ') {
    day =! day;
    if (day) { //If we SET the day then the sun rises
      //Starts an "animation" where the sun rises slowly while the color of everything changes
    } else {//Otherwise the night comes
      //Starts an "animation where the sun sets down and the color of everything turns darker (slightly blue-ish)
    }
  }
}
