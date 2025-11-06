// Website Layout Wireframe — Full Replace (NO MUSIC)
// Features:
// - All footer buttons + labels
// - Theme switching with T
// - Play sets planet to 4x speed
// - Stars brightness tied to volume slider
// - Orbiting moon
// - Nebula + subtle blur-like effect (PGraphics)
// - Hover pulse on footer buttons
// Copy/paste this whole file into a new Processing sketch.

int theme = 0; // 0 = blue, 1 = green/purple, 2 = extra

// Stars
int numStars = 250;
float[] starX, starY, starSize, starSpeedX, starSpeedY, starPhase;
float starBaseBrightness = 40;

// Planet
float planetRotation = 0;
float ringRotation = 0;
float planetBaseSpeed = 0.05;
float planetSpeed = planetBaseSpeed;

// Moon
float moonAngle = 0;
float moonDistance = 260;
float moonSize = 40;

// Footer & controls
String[] icons = {"⏮", "⏪", "⏹", "▶", "⏸", "⏩", "⏭"};
String[] labels = {"PREV", "REWIND", "STOP", "PLAY", "PAUSE", "FFWD", "NEXT"};
float[] iconX;
float footerY;
float iconSize = 40;
int activeButton = -1;
float[] hoverScale;

// Volume slider
float volume = 0.5;
float sliderX, sliderY, sliderW;
boolean draggingSlider = false;

// Nebula layer
PGraphics nebulaLayer;

void setup() {
  fullScreen();
  smooth(8);
  noStroke();

  footerY = height - 50;

  iconX = new float[icons.length];
  hoverScale = new float[icons.length];
  for (int i = 0; i < hoverScale.length; i++) hoverScale[i] = 1.0;

  float cx = width / 2;
  float spacing = 80;
  for (int i = 0; i < icons.length; i++) {
    iconX[i] = cx + (i - 3) * spacing;
  }

  sliderW = 200;
  sliderX = width - 260;
  sliderY = footerY - 10;

  // Stars init
  starX = new float[numStars];
  starY = new float[numStars];
  starSize = new float[numStars];
  starSpeedX = new float[numStars];
  starSpeedY = new float[numStars];
  starPhase = new float[numStars];

  for (int i = 0; i < numStars; i++) {
    starX[i] = random(width);
    starY[i] = random(height);
    starSize[i] = random(1, 4);
    starSpeedX[i] = random(-0.05, 0.05);
    starSpeedY[i] = random(-0.03, 0.03);
    starPhase[i] = random(TWO_PI);
  }

  nebulaLayer = createGraphics(600, 400);
}

void draw() {
  drawBackground();
  drawStars();
  drawNebulaAndPlanet();
  drawLayout();
  drawFooter();

  updateHoverScales();
}

void drawBackground() {
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    int c;
    if (theme == 0) {
      c = lerpColor(color(5, 10, 40), color(0, 0, 0), inter);
    } else if (theme == 1) {
      c = lerpColor(color(90, 0, 140), color(0, 60, 180), inter);
    } else {
      c = lerpColor(color(0, 20, 30), color(0, 40, 60), inter);
    }
    stroke(c);
    line(0, y, width, y);
  }
}

void drawStars() {
  noStroke();
  // map volume 0..1 to brightness multiplier 0.1 .. 10
  float brightnessMult = map(volume, 0, 1, 0.1, 10.0);

  for (int i = 0; i < numStars; i++) {
    float flicker = 100 + 155 * abs(sin(frameCount * 0.02 + starPhase[i]));
    float alpha = (flicker + starBaseBrightness) * brightnessMult;
    alpha = constrain(alpha, 10, 255);
    fill(255, 255, 255, alpha);
    ellipse(starX[i], starY[i], starSize[i], starSize[i]);

    starX[i] += starSpeedX[i];
    starY[i] += starSpeedY[i];
    if (starX[i] < 0) starX[i] = width;
    if (starX[i] > width) starX[i] = 0;
    if (starY[i] < 0) starY[i] = height;
    if (starY[i] > height) starY[i] = 0;
  }
}

void drawNebulaAndPlanet() {
  // draw nebula to PGraphics then blur-like filter and render
  nebulaLayer.beginDraw();
  nebulaLayer.clear();
  nebulaLayer.noStroke();
  nebulaLayer.translate(nebulaLayer.width/2, nebulaLayer.height/2);

  if (theme == 0) {
    for (int i = 200; i > 0; i--) {
      float alpha = map(i, 200, 0, 0, 120);
      nebulaLayer.fill(60 + i / 3, 80 + i / 4, 255 - i / 2, alpha);
      nebulaLayer.ellipse(0, 0, i * 5, i * 2.5);
    }
  } else if (theme == 1) {
    for (int i = 200; i > 0; i--) {
      float alpha = map(i, 200, 0, 0, 130);
      nebulaLayer.fill(140 + i/5, 30 + i/3, 255, alpha);
      nebulaLayer.ellipse(0, 0, i * 5, i * 2.5);
    }
  } else {
    for (int i = 200; i > 0; i--) {
      float alpha = map(i, 200, 0, 0, 100);
      nebulaLayer.fill(40 + i/6, 200 - i/3, 140 + i/4, alpha);
      nebulaLayer.ellipse(0, 0, i * 5, i * 2.5);
    }
  }

  nebulaLayer.endDraw();
  nebulaLayer.filter(BLUR, 2);

  pushMatrix();
  translate(350, height * 0.65);
  imageMode(CENTER);
  image(nebulaLayer, 0, 0, nebulaLayer.width, nebulaLayer.height);

  drawPlanet();
  drawMoon();

  popMatrix();
}

void drawPlanet() {
  planetRotation += planetSpeed;
  ringRotation += 0.3;

  // atmospheric glow
  for (int r = 230; r > 160; r--) {
    float alpha = map(r, 230, 160, 20, 80);
    if (theme == 0) fill(80, 130, 255, alpha);
    else if (theme == 1) fill(60, 255, 120, alpha);
    else fill(180, 120, 240, alpha);
    ellipse(0, 0, r * 2, r * 2);
  }

  // planet shading
  for (int r = 150; r > 0; r--) {
    float inter = map(r, 0, 150, 0, 1);
    int c1 = (theme == 0) ? color(40, 100, 255) : (theme==1 ? color(20,255,120) : color(100,30,220));
    int c2 = (theme == 0) ? color(10, 10, 40) : (theme==1 ? color(0,30,10) : color(5,5,20));
    int c = lerpColor(c1, c2, inter);
    float shade = map(r, 0, 150, 1, 0);
    fill(red(c) * shade, green(c) * shade, blue(c) * shade);
    ellipse(0, 0, r * 2, r * 2);
  }

  // cloud bands
  stroke(255, 255, 255, 50);
  noFill();
  for (int i = -70; i <= 70; i += 15) {
    float wave = 12 * sin(radians(planetRotation * 3) + i * 0.3);
    ellipse(0, i + wave, 280, 30);
  }

  // rim + rings
  noFill();
  stroke(255, 255, 255, 80);
  strokeWeight(2);
  ellipse(0, 0, 305, 305);

  pushMatrix();
  rotate(radians(ringRotation));
  stroke(180, 200, 255, 150);
  strokeWeight(8);
  ellipse(0, 0, 360, 130);
  stroke(255, 255, 255, 100);
  strokeWeight(4);
  ellipse(0, 0, 400, 150);
  popMatrix();
  noStroke();
}

void drawMoon() {
  moonAngle += 0.6 + planetSpeed * 0.2;
  float mx = cos(radians(moonAngle)) * moonDistance;
  float my = sin(radians(moonAngle)) * (moonDistance * 0.6);

  pushMatrix();
  translate(mx, my);
  for (int r = (int)moonSize; r > 0; r--) {
    float inter = map(r, 0, moonSize, 0, 1);
    int mc = lerpColor(color(220), color(80), inter);
    fill(red(mc), green(mc), blue(mc));
    ellipse(0, 0, r*2, r*2);
  }
  popMatrix();
}

void drawLayout() {
  float w = width;
  float h = height;

  stroke(255);
  fill(20, 20, 40, 180);
  rect(0, 0, w, h * 0.08);
  fill(255);
  textSize(28);
  text("Header", 40, h * 0.05);

  float boxW = w * 0.12;
  float boxH = h * 0.12;
  float startX = 100;
  float spacing = 40;
  float topY = h * 0.12;

  stroke(200);
  for (int i = 0; i < 4; i++) {
    fill(255, 255, 255, 30);
    rect(startX + i * (boxW + spacing), topY, boxW, boxH);
  }

  float row2Y = h * 0.3;
  for (int i = 0; i < 4; i++) {
    fill(255, 255, 255, 30);
    rect(startX + i * (boxW + spacing), row2Y, boxW, boxH);
  }
}

void drawFooter() {
  float footerH = 100;
  fill(20, 20, 40, 200);
  stroke(255);
  rect(0, height - footerH, width, footerH);

  fill(255);
  textSize(20);
  text("Footer", 40, height - 25);

  textAlign(CENTER, CENTER);
  textSize(30);
  noStroke();
  for (int i = 0; i < icons.length; i++) {
    float x = iconX[i];
    float s = hoverScale[i];
    pushMatrix();
    translate(x, footerY);
    scale(s);
    float glow = 120 + 80 * sin(frameCount * 0.05 + i);
    if (i == activeButton) glow = 255;
    fill(100, 150, 255, glow);
    ellipse(0, 0, iconSize * 1.6, iconSize * 1.6);
    fill(255);
    text(icons[i], 0, 2);
    popMatrix();

    textSize(12);
    fill(200);
    text(labels[i], x, footerY + iconSize * 1.2);
  }

  drawVolumeSlider();
}

void drawVolumeSlider() {
  stroke(180);
  line(sliderX, sliderY, sliderX + sliderW, sliderY);
  float knobX = sliderX + volume * sliderW;
  noStroke();
  fill(100, 150, 255);
  ellipse(knobX, sliderY, 18, 18);
  fill(255);
  textSize(16);
  textAlign(LEFT, CENTER);
  text("VOL", sliderX - 45, sliderY);
}

void mousePressed() {
  for (int i = 0; i < icons.length; i++) {
    float d = dist(mouseX, mouseY, iconX[i], footerY);
    if (d < iconSize) {
      activeButton = i;
      handleButton(i);
      return;
    }
  }

  if (mouseY > sliderY - 20 && mouseY < sliderY + 20 && mouseX > sliderX && mouseX < sliderX + sliderW) {
    draggingSlider = true;
    updateVolumeFromMouse();
  }
}

void mouseReleased() {
  activeButton = -1;
  draggingSlider = false;
}

void mouseDragged() {
  if (draggingSlider) {
    updateVolumeFromMouse();
  }
}

void updateVolumeFromMouse() {
  volume = constrain(map(mouseX, sliderX, sliderX + sliderW, 0, 1), 0, 1);
  // volume only affects visuals in this no-music version
}

void keyPressed() {
  if (key == 't' || key == 'T') {
    theme = (theme + 1) % 3;
  }
  // Keyboard play/pause convenience
  if (key == ' ') { // space toggles play/pause visual speed
    if (planetSpeed > planetBaseSpeed) planetSpeed = planetBaseSpeed;
    else planetSpeed = planetBaseSpeed * 4;
  }
}

void handleButton(int index) {
  switch (index) {
    case 0: // Prev - visual effect: speed up briefly
      planetSpeed = planetBaseSpeed * 4;
      break;
    case 1: // Rewind - slow spin
      planetSpeed = planetBaseSpeed * 1.5;
      break;
    case 2: // Stop
      planetSpeed = planetBaseSpeed;
      break;
    case 3: // Play
      planetSpeed = planetBaseSpeed * 4;
      break;
    case 4: // Pause
      planetSpeed = planetBaseSpeed;
      break;
    case 5: // FF
      planetSpeed = planetBaseSpeed * 1.5;
      break;
    case 6: // Next - speed boost
      planetSpeed = planetBaseSpeed * 4;
      break;
  }
}

void updateHoverScales() {
  for (int i = 0; i < icons.length; i++) {
    float d = dist(mouseX, mouseY, iconX[i], footerY);
    float target = (d < iconSize) ? 1.12 : 1.0;
    if (d < iconSize) {
      target += 0.02 * sin(frameCount * 0.2 + i);
    }
    hoverScale[i] += (target - hoverScale[i]) * 0.2;
  }
}
