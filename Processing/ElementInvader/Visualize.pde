static final int SHIFT_COL = 3; //8bpp-3bpp=5bpp, tadaaa
static final int RECT_SIZE = 25;

//simulate 5bit color
color getSimulated5BitColor(int ofs) {
  int col = colorArray[ofs];

  int r = (int) ((col>>16) & 255);
  int g = (int) ((col>>8)  & 255);
  int b = (int) ( col      & 255);

  r >>= SHIFT_COL;
  g >>= SHIFT_COL;
  b >>= SHIFT_COL;
  r <<= SHIFT_COL;
  g <<= SHIFT_COL;
  b <<= SHIFT_COL;

  return color(r, g, b);
}

//draw the grid
public void drawElements(int xx, int yy) {
  int xofs=xx;
  int srcOfs=0;
  int yofs=yy;

  stroke(40, 40, 40);
  for (int y=0; y<NR_OF_PIXELS_Y; y++) {
    xofs=xx;
    for (int x=0; x<NR_OF_PIXELS_X; x++) {
      fill(getSimulated5BitColor(srcOfs++));
      rect(xofs, yofs, RECT_SIZE, RECT_SIZE);
      
      xofs += RECT_SIZE;
    }
    yofs += RECT_SIZE;
  }

}

