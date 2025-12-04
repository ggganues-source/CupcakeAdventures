class Cupcake {

  // variables
  int x;
  float y;

  int w;
  int h;

  // declare image arrays
  PImage[] leftImages;
  PImage[] rightImages;
  PImage[] idleImages;

  // declare animation objects
  Animation upAnim;
  Animation downAnim;
  Animation leftAnim;
  Animation rightAnim;
  Animation idleAnim;

  int xSpeed;
  int ySpeed;

  boolean isMovingRight;
  boolean isMovingLeft;

  int left;
  int right;
  float top;
  float bottom;

  boolean collideWithCupcake;
  boolean onPlatform;

  int cupcakePlatIndex = 1;
  int howManySlides = 0;

  // constructor
  Cupcake(int startingX, int startingY, int startingW, int startingH) {
    x=startingX;
    y=startingY;
    w=startingW;
    h=startingH;

    // initialize image arrays
    leftImages = new PImage[1];
    rightImages = new PImage[1];
    idleImages = new PImage[2];

    for (int index=0; index<= leftImages.length-1; index++) {
      leftImages[index] = loadImage("cleft" + index + ".png");
    }
    for (int index=0; index<= rightImages.length-1; index++) {
      rightImages[index] = loadImage("cright" + index + ".png");
    }
    for (int index=0; index<= idleImages.length-1; index++) {
      idleImages[index] = loadImage("cidle" + index + ".png");
    }

    // initialize animation objects
    leftAnim = new Animation(leftImages, 0.05, 1);
    rightAnim = new Animation(rightImages, 0.05, 1);
    idleAnim = new Animation(idleImages, 0.05, 1);

    xSpeed = 5;

    left = x-w/4;
    right = x+w/4;
    top = y-h/4;
    bottom = y+h/4;

    collideWithCupcake = false;
    isMovingRight=false;
    isMovingLeft=false;
    onPlatform = true;
  }

  // functions

  // draws cupcake
  void renderCupcake() {
    rectMode(CENTER);
    fill(245, 161, 187);
    // rect(x, y, w, h);
  }

  // check to see if the player is colliding with a cupcake
  // if the player is not colliding with a cupcake, this makes the player win (switches state)
  void collisionCupcake(Player aPlayer) {

    //boolean collideWithCupcake = false;

    if (top <= aPlayer.bottom &&
      bottom >= aPlayer.top &&
      left <= aPlayer.right &&
      right >= aPlayer.left) {
      //  println("collide");
      collideWithCupcake = true; // make collision true
      state = 4;
    }
  }

  void moveCupcake() {
    if (isMovingRight==true) {
      x-=xSpeed;
    }

    if (isMovingLeft==true) {
      x+=xSpeed;
    }

    // update the bounds of the cupcake
    left = x-w/4;
    right = x+w/4;
    top = y-h/4;
    bottom = y+h/4;

    if (isMovingLeft == true) {

      leftAnim.isAnimating = true;
      leftAnim.display(x, y);
    } else if (isMovingRight == true) {

      rightAnim.isAnimating = true;
      rightAnim.display(x, y);
    } else {
      idleAnim.isAnimating = true;
      idleAnim.display(x, y);
    }
  }
  void stayOnPlatform(ArrayList<Platform> aPlatformList) {

    Platform currentPlat = aPlatformList.get(cupcakePlatIndex+howManySlides);

    x = currentPlat.x;
    y = currentPlat.y-h/2;

    howManySlides = 0;
    for (Platform aPlatform : aPlatformList) {
      // if the player is colliding with a platform
      if (aPlatform.x < 250) {
        //y=aPlatform.y;// make on platform true
        howManySlides++;
      }
    }
    howManySlides = constrain(howManySlides, 0, aPlatformList.size()-2);
  }
}
