static final int MODE_DEFAULT=0;
static final int MODE_FAST=1;

void fillWithDummyColor() {
  int ofs=0;
  int r=0, g=0, b=0;
  for (int y=0; y<NR_OF_PIXELS_Y; y++) {
    g+=25;
    b=2*g;
    for (int x=0; x<NR_OF_PIXELS_X; x++) {
      colorArray[ofs++] = color(r%255, g%255, b%255);
      r++;
    }
  }
}

