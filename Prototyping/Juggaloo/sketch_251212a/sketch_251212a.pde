/* Centered Text Example */

fullScreen();

int appWidth  = displayWidth;
int appHeight = displayHeight;

// DIV (Rectangle)
float stringDivX      = appWidth * 1/4.0;
float stringDivY      = appHeight * 1/10.0;
float stringDivWidth  = appWidth * 1/2.0;
float stringDivHeight = appHeight * 1/10.0;

// Text
String title = "Wahoo!";
float fontSize = 116.0;
PFont titleFont = createFont("Dubai-Regular", fontSize);

// Draw DIV
rect(stringDivX, stringDivY, stringDivWidth, stringDivHeight);

// Set ink
fill(#2C08FF);

// CENTER the text
textAlign(CENTER, CENTER);   // ⭐⭐ THIS LINE DOES THE MAGIC

// Font
textFont(titleFont, fontSize);

// Draw centered text
text(title, stringDivX, stringDivY, stringDivWidth, stringDivHeight);

// Reset
fill(#FFFFFF);
