static final int MODE_DEFAULT=0;
static final int MODE_RAINBOW=1;
static final int MODE_FIRE=2;

private int[] fireBuffer;
private Random r = new Random();

void initContent() {
  fireBuffer = new int[NR_OF_PIXELS_X*NR_OF_PIXELS_Y];
}

void fillGridWithColor() {
  int ofs=0;
  int i=0;  
  ColorSet cs = colorSet.get(colSet);

  switch(selectedMode) {

    //Elements
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

  int nextElement = 10+int(50*fpsSpeed);
  if (frame%nextElement==0) {
    selectedElement = int(random(elements.size())); 
    //println("selectedElement: "+selectedElement);
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

