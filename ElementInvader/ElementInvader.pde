import controlP5.*;
import com.neophob.lpd6803.*;
import com.neophob.lpd6803.misc.*;
import processing.serial.*;


private static final int NR_OF_PIXELS_X = 20;
private static final int NR_OF_PIXELS_Y = 9;

private static final String VERSION = "ElementInvader v0.1";

private int frame;

//buffer
private int[] colorArray;  
private int fpsSpeed;

//gui
private ControlP5 cp5;
private Slider fpsSlider;
private Textarea myTextarea;

//Serial
private Lpd6803 lpd6803;
private boolean initialized;
private long lastSendTime;

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

  frame++;
}
