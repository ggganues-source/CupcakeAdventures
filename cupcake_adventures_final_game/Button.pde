class Button {

  //////////////////////////////////////////////////////////////////
  // vars (represents the position, size, speed, and color of the button)
  //////////////////////////////////////////////////////////////////
  int x;
  int y;
  int w;
  int h;
  int c;


  //////////////////////////////////////////////////////////////////
  // construction (sets the values for the creation of the button in render, and initializes the values for other functions)
  //////////////////////////////////////////////////////////////////
  Button(int x1, int y1, int w1, int h1, int c1) {
    x = x1;
    y= 100;
    y = y1;
    w = w1;
    h = h1;
    c= c1;
  }

  //////////////////////////////////////////////////////////////////
  // functions
  //////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////// this function draws the button (display)
  void bRender() {

    stroke(98, 2, 58);
    fill(214, 41, 105);
    strokeWeight(10);
    rect(x, y, w, h, 10);
  }

  /////////////////////////////////////////////////////// this function identifies minimums and maximums
  boolean isItBetween(int posn, int min, int max) {

    if (posn > min && posn < max) {
      return true;
    } else {
      return false;
    }
  }
  ///////////////////////////////////////////////////////// this function sets the bounds for the button
  boolean isInButton() {
    int buttonLeft = x - w/2;
    int buttonRight = x + w/2;
    int buttonTop = y - h/2;
    int buttonBottom = y + h/2;

    if (isItBetween(mouseX, buttonLeft, buttonRight) && (isItBetween(mouseY, buttonTop, buttonBottom))) {
      return true;
    } else {
      return false;
    }
  }
  //////////////////////////////////////////////////////////// this function identifies when a button is pressed
  boolean isPressed() {
    if (isInButton() == true && mousePressed == true) {
      // println("test");
      return true;
    } else {
      return false;
    }
  }
}
