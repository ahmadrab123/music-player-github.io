
/* DIVs 2D Rectangles
- Step One: nameing the rectangles by referencing the variables
- Writing a computer program backwards from an object

Future Steps
- Step Two: developing the Display CANVAS & the Ternary Operator
- Step Three: populating variables (local v global and type)
*/
//
//Display CANVAS
//size(); //width //height
fullScreen(); //displayWidth //displayHeight
println(displayWidth, displayHeight);
int appWidth = displayWidth;
int appHeight = displayHeight;
//rect(x, y, width, height);
//Note: the debuggger expects rectangles to have float or double type variables
//Using Ratios
float imageX = appWidth * 1/4;
float imageY = appHeight * 1/4;
float imageWidth = appWidth * 1/2;
float imageHeight = appHeight * 1/2;
float playX1 = imageX + imageWidth * 1/4;
float playY1 = imageY + imageHeight * 1/4;
float playX2 = imageX + imageWidth * 3/4;
float playY2 = imageY + imageHeight * 2/4;
float playX3 = imageX + imageWidth * 1/4;
float playY3 = imageY + imageHeight * 3/4;
//
rect(imageX, imageY, imageWidth, imageHeight);

triangle(playX1, playY1, playX2, playY2, playX3, playY3);
