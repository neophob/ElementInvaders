static final int MODE_DEFAULT=0;
static final int MODE_RAINBOW=1;


void fillGridWithColor() {
  int ofs=0;
  ColorSet cs = colorSet.get(colSet);

  switch(selectedMode) {

  case MODE_DEFAULT:
    //clear content
    for (int n=0; n<NR_OF_PIXELS_X*NR_OF_PIXELS_Y; n++) {
      colorArray[n] = 0;
    }
    
    //fill active element
    Element e = elements.get(selectedElement); 
    for (int n: e.getSelectedElements()) {
      colorArray[n] = cs.getSmoothColor(frame);
    }
    break;

  case MODE_RAINBOW:
    int i=0;
    for (int y=0; y<NR_OF_PIXELS_Y; y++) {
      for (int x=0; x<NR_OF_PIXELS_X; x++) {
        colorArray[i++]=cs.getSmoothColor(int((frame+x+y<<1)*fpsSpeed));
      }
    }
    break;
  }
  
  int nextElement = 10+int(50*fpsSpeed);
  if (frame%nextElement==0) {
    selectedElement = int(random(elements.size())); 
    //println("selectedElement: "+selectedElement);
  }
}


