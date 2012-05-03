import controlP5.*;
import com.neophob.lpd6803.*;
import com.neophob.lpd6803.misc.*;
import processing.serial.*;

private static final int NR_OF_PIXELS_X = 20;
private static final int NR_OF_PIXELS_Y = 9;

private static final String VERSION = "ElementInvader v0.1";

//buffer
private int[] colorArray;  
private int fpsSpeed;

//application logic
private int frame;
int selectedMode=MODE_DEFAULT;


void setup() {
  size(800, 500);
  background(0);
  frameRate(20);
  smooth();
  
  initGui();
  initSerial();
  
  colorArray = new color[NR_OF_PIXELS_X*NR_OF_PIXELS_Y];
  fillWithDummyColor();  
}


void draw() {
  background(0);
  drawGradientBackground();
  drawElements(150,25);

  sendSerial();
  frame++;
}
