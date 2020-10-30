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
import processing.sound.*;

//Sounds played when the candle is turned on/off
SoundFile candle_on, candle_off;

//Variables used for the candle fire actualisation (and everything that goes with it)
int T;
int timing = 80;

//Quantity of fire particles when the fire is on
int particles = 25, smoke_quantity = 350-45+10; //Smoke_quantity MUST be equal to height/2
int height_smoke = width/2-45;

//Boolean used to stock the state of the candle fire (on / off)
boolean light = true;

//Particles declaration
sparks[] spark;
smoke[] smoke_part;

//Images declaration
PImage front_pump, back_pump, candle;
PImage red_fire, orange_fire, yellow_fire;



//
//////////////////////////////////////////////////////////////////////////////////////////
//

void setup() {

  size(1200, 700);
  background(15);

  //Loads the sound files
  candle_on = new SoundFile(this, "candle_on.mp3");
  candle_off = new SoundFile(this, "candle_off.mp3");
  
  //Creating the sparks instances
  spark = new sparks[particles];

  for (int i=0; i<particles; i++) {
    spark[i] = new sparks();
  }

  smoke_part = new smoke[smoke_quantity];

  for (int i=0; i<smoke_quantity; i++) {
    smoke_part[i] = new smoke(i);
  }

  //Loading the Images;
  front_pump = loadImage("front_pump.png");
  back_pump = loadImage("back_pump.png");
  candle = loadImage("candle.png");

  red_fire = loadImage("red_fire.png");
  orange_fire = loadImage("orange_fire.png");
  yellow_fire = loadImage("yellow_fire.png");


  imageMode(CENTER);
  front_pump.resize(802/2, 488/2);
  back_pump.resize(802/2, 488/2);
  candle.resize(338/5, 313/5);

  //CENTER mode for all the shapes (coordinates specified define the center instead of the top-left corner)
  shapeMode(CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();            //No stroke on all shapes drawn
  
  T = millis();
}



void draw() {


  if (light) { // The candle is on
    //Candle light (ellipses)
    //Every so often, recalculates random values of 'alpha' and 'brightness' for the candle light.
    //This timing has been chosen so it seems more natural.
    
    
    if (millis() >= T  + timing) {    

      //Using the "background" here tells the program to erase everything on the screen.
      //Particles are erased only when this line is processed.
      //DELIBERATE USE OF THE BACKGROUND HERE
      //imo the particles look better if they leave a short "trail". Looks less natural without it.
      background(15);

      //Calculates a random "alpha" for the brightness of the candle fire
      //This alpha is used for the fire AND for the color of the candle and pumpkin
      int alpha = int(random(40));
      int brightness = 220 +alpha * 35 / 40;

      //Draws ellipses on the ground (for no specific reason, it just looks cool)

      fill(100, 100);
      ellipse(width/2, height/2+70, 1150, 160);

      fill(brightness, 50);
      ellipse(width/2, height/2+70, 750, 100);


      //Draws the back of the pumpkin.
      tint(brightness);
      image(back_pump, width/2, height/2);

      //Candle drawing.
      //tint(brightness,brightness,brightness);
      noTint();
      image(candle, width/2+10, height/2 + 32);


      //Coordinates for the candle fire
      int flamme_x = width/2 +10;
      int flamme_y = height/2+1;

      //Candle Fire
      //
      //NOTE : the variable resize of the fire makes processing strugle with the png's for some reason.
      //       After a few seconds, the fire is not an image but a square of one big orange pixel. Dunno why.
      //
      //Outer candle fire (red)
      tint(240, 180 + alpha);
      //red_fire.resize(15 + (alpha*5/40), 25 + (alpha*5/40));
      red_fire.resize(15,25);
      image(red_fire, flamme_x, flamme_y);

      //Middle candle fire (orange)
      tint(240, 190 + alpha);
      //orange_fire.resize(15 + (alpha*5/40), 25 + (alpha*5/40));
      orange_fire.resize(15,25);
      image(orange_fire, flamme_x, flamme_y);

      //Center candle fire (yellow-ish)
      tint(240, 180 + alpha);
      //yellow_fire.resize(15 + (alpha*5/40), 25 + (alpha*5/40));
      yellow_fire.resize(15,25);
      image(yellow_fire, flamme_x, flamme_y);

      T = millis();

    }

    //Calls the update function of the particles to update their locations (redraws them)
    for (int i=0; i<particles; i++) {
      spark[i].update();
    }


    //Drawing the pumpkin in front of everything   NOTE : Opacity is okay with PNGs and is just managed by Processing.
    tint(180);
    image(front_pump, width/2, height/2);
    
    
  } else { // The candle is not lit on !
    //We draw everything once and then actualize the particles to see them go off screen.

    //Using the "background" here tells the program to erase everything on the screen.
    //Complete dark as there is censed to be no light source
    background(0);

    //Draws the back of the pumpkin.
    tint(25);
    image(back_pump, width/2, height/2);

    //Candle drawing.
    //tint(brightness,brightness,brightness);
    tint(15);
    image(candle, width/2+10, height/2 + 32);      


    //Calls the update function of the particles to update their locations (redraws them)
    //They will stay out of the screen once they've reached the top
    for (int i=0; i<particles; i++) {
      spark[i].update();
    }
    
    //Thick smoke effect.
    for (int i=0; i<smoke_quantity; i++) {
      smoke_part[i].update();
    }
    if(height_smoke > -10){ //This is the limit of the smoke. Starting from the candle to the top. It's capped at the top of the screen.
    height_smoke += 1;
    }

    //Drawing the pumpkin in front of everything   NOTE : Opacity is okay with PNGs and is just managed by Processing.
    tint(25);
    image(front_pump, width/2, height/2);
  }
  
  //FPS counter (not really useful, just to know if I'm abusing my computer that much ^^'
      fill(255);
      textSize(20);
      text("fps :" + int (frameRate), 5, 25);
}


//
//
//////////////////////////////////////////////////////////////////////////////
//
// Classes for sparks and smoke particles.
//
//

class sparks { 
  float posX, posY, flight;
  sparks () {     //Generates the values. The spark will only go in one direction, and flight at a random speed
    posX = width/2; 
    posY = height/2-45; 
    flight = random(-4, -1);
  } 


  void update() { //Changes the place of the spark

    if (posY <= 0) { // As there is no function to delete an instance within the class, we just reset the values so the spark goes up again.
      if (light) { //If the candle is on, then resets the position
        posX = width/2;
        posY = height/2-45;
        flight = random(-4, -1);
      } else { // Otherwise placed the particles continuously out off the screen
        posX = -10;
        posY = -10;
      }
    } else {
      fill(120, 0, 0, 50);
      ellipse(posX, posY, 7, 7);
      fill(170, 120, 100, 50);
      ellipse(posX, posY, 3, 3);
    }
    posX += random(1, 5) * random(-1, 1);
    posY += flight;
  }
}



class smoke { 
  float posX, posY, rank; 
  smoke (float i) {                   //Generates the values. The smoke will draw a sine wave on a straight vertical axis
    posX = (width/2) +10 + 5*sin(((i)*2*PI/(smoke_quantity))); // Not a perfect sine. Need to adjust the small lateral uncontinuity that is linked to the -10 posY detection.
    posY = height/2-45;
    rank = i;
  } 


  void update() { //Changes the place of the smoke particles

    if (posY <= -10) { // As there is no function to delete an instance within the class, we just reset the values so the particles start their path again from the candle
      if (light) { //If the candle is on, then does not reset the position BUT resets the rank
      if(posY <= -10){
        posY = -10;
      }else{
        posY -= 1;
      }
        posY = -10;
      } else { // Otherwise resets the position and respects the path of the sine function
               //!\ The particles do not have to appear and draw at the same time ! Otherwise they will be at the same height.
               //To do that, I added a "rank" system. That way, since a particle will go upward one pixel at a time, we can simply know if it's time for it to move.
        posY = height/2-45;
      }
    } else {
      fill(40);
      ellipse(posX, posY, 4, 4);
    }
    if(posY >= (height/2 - height_smoke) + rank){ // If the smoke_part is under the limit, then we have to move it up !
      posY -= 1;
    }
  }
}


//
/////////////////////////////////////////////////////////
//
// This function does things whenever a key is pressed (more accurately, when the keeyboard sends an input)
//

void keyPressed() {
  switch (key) {
  case ' ':
    if(light){ // If the candle was on, then plays the "candle_off" sound
      candle_off.play();
    }else
    {
      candle_on.play();
    }
    light =! light;
    break;

  default :
    break;
  }
}
