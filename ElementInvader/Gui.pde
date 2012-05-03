void initGui() {
  cp5 = new ControlP5(this);

  // add a vertical slider
  fpsSlider = cp5.addSlider("Speed")
    .setPosition(300, 380)
      .setSize(200, 20)
        .setRange(0, 1)
          .setValue(.6)
            ;
}


void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(fpsSlider)) {
    fpsSpeed = int(theEvent.getValue());
    return;
  }
  
}
