//Halloween challenge given by Luxius : Create a jack o' lantern. (Pumpkin with a face and a candle in it)
//Created by _OmniXx, October 17
//Challenge end : October, 31
//
//


/*

 
 My ideas :
 
 The candle is kinda like a rectangle, with a little black line over it, on top of wich I will put an ellipse randomly changing it's size and color.
 I could put 3 ellipses,  a big one kinda red/orang - ish, a medium one slightly changing color and size, and a last one small and sintering.
 
 For the pumpkin, I'll do an empty ellipse atm but it's going to change or watever. It's going to be an arrangment of orange lines and shapes.
 
 Dark background of course.
 
 Ideas for the future : lights up the area around the candle and the mouse only.
 "Moving" jaw for the pupkin (or animated parts)
 
 */


int alpha;
int T;
int particles = 25;

sparks[] spark;

PImage front_pump, back_pump, candle;




void setup() {

  size(1200, 700);
  background(20);

  //Creating the sparks instances
  spark = new sparks[particles];

  for (int i=0; i<particles; i++) {
    spark[i] = new sparks();
  }
  
  
  //Loading the Images;
  front_pump = loadImage("front_pump.png");
  back_pump = loadImage("back_pump.png");
  candle = loadImage("candle.png");

  imageMode(CENTER);
  front_pump.resize(802/2,488/2);
  back_pump.resize(802/2,488/2);
  candle.resize(338/5,313/5);
  
  shapeMode(CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);

  T = millis();
}



void draw() {

  
  
  
  
  //Candle light (ellipses)
  //Every so often, redraws the candle and the light within it.
  //Can be used only to create new values as the program may redraw everything everytime.
  if (millis() >= T  + 80) {    
    
    background(20);
    
    //Draws the back of the pumpkin.
    image(back_pump,width/2,height/2);

    //Candle drawing.
    image(candle,width/2+10,height/2 + 32);
    
    int flamme_x = width/2 +10;
    int flamme_y = height/2;
    
    alpha = 190 + int(random(40));
    fill(120, 30, 30, alpha);
    noStroke();
    ellipse(flamme_x, flamme_y, 15, 30);

    alpha = 190 + int(random(40));
    fill(250, 100, 10, alpha);
    noStroke();
    ellipse(flamme_x, flamme_y, 8, 18);

    alpha = 180 + int(random(20));
    fill(240, 220, 220, alpha);
    noStroke();
    ellipse(flamme_x, flamme_y, 4, 6);

    T = millis();
  }




  //Calls the update function of the particles to update their locations
  for (int i=0; i<particles; i++) {
    spark[i].update();
  }
  
  
  //Drawing the pumpkin in front of everything   NOTE : Opacity is okay with PNGs and is just managed by Processing.
  image(front_pump,width/2,height/2);
  
  
  //FPS counter (not really useful, just to know if I'm abusing my computer that much ^^'
  fill(255);
  textSize(20);
  text("fps :" + int (frameRate),5,25);
}



class sparks { 
  float posX, posY, flight; 
  sparks () {     //Generates the values. The spark will only go in one direction, and flight at a random speed
    posX = width/2; 
    posY = height/2-45; 
    flight = random(-4, -1);
  } 
  
  
  void update() { //Changes the place of the spark

    if (posY <= 0) { // As there is no function to delete an instance within the class, we just reset the values so the spark goes up again.
      posX = width/2;
      posY = height/2-45;
      flight = random(-4, -1);
    } else {
      fill(120, 0, 0, 50);
      ellipse(posX, posY, 8, 8);
      fill(170, 120, 100, 50);
      ellipse(posX, posY, 3, 3);
    }
    posX += random(1, 5) * random(-1,1);
    posY += flight;

  }
} 
