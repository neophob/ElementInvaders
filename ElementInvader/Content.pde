static final int MODE_SINGLE_ELEMENT=0;
static final int MODE_RAINBOW=1;
static final int MODE_FIRE=2;
static final int MODE_ALL_ELEMENTS=3;
static final int MODE_PULSE_ELEMENTS=4;

static int[] darkElements = new int[] {
  0, 20, 40, 60, 80, 100, 120, 140, 160, //left boarder
  19, 39, 59, 79, 99, 119, 139, 159, 179, //right boarder
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, //top tow
  161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 
  2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, //first row
  22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, //second row
  43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 
  63, 64, 65, 66, 67, 68, 69, 70, 71, 72
};

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
  switch(selectedMode) {

    //Elements
  case MODE_SINGLE_ELEMENT:
    int activeCol = cs.getSmoothColor(speedFrame);
    int inactiveCol = cs.getSmoothColor(speedFrame+128);

    //clear content
    for (int n1=0; n1<NR_OF_PIXELS_X*NR_OF_PIXELS_Y; n1++) {
      colorArray[n1] = inactiveCol;
    }

    //fill active element
    Element e = elements.get(selectedElement); 
    for (int n1: e.getSelectedElements()) {
      colorArray[n1] = activeCol;
    }

    //draw dark elements
    for (int n1: darkElements) {
      colorArray[n1] = 0;
    }

    int nextElement = 10+int(50*fpsSpeed);
    if (speedFrame%100==1) {
      selectedElement = int(random(elements.size())); 
      //println("selectedElement: "+selectedElement);
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

    //draw dark elements
    for (int n2: darkElements) {
      colorArray[n2] = 0;
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

    //draw dark elements
    for (int n2: darkElements) {
      colorArray[n2] = 0;
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

