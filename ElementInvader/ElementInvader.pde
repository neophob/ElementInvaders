import controlP5.*;
import com.neophob.lpd6803.*;
import com.neophob.lpd6803.misc.*;
import processing.serial.*;

private static final int NR_OF_PIXELS_X = 20;
private static final int NR_OF_PIXELS_Y = 9;

private static final String VERSION = "ElementInvader v0.1";

//buffer
private int[] colorArray;  
private int fpsSpeed=1;

//application logic
private int frame;
private int selectedMode=MODE_DEFAULT;
private List<Element> elements;
private int selectedElement=0;

void setup() {
  size(800, 500);
  background(0);
  frameRate(20);
  smooth();
  
  colorArray = new color[NR_OF_PIXELS_X*NR_OF_PIXELS_Y];
  initGui();
//  initSerial();
    
  initElements();  
}


void draw() {
  background(0);
  drawGradientBackground();
  fillGridWithColor();  
  drawElements(150,25);
  
  sendSerial();
  frame++;
}
