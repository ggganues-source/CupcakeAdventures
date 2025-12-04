class Player {

  // variables
  int x;
  float y;

  int w;
  int h;

  // declare image arrays
  PImage[] upImages;
  PImage[] downImages;
  PImage[] leftImages;
  PImage[] rightImages;
  PImage[] idleImages;

  // declare animation objects
  Animation upAnim;
  Animation downAnim;
  Animation leftAnim;
  Animation rightAnim;
  Animation idleAnim;

  int score;

  // distance that you can jump upwards
  float jumpHeight;
  // y-value of the top of your jump
  float highestY;

  int left;
  int right;
  float top;
  float bottom;

  boolean isMovingLeft;
  boolean isMovingRight;

  boolean isJumping;
  boolean isFalling;

  int speed;

  boolean prevOnPlatform;

  // constructor
  Player(int startingX, int startingY, int startingW, int startingH) {
    x=startingX;
    y=startingY;
    w=startingW;
    h=startingH;

    score = 0;

    jumpHeight = 200;
    highestY = y-jumpHeight;

    left = x-w/2;
    right = x+w/2;
    top = y-h/2;
    bottom = y+h/2;

    isMovingLeft = false;
    isMovingRight = false;

    isJumping = false;
    isFalling = false;

    prevOnPlatform = false;

    speed = 5;

    // initialize image arrays
    upImages = new PImage[1];
    downImages = new PImage[1];
    leftImages = new PImage[1];
    rightImages = new PImage[1];
    idleImages = new PImage[1];

    for (int index=0; index<= upImages.length-1; index++) {
      upImages[index] = loadImage("up" + index + ".png");
    }
    for (int index=0; index<= downImages.length-1; index++) {
      downImages[index] = loadImage("down" + index + ".png");
    }
    for (int index=0; index<= leftImages.length-1; index++) {
      leftImages[index] = loadImage("left" + index + ".png");
    }
    for (int index=0; index<= rightImages.length-1; index++) {
      rightImages[index] = loadImage("right" + index + ".png");
    }
    for (int index=0; index<= idleImages.length-1; index++) {
      idleImages[index] = loadImage("idle" + index + ".png");
    }

    // initialize animation objects
    upAnim = new Animation(upImages, 1, 1);
    downAnim = new Animation(downImages, 1, 1);
    leftAnim = new Animation(leftImages, 1, 1);
    rightAnim = new Animation(rightImages, 1, 1);
    idleAnim = new Animation(idleImages, 1, 1);
  }


  // functions

  // draws player
  void render() {
    imageMode(CENTER);
    rectMode(CENTER);
    //   rect(x, y, w, h);

    if (isJumping == true) {

      upAnim.isAnimating = true;
      upAnim.display(x, y);
    } else if (isFalling == true) {

      downAnim.isAnimating = true;
      downAnim.display(x, y);
    } else if (isMovingLeft == true) {

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
  // "moves" (updates) the player's hitbox
  void move() {
    // update the bounds of the player
    left = x-w/2;
    right = x+w/2;
    top = y-h/2;
    bottom = y+h/2;
  }
  // makes player jump
  void jump() {
    if (isJumping==true) {
      y-=speed;
    }
  }
  // makes player fall after jumping
  void falling() {
    if (isFalling==true) {
      y+=speed;
      downAnim.isAnimating = true;
      downAnim.display(x, y);
    }
  }
  // max of the jump detects when the jump should stop
  void topOfJump() {
    if (y <= highestY) {
      isJumping=false; // stop jumping upward
      //isFalling=true; // stop falling downward
    }
  }
  // detects when the player should land and stop falling
  void land() {
    if (y >= height - h/2) {
      isFalling = false; // stop falling
      //   println("lose");
      x=w*2;
      y=height/2; // snap player to new platform
      state = 3;
    }
  }

  // check to see if the player is colliding with any platform
  // if the player is not colliding with any platforms, then make the player stop falling
  void fallOffPlatform(ArrayList<Platform> aPlatformList) {


    // check that the player is not in the middle of a jump
    // check that the player is not on the ground
    if (isJumping == false && y < height - h/2) {

      boolean onPlatform = false;

      for (Platform aPlatform : aPlatformList) {
        // if the player is colliding with a platform
        if (top <= aPlatform.bottom &&
          bottom >= aPlatform.top &&
          left <= aPlatform.right &&
          right >= aPlatform.left) {
          onPlatform = true; // make on platform true

          if (onPlatform == true && prevOnPlatform == false && aPlatform.canGetPoint == true)
            score();
          prevOnPlatform = true;
          aPlatform.canGetPoint = false;
        }
      }

      // if you are not on a platform, start falling
      if (onPlatform == false) {
        isFalling = true;
        prevOnPlatform = false;
        //aPlatform.canGetPoint = true;
      }
    }
  }
  void drawScore() {
    text(score, width/2+500, height/2-300);
  }


  void score() {
    //text(score, width/2+500, height/2-300);
    score+=1;
  }
}
