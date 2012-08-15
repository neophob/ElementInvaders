import controlP5.*; 
import oscP5.*;
import com.neophob.lpd6803.*;
import com.neophob.lpd6803.misc.*;
import processing.serial.*;

private static final int OSC_PORT = 10000;

private static final int NR_OF_PIXELS_X = 20;
private static final int NR_OF_PIXELS_Y = 9;

private static final String VERSION = "ElementInvader v0.5";

//buffer
private int[] colorArray;  
private float fpsSpeed=0.5f;

//application logic
private int frame;
private int selectedMode=MODE_ALL_ELEMENTS;

//color stuff
private int colSet=0;
private List<ColorSet> colorSet;

//elements logic
private List<Element> elements;
private int selectedElement=0;

//OSC
private OscP5 oscP5;


void setup() {
  size(800, 600);
  background(0);
  frameRate(25);
  smooth();
  
  colorSet = loadColorsets();
  colorArray = new color[NR_OF_PIXELS_X*NR_OF_PIXELS_Y];
  initGui(getDefaultColorSetName(), getDefaultGeneratorNr(), getDefaultSpeed());
  initSerial();

  initElements();  
  initContent();

  updateTextfield(colorLoadMsg);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, OSC_PORT);
  updateTextfield("OSC Server startet on port "+ OSC_PORT);
}


void draw() {
  background(0);
  drawGradientBackground();
  fillGridWithColor();  
  drawElements(150, 25);

  sendSerial();
  frame++;
}

