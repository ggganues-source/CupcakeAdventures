int state = 0;
import processing.sound.*;

PImage background;
PImage[] cupcakeImagesStart;
PImage winchica;
Animation cupcakeStartAnimation;

SoundFile jumpSound;
SoundFile backgroundSound;

// declaring my vars
Cupcake c1;


Player p1;
Button b1;
Button b2;
Button b3;
Button b4;

Platform plat1;
Platform plat2;
Platform plat3;
Platform plat4;
Platform plat5;
Platform plat6;
Platform plat7;
Platform plat8;
Platform plat9;
Platform plat10;
Platform plat11;
Platform plat12;
Platform plat13;
Platform plat14;
Platform plat15;
Platform plat16;
Platform plat17;
Platform plat18;
Platform plat19;
Platform plat20;
Platform plat21;
Platform plat22;
Platform plat23;
Platform plat24;
Platform plat25;
Platform plat26;
Platform plat27;
Platform plat28;
Platform plat29;
Platform plat30;


ArrayList<Platform> platformList;

void setup() {
  rectMode(CENTER);
  imageMode(CENTER);
  pixelDensity(1);

  background = loadImage("background.png");
  cupcakeImagesStart = new PImage[6];
  winchica = loadImage("winchica.png");

  for (int index = 0; index<=cupcakeImagesStart.length-1; index+=1) {
    cupcakeImagesStart[index] = loadImage("cupcake" +str(index) +".png");
    //   cupcakeImagesStart[index].resize(150,150);
  }

  cupcakeStartAnimation = new Animation(cupcakeImagesStart, 0.05, 2);


  jumpSound = new SoundFile(this, "jump.mp3");
  backgroundSound = new SoundFile(this, "backgroundSound.mp3");

  size(1200, 800);
  background.resize(1200, 800);

  // initialize my vars

  p1 = new Player(100, height/2, 150, 150);

  platformReinitialize();

  b1 = new Button(width/2+400, height/2 - 200, 300, 150, color(131, 117, 122));
  b2 = new Button(width/2+400, height/2 + 200, 300, 150, color(131, 117, 122));
  b3 = new Button(width/2, height/2 + height/4, 300, 150, color(131, 117, 122));
  b4 = new Button(width/2, height/2 + height/4, 300, 150, color(131, 117, 122));

  c1 = new Cupcake(240, 450, 150, 150);
}

void draw() {
  background(background);
  // image(background, width/2, height/2);

  switch(state) {
  case 0:
    cupcakeStartAnimation.display(400, height/2);
    cupcakeStartAnimation.isAnimating = true;

    textMode(CENTER);
    b1.bRender();

    fill(245, 195, 67);
    textSize(100);
    text("Cupcake Adventures", width/2-600, height/2-275);

    fill(218, 185, 31);
    textSize(50);
    text("PLAY", width/2+350, height/2-180);

    b2.bRender();
    fill(218, 185, 31);
    text("QUIT", width/2+350, height/2+220);
    textSize(50);

    if (b1.isPressed() == true) {
      state = 2;
    }
    if (b2.isPressed() == true) {
      state = 1;
    }
    if (backgroundSound.isPlaying() == false) {
      backgroundSound.play();
    }
    break;

    //quit
  case 1:
    exit();
    break;
  case 2:
    c1.stayOnPlatform(platformList);
    c1.renderCupcake();
    c1.collisionCupcake(p1);
    c1.moveCupcake();

    p1.render();
    p1.move();
    p1.jump();
    p1.falling();
    p1.topOfJump();
    p1.land();
    p1.fallOffPlatform(platformList);
    fill(98, 2, 58);
    p1.drawScore();

    // for loop to go through all platforms
    for (Platform aPlatform : platformList) {
      aPlatform.render();
      aPlatform.move();
      aPlatform.collideWithPlayer(p1);
    }

    //if (backgroundSound.isPlaying() == false) {
    //  backgroundSound.play();
    //}
    break;

  case 3:
    b3.bRender();

    fill(218, 185, 31);
    text("MENU", width/2-60, height/2+220);
    textSize(50);
    p1.drawScore();

    if (b3.isPressed() == true) {
      cupcakeReinitialize();
      platformReinitialize();
      state = 0;
      p1.score = 0;
      playerReinitialize();
    }
    break;

  case 4:
    b3.bRender();

    image(winchica, 210, height/2);

    fill(218, 185, 31);
    text("YOU WIN!", width/2-100, height/2+220);
    textSize(50);
    p1.drawScore();

    if (b4.isPressed() == true) {
      cupcakeReinitialize();
      platformReinitialize();
      state = 0;
      p1.score = 0;
      playerReinitialize();
    }
  }
}

void keyPressed() {
  if (key == 'a') {
    for (Platform aPlatform : platformList) {
      aPlatform.isMovingLeft=true;
      p1.isMovingLeft = true;
      if (aPlatform.isMovingLeft == true) {
        c1.isMovingRight = true;
      }
    }
    if (c1.x==width/2) {
      c1.isMovingLeft = false;
    }
  }

  if (key == 'd') {
    for (Platform aPlatform : platformList) {
      aPlatform.isMovingRight=true;
      p1.isMovingRight = true;
      if (aPlatform.isMovingRight == true) {
        c1.isMovingLeft = true;
      }
    }
    if (c1.x==width/2) {
      c1.isMovingLeft = false;
    }
  }
  if (key == 'w' && p1.isJumping==false && p1.isFalling==false) {
    p1.isJumping = true; // start a new jump
    p1.highestY = p1.y-p1.jumpHeight;
    jumpSound.play();
    p1.isJumping = true;
  }
}

void keyReleased() {
  if (key == 'a') {
    for (Platform aPlatform : platformList) {
      aPlatform.isMovingLeft=false;
      p1.isMovingLeft = false;
      if (aPlatform.isMovingLeft == false) {
        c1.isMovingRight = false;
      }
    }
    if (c1.x==width/2) {
      c1.isMovingLeft = false;
    }
  }

  if (key == 'd') {
    for (Platform aPlatform : platformList) {
      p1.isMovingRight = false;
      aPlatform.isMovingRight=false;
      if (aPlatform.isMovingRight == false) {
        c1.isMovingLeft = false;
      }
    }
    if (c1.x==width/2) {
      c1.isMovingLeft = false;
    }
  }
}
void platformReinitialize() {

  plat1 = new Platform(100, random(400, 600));
  plat2 = new Platform(width/2-150, random(300, 500));
  plat3= new Platform(width/2+100, random(400, 600));
  plat4 = new Platform(width/2+500, random(300, 600));
  plat5 = new Platform(width/2+800, random(400, 600));
  plat6 = new Platform(width/2+1100, random(300, 600));
  plat7 = new Platform(width/2+1400, random(400, 600));
  plat8 = new Platform(width/2+1600, random(300, 500));
  plat9 = new Platform(width/2+1900, random(400, 600));
  plat10 = new Platform(width/2+2100, random(400, 600));
  plat11 = new Platform(width/2+2400, random(300, 500));
  plat12 = new Platform(width/2+2600, random(400, 600));
  plat13 = new Platform(width/2+2800, random(200, 460));
  plat14 = new Platform(width/2+3000, random(300, 600));
  plat15 = new Platform(width/2+3300, random(400, 600));
  plat16 = new Platform(width/2+3500, random(200, 500));
  plat17 = new Platform(width/2+3800, random(400, 600));
  plat18 = new Platform(width/2+4000, random(400, 600));
  plat19 = new Platform(width/2+4400, random(300, 600));
  plat20 = new Platform(width/2+4600, random(400, 600));
  plat21 = new Platform(width/2+4900, random(400, 700));
  plat22 = new Platform(width/2+5100, random(400, 600));
  plat23 = new Platform(width/2+5300, random(400, 600));
  plat24 = new Platform(width/2+5500, random(400, 500));
  plat25 = new Platform(width/2+5700, random(400, 600));
  plat26 = new Platform(width/2+5900, random(300, 600));
  plat27 = new Platform(width/2+6250, random(400, 700));
  plat28 = new Platform(width/2+6400, random(400, 600));
  plat29 = new Platform(width/2+6700, random(400, 600));
  plat30 = new Platform(width/2+7000, 650);


  platformList = new ArrayList<Platform>();
  platformList.add(plat1);
  platformList.add(plat2);
  platformList.add(plat3);
  platformList.add(plat4);
  platformList.add(plat5);
  platformList.add(plat6);
  platformList.add(plat7);
  platformList.add(plat8);
  platformList.add(plat9);
  platformList.add(plat10);
  platformList.add(plat11);
  platformList.add(plat12);
  platformList.add(plat13);
  platformList.add(plat14);
  platformList.add(plat15);
  platformList.add(plat16);
  platformList.add(plat17);
  platformList.add(plat18);
  platformList.add(plat19);
  platformList.add(plat20);
  platformList.add(plat21);
  platformList.add(plat22);
  platformList.add(plat23);
  platformList.add(plat24);
  platformList.add(plat25);
  platformList.add(plat26);
  platformList.add(plat27);
  platformList.add(plat28);
  platformList.add(plat29);
  platformList.add(plat30);
}

void cupcakeReinitialize() {
  c1 = new Cupcake(240, 450, 150, 150);
}

void playerReinitialize() {
  p1 = new Player(100, height/2, 150, 150);
}
