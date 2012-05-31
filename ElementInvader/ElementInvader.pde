import controlP5.*;
import com.neophob.lpd6803.*;
import com.neophob.lpd6803.misc.*;
import processing.serial.*;

private static final int NR_OF_PIXELS_X = 20;
private static final int NR_OF_PIXELS_Y = 9;

private static final String VERSION = "ElementInvader v0.2";

//buffer
private int[] colorArray;  
private float fpsSpeed=1f;

//application logic
private int frame;
private int selectedMode=MODE_DEFAULT;

//color stuff
private int colSet=0;
private List<ColorSet> colorSet;

//elements logic
private List<Element> elements;
private int selectedElement=0;

void setup() {
  size(800, 600);
  background(0);
  frameRate(20);
  smooth();
    
  colorSet = new ArrayList<ColorSet>();
  colorSet.add( new ColorSet("RGB",         new int[] { color(255, 0, 0), color(0, 255, 0), color(0, 0, 255) } ));
  colorSet.add( new ColorSet("MiamiVice",   new int[] { color(27, 227, 255), color(255, 130, 220), color(255, 255, 255)  } ));
  colorSet.add( new ColorSet("LeBron",      new int[] { color(62, 62, 62), color(212, 182, 0), color(255, 255, 255) } ));
  colorSet.add( new ColorSet("ML581AT",     new int[] { color(105, 150, 85), color(242, 106, 54), color(255, 255, 255) } ));
  colorSet.add( new ColorSet("Neon",        new int[] { color(50, 50, 40), color(113, 113, 85), color(180, 220, 0) } ));
  colorSet.add( new ColorSet("Rasta",       new int[] { color(220, 50, 60), color(240, 203, 88), color(60, 130, 94) }));
  colorSet.add( new ColorSet("Brazil",      new int[] { color(0, 140, 83), color(46, 0, 228), color(223, 234, 0) } ));
  colorSet.add( new ColorSet("MIUSA",       new int[] { color(80, 75, 70), color(26, 60, 83), color(160, 0, 40) } ));
  colorSet.add( new ColorSet("Simpson",     new int[] { color(#d9c23e), color(#a96a95), color(#7d954b), color(#4b396b) } ));
  colorSet.add( new ColorSet("Kitty",       new int[] { color(#9f456b), color(#4f7a9a), color(#e6c84c) } ));
  colorSet.add( new ColorSet("Kitty HC",    new int[] { color(#c756a7), color(#e0dd00), color(#c9cdd0) } ));
  colorSet.add( new ColorSet("Smurf",       new int[] { color(#44bdf4), color(#e31e3a), color(#e8b118), color(#1d1628), color(#ffffff) } )); 
  colorSet.add( new ColorSet("Lantern",     new int[] { color(#0d9a0d), color(#000000), color(#ffffff) } )); 
  colorSet.add( new ColorSet("Fame 575",    new int[] { color(#540c0d), color(#fb7423), color(#f9f48e), color(#4176c4), color(#5aaf2e) } ));
  colorSet.add( new ColorSet("CGA",         new int[] { color(#d3517d), color(#15a0bf), color(#ffc062) } ));  
  colorSet.add( new ColorSet("B&W",         new int[] { color(#000000), color(#ffffff) } ));    
  colorSet.add( new ColorSet("Civil",       new int[] { color(#362F2D), color(#4C4C4C), color(#94B73E), color(#B5C0AF), color(#FAFDF2) } ));  
  colorSet.add( new ColorSet("Dribble",     new int[] { color(#3D4C53), color(#70B7BA), color(#F1433F), color(#E7E1D4), color(#FFFFFF) } ));  
  colorSet.add( new ColorSet("Castle",      new int[] { color(#4B345C), color(#946282), color(#E5A19B) } ));  
  colorSet.add( new ColorSet("Fizz",        new int[] { color(#04BFBF), color(#F7E967), color(#588F27) } ));    
  
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
