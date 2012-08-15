boolean registerTextLabel = true;
//draw some rectangles
void drawBackgroundSlide(int ypos, int ysize, String sectionName) {

  int ofs=this.width*ypos;
  for (int y=0; y<ysize; y++) {
    for (int x=10; x<this.width-10; x++) {
      this.pixels[ofs+x] = slideBackground;
    }
    ofs += this.width;
  }

  for (int y=ypos-8; y<ypos; y++) {
    ofs=y*this.width;
    for (int x=10; x<80; x++) {
      this.pixels[ofs+x] = slideBackground;
    }
  }

  if (registerTextLabel) {
    Textlabel tl = cp5.addTextlabel(sectionName, "//"+sectionName, 10, ypos-6);
    tl.setFont(ControlP5.standard58);
  }
}


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
  
  drawBackgroundSlide(300, 51+25, "Color");
  drawBackgroundSlide(360+25, 51, "Generator");
  registerTextLabel=false;

  this.updatePixels();
}
