//draw background
void drawGradientBackground() {
  this.loadPixels();	
  int ofs=this.width*(this.height-255);

  for (int y=0; y<255; y++) {
    int pink = color(y/3, y/3, y/2);
    for (int x=0; x<this.width; x++) {
      this.pixels[ofs+x] = pink;
    }
    ofs += this.width;
  }
  this.updatePixels();
}
