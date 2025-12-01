void setup() {
  size(900, 500);
  background(255);
  smooth();
  stroke(0);
  strokeWeight(3);
  noLoop();
}

void draw() {
  // Colors
  color frameBlue = color(60,160,255);
  color gray = color(200);

  // ---- Wheels ----
  strokeWeight(8);
  noFill();
  ellipse(250, 350, 250, 250);  // Rear wheel
  ellipse(650, 350, 250, 250);  // Front wheel

  // ---- Frame ----
  strokeWeight(8);
  stroke(frameBlue);

  // Main frame triangle
  line(250, 350, 350, 200);
  line(350, 200, 600, 220);
  line(600, 220, 250, 350);

  // Seat tube
  line(350, 200, 350, 130);

  // Front fork
  line(600, 220, 630, 340);
  line(600, 220, 580, 340);

  // Top tube
  line(350, 130, 600, 220);

  // ---- Seat ----
  stroke(0);
  strokeWeight(4);
  fill(40);
  rect(320, 115, 80, 20, 10);
  fill(frameBlue);
  rect(360, 115, 40, 20, 10);

  // ---- Handlebars ----
  strokeWeight(6);
  line(600, 220, 650, 150);
  line(650, 150, 690, 150);
 
  strokeWeight(10);
  stroke(frameBlue);
  line(680, 150, 710, 150);

  // ---- Pedal crank ----
  stroke(0);
  strokeWeight(4);
  fill(gray);
  ellipse(440, 285, 90, 90);     // chainring
  line(440, 285, 480, 330);       // crank arm
  rect(475, 330, 30, 10);         // pedal

  // ---- Chain stay / derailleur ----
  stroke(0);
  strokeWeight(4);
  line(250, 350, 430, 300);       // bottom chain stay
  line(350, 200, 250, 350);       // seat stay

  // Simple derailleur shape
  strokeWeight(5);
  line(240, 350, 230, 370);
  line(230, 370, 250, 380);
}
