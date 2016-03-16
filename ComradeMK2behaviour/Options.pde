// public variable class
static class options {

  // declare variables

  // led strip configuration
  static int   ledSize       = 60; 
  static float locationMax   = 600.0;
  static float locationMin   = 0.0;

  // sprite configuration
  static int spriteSize = 3;
  static int spriteTrans = 3;
  static float accelerationMult = 0.001;

  // sprite behaviour
  static int spriteSecurity = 10; // range from 0 to 10
  static int spritePlayfullnes = 0; // range from 0 to 10
  static int spriteDynamics = 0;// range from 0 to 10

  // sprite transformation
  static int spriteRangeRight = 0;
  static int spriteRangeLeft = 0;
  static int spriteScatter = 0;
  
  static boolean inputGui = true;
  static boolean inputComrade = false;
}