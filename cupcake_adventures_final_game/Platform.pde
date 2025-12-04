class Platform {

  // variables
  int x;
  float y;
  int w;
  int h;

  int left;
  int right;
  float top;
  float bottom;

  boolean isMovingRight;
  boolean isMovingLeft;

  int xSpeed;

  boolean canGetPoint;

  // constructor

  Platform(int startingX, float startingY) {
    rectMode(CENTER);
    x=startingX;
    y=startingY;
    w=150;
    h=10;

    left = x-w/2;
    right = x+w/2;
    top = y-h/2;
    bottom = y+h/2;

    isMovingLeft = false;
    isMovingRight = false;

    xSpeed = 5;

    canGetPoint = true;
  }


  // functions

  // draws platform
  void render() {
    strokeWeight(20);
    stroke(255, 200, 58);
    // fill(226, 105, 158);
    fill(255, 185, 31);
    rect(x, y, w, h);
  }

  // detects when player collides with platform to stay on it
  void collideWithPlayer(Player aPlayer) {
    // if player colllides with a platform
    if (left < aPlayer.right &&
      right > aPlayer.left &&
      top < aPlayer.bottom &&
      bottom > aPlayer.top) {

      aPlayer.isFalling = false; // stop falling
      aPlayer.y = y-h/2-aPlayer.h/2;
      //int score = 0;
      //score+=1;
      //text(score, width/2+200, 100);
    }
  }
  // actually moves the platforms so it looks like the levels are scrolling
  void move() {
    if (isMovingLeft==true) {
      x+=xSpeed;
    }
    if (isMovingRight==true) {
      x-=xSpeed;
    }

    // update the bounds of the platform
    left = x-w/2;
    right = x+w/2;
    top = y-h/2;
    bottom = y+h/2;
  }
}
