static final int MODE_SINGLE_ELEMENT=0;
static final int MODE_RAINBOW=1;
static final int MODE_FIRE=2;
static final int MODE_ALL_ELEMENTS=3;
static final int MODE_PULSE_ELEMENTS=4;
static final int MODE_SOLID=5;

// periodic table example: http://modelscience.com/PeriodicTable.html


private int[] fireBuffer;
private Random r = new Random();

void initContent() {
  fireBuffer = new int[NR_OF_PIXELS_X*NR_OF_PIXELS_Y];
}

void fillGridWithColor() {
  int ofs=0;
  int i=0;
  ColorSet cs = colorSet.get(colSet);
  int speedFrame = int(4*fpsSpeed*frame);
  
  Arrays.fill(colorArray,0);
  
  switch(selectedMode) {

    //Elements
  case MODE_SINGLE_ELEMENT:
    int activeCol = cs.getSmoothColor(speedFrame);

    //clear content
    for (int n1=0; n1<NR_OF_PIXELS_X*NR_OF_PIXELS_Y; n1++) {
      colorArray[n1] = 0;
    }

    //fill active element
    Element e = elements.get(selectedElement); 
    for (int n1: e.getSelectedElements()) {
      colorArray[n1] = activeCol;
    }

    if ((speedFrame/4)%30==1) {
      selectedElement = int(random(elements.size())); 
    }
    break;

  case MODE_ALL_ELEMENTS:
    int steps = 255 / elements.size();
    int n=0;

    //fill active element
    for (Element e2: elements) {
      int col = cs.getSmoothColor(speedFrame+n*steps);
      n++;

      for (int n2: e2.getSelectedElements()) {
        colorArray[n2] = col;
      }
    }

    break;

  //pulse animation
  case MODE_PULSE_ELEMENTS:
    steps = 255 / elements.size();
    n=0;    
    
    //fill active element
    for (Element e2: elements) {
      int pulse = int(64*sin(n*steps));
      int col = cs.getSmoothColor(speedFrame+pulse);
      n++;

      for (int n2: e2.getSelectedElements()) {
        colorArray[n2] = col;
      }
    }

    break;

    //Rainbow animation
  case MODE_RAINBOW:
    for (int y=0; y<NR_OF_PIXELS_Y; y++) {
      for (int x=0; x<NR_OF_PIXELS_X; x++) {
        colorArray[i++]=cs.getSmoothColor(int((frame+x+y<<1)*fpsSpeed));
      }
    }
    break;

    //Fire
  case MODE_FIRE:
    updateFire();
    for (int y=0; y<NR_OF_PIXELS_Y; y++) {
      for (int x=0; x<NR_OF_PIXELS_X; x++) {
        int fireOfs = y*NR_OF_PIXELS_X+x;
        colorArray[i++] = cs.getSmoothColor( fireBuffer[fireOfs] );
      }
    }
    break;
    
  case MODE_SOLID:
    int col = cs.getSmoothColor( frame );
    for (n=0; n<NR_OF_PIXELS_X*NR_OF_PIXELS_Y; n++) {
      colorArray[n] = col;
    }
  
  break;
    
  }
}


void updateFire() {
  int j = NR_OF_PIXELS_X * (NR_OF_PIXELS_Y-1);

  for (int i = 0; i < NR_OF_PIXELS_X; i++) {
    /* the lower the value, the intense the fire, compensate a lower value with a higher decay value*/
    if (r.nextInt(16) > 8) {
      /*maximum heat*/
      this.fireBuffer[j + i] = 255;
    } 
    else {
      this.fireBuffer[j + i] = 0;
    }
  }  

  /* move fire upwards, start at bottom*/
  int temp;
  for (int index = 0; index < NR_OF_PIXELS_Y-1; index++) {
    for (int i = 0; i < NR_OF_PIXELS_X; i++) {
      if (i == 0) {
        /* at the left border*/
        temp = fireBuffer[j];
        temp += fireBuffer[j + 1];
        temp += fireBuffer[j - NR_OF_PIXELS_X];
        temp /=3;
      } 
      else 
        if (i == this.NR_OF_PIXELS_X - 1) {
        /* at the right border*/
        temp = fireBuffer[j + i];
        temp += fireBuffer[j - NR_OF_PIXELS_X + i];
        temp += fireBuffer[j + i - 1];
        temp /= 3;
      } 
      else {
        temp = fireBuffer[j + i];
        temp += fireBuffer[j + i + 1];
        temp += fireBuffer[j + i - 1];
        temp += fireBuffer[j - NR_OF_PIXELS_X + i];
        temp >>= 2;
      }
      if (temp > 1) {
        /* decay */
        temp --;
      }
      this.fireBuffer[j - NR_OF_PIXELS_X + i] = temp;
    }
    j -= NR_OF_PIXELS_X;
  }
}

