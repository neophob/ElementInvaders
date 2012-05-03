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
private int selectedMode=MODE_DEFAULT;
private List<Element> elements;
private int selectedElement=0;

void setup() {
  size(800, 500);
  background(0);
  frameRate(20);
  smooth();
  
  initGui();
//  initSerial();
  
  colorArray = new color[NR_OF_PIXELS_X*NR_OF_PIXELS_Y];
  
  elements = new ArrayList<Element>();
  elements.add(new Element("Noble gases", new int[] {20,40,60,80,100}));
  elements.add(new Element("Halogens", new int[] {42,43,44,45,46,47,48}));
  elements.add(new Element("Metalloids", new int[] {1,2,55,44}));
  elements.add(new Element("Actinides", new int[] {23,34,45,56,67,78}));
}


void draw() {
  background(0);
  drawGradientBackground();
  fillGridWithColor();  
  drawElements(150,25);
  
  sendSerial();
  frame++;
}
