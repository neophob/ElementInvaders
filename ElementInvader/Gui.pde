int slideBackground = color(48, 48, 48);

void initGui() {
  cp5 = new ControlP5(this);

  // add a vertical slider
  fpsSlider = cp5.addSlider("Speed")
    .setPosition(300, 380)
      .setSize(200, 20)
        .setRange(0, 1)
          .setValue(.6)
            ;
            
  myTextarea = cp5.addTextarea("txt")
    .setPosition(580, 380)
      .setSize(210, 80)
        .setFont(createFont("arial", 12))
          .setLineHeight(14)
            .setColor(color(192))            
              .setColorBackground(slideBackground)
                .setColorForeground(color(255, 100));
  ;
  
  updateTextfield(VERSION);             
}

void updateTextfield(String text) {
  String s = myTextarea.getText();
  s += text+"\n";
  myTextarea.setText(s);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(fpsSlider)) {
    fpsSpeed = int(theEvent.getValue());
    return;
  }
  
}
