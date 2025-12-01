/* Aspect Ratio: Bike Only Demonstration
 - Old Man using arrays
 - introduction: set index manually
 */
//
//Display
//fullScreen(); //Landscape
size(500, 250); //Portrait, testing smaller DIVs ONLY
int appWidth = width; //displayWidth
int appHeight = height; //displayHeight
//println("Display VARS:", "appWidth:"+appWidth, "appHeight:"+appHeight);
//println("\t\t\t\tFullScreen, displayWidth:\t"+displayWidth, "\tdisplayHeight:\t"+displayHeight, "\n\t\t\t\tSize\t, width:\t\t"+width, "\theight:\t\t"+height);
//
//Population
float imageDivX = appWidth*1/4; //**Akward DIV
float imageDivY = appHeight*1/10;
float imageDivWidth = appWidth*1/2;
float imageDivHeight = appHeight*1/5; //  4/5  ** Make smaller to test Landscape
//
//Image Aspect Ratio Vars & Algorithm
//Directory or Pathway, Concatenation
String upArrow = "../../";
String folder = "light Folder"; //**Akward
String eyes = "eyes";
String fileExtensionJPG = ".jpg";
String imagePathway1 = upArrow + folder + eyes + fileExtensionJPG;
//println("Bike Pathway:", imagePathway1);
//Image Loading & Aspect Ratio
//
//Possible ERROR: NullPointerException on the Image
//PImage errorImage = loadImage( "Old man portrait.png" );
//PImage image1 = loadImage( imagePathway1 ); //i.e. pathway mispelled
//if ( image1 == null ) {
  println("NullPointerException on Image ... Spelling Mistake with Pathway Concatenation");
  //image1 = errorImage;
  exit(); //handled whenever the computer uses this part or Memory
//}
//Demonstrates alternate way to load an image without a pathway
//
int imageWidth1 = 356; //Hardcoded
int imageHeight1 = 286; //Hardcoded
//Aspect Ratio
float image1AspectRatio_GreaterOne = ( imageWidth1 >= imageHeight1 ) ? float(imageWidth1)/float(imageHeight1) : float(imageHeight1)/float(imageWidth1) ; //Ternary Operator
//ERROR, int populating float: truncating-adding zeros, casting
/* Line Notes
 - Hardcoded Greater-Than-One Aspect Ratio, x or / >1 or <1
 - 2D information from Image, Apsect Ratio Number
 - Answers how to make image bigger or smaller
 - Computer calculated DIV width & height
 - Computer needs to compare image to DIV size difference
 */
//println("Testing for Decimals, formula unsing ints:", imageWidth1/imageHeight1);
//println("After casting added, Aspect Ratio >1:", image1AspectRatio_GreaterOne);
//Algorithm Decisions (choice)
float imageWidthAdjusted1 = imageDivWidth;
float imageHeightAdjusted1 = ( imageWidth1 >= imageDivWidth ) ? imageWidthAdjusted1 * image1AspectRatio_GreaterOne : imageWidthAdjusted1 / image1AspectRatio_GreaterOne ; //Ternary Operator
//Verification: looks good
if ( imageHeightAdjusted1 > imageDivHeight ) {
  println("Image doesn't fit, program ended ... Fatal Flaw, must be solved ... Image doesn't show.");
  //exit();
  int indexWhile = 0; //Local Variable to IF-Statement
  //** WHILE Loops can run infinitely with an error if not controlled
  while ( imageHeightAdjusted1>imageDivHeight ) {
    println("Iteration of Percent WHILE Loop", indexWhile++); //prints value, then adds one, order is important in AP
    if ( indexWhile < 10000 ) {
      //Checking Image Size, below
    } else {
      //ERROR: Infinite Loop
      println("ERROR: infinite loop, Image Percent WHILE, value:", indexWhile);
      exit(); //doesn't work, must force WHILE Stop
      imageHeightAdjusted1=imageDivHeight; //makes WHILE False, stops WHILE
    } //End Check Infinite loop
    //Image Adjustment Percent v Pixel
    imageWidthAdjusted1 *= 0.70; // -= 1
    imageHeightAdjusted1 = imageWidthAdjusted1/image1AspectRatio_GreaterOne;
    println("Inspection of percent decrase:", imageWidthAdjusted1, imageHeightAdjusted1, imageDivHeight);
  } //End WHILE
  //Percent will be too small, must count back up but be smaller than total iterations
  /* Accuracy Comment, for AP Students
   - When % change is too much, go back to the previous answer, decrease percent until decreasing pixels is most accurate
   - Need to answer what is accurate
   - FYI: 1% gets within 3 pixels of actual answer
   - AP Project: combine into faster answer by counting lines of code executed
   */
  while ( imageHeightAdjusted1<imageDivHeight ) {
    println("Iteration of Pixel WHILE Loop", indexWhile++); //prints value, then adds one, order is important in AP
    if ( indexWhile < 10000 ) {
      //Checking Image Size
    } else {
      //ERROR: Infinite Loop
      println("ERROR: infinite loop, Image Pixel WHILE, value:", indexWhile);
      //exit(); //doesn't work, must force WHILE Stop
      imageHeightAdjusted1=imageDivHeight;
    }
    imageHeightAdjusted1++;
    println("Inspection of percent dcrease:", imageWidthAdjusted1, imageHeightAdjusted1, imageDivHeight);
  } //End WHILE Error Check, Counting Up
  //
} //END IF
//
//DIV
rect( imageDivX, imageDivY, imageDivWidth, imageDivHeight );
//
//image( image1, imageDivX, imageDivY, imageDivWidth, imageDivHeight );
//image( image1, imageDivX, imageDivY, imageWidthAdjusted1, imageHeightAdjusted1 );
//
//End Program
