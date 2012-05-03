static final int MODE_DEFAULT=0;
static final int MODE_FAST=1;


void fillGridWithColor() {
  int ofs=0;

  switch(selectedMode) {

  case MODE_DEFAULT:
    //clear content
    for (int n=0; n<NR_OF_PIXELS_X*NR_OF_PIXELS_Y; n++) {
      colorArray[n] = 0;
    }
    
    //fill active element
    Element e = elements.get(selectedElement); 
    for (int n: e.getSelectedElements()) {
      colorArray[n] = color(200,200,60+random(140));
    }
    break;

  case MODE_FAST:
    for (int y=0; y<NR_OF_PIXELS_Y; y++) {
      for (int x=0; x<NR_OF_PIXELS_X; x++) {
        colorArray[ofs++] = color(random(255), random(255), random(255));
      }
    }
    break;
  }
  
  if (frame%fpsSpeed==0) {
    selectedElement = int(random(elements.size())); 
    println("selectedElement: "+selectedElement);
  }
}


