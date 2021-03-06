//gui
private ControlP5 cp5;
private Slider fpsSlider;
private Textarea myTextarea;
private RadioButton modeButton;
private RadioButton colorButton;

int slideBackground = color(48, 48, 48);

void initGui(String defaultColorSetName, int defaultGeneratorNr, float defaultSpeed) {
  cp5 = new ControlP5(this);

  // add a vertical slider
  fpsSlider = cp5.addSlider("Speed")
    .setPosition(300, 420+25)
      .setSize(200, 20)
        .setRange(0, 1)
          .setValue(defaultSpeed);

  myTextarea = cp5.addTextarea("txt")
    .setPosition(580, 480+25)
      .setSize(210, 80)
        .setFont(createFont("arial", 12))
          .setLineHeight(14)
            .setColor(color(192))            
              .setColorBackground(slideBackground)
                .setColorForeground(color(255, 100));

  modeButton = cp5.addRadioButton("colorModeButton")
    .setPosition(20, 380+25)
      .setSize(20, 20)
        .setColorForeground(color(120))
          .setColorActive(color(255))
            .setColorLabel(color(255))
              .setItemsPerRow(7)
                .setSpacingColumn(80)
                  .setNoneSelectedAllowed(false)
                    .addItem("Single Elements", MODE_SINGLE_ELEMENT)
                      .addItem("All Elements", MODE_ALL_ELEMENTS)
                        .addItem("Pulse Elements", MODE_PULSE_ELEMENTS)                    
                          .addItem("Rainbow ", MODE_RAINBOW)
                            .addItem("Fire ", MODE_FIRE)                        
                              .addItem("Solid", MODE_SOLID)                        
                                .activate(defaultGeneratorNr);

  //radiobuttons with color
  colorButton = cp5.addRadioButton("colorButton")
    .setPosition(20, 306)
      .setSize(20, 20)
        .setColorForeground(color(120))
          .setColorActive(color(255))
            .setColorLabel(color(255))
              .setItemsPerRow(11)
                .setSpacingColumn(50)
                  .setNoneSelectedAllowed(false);

  int i=0;
  for (ColorSet cs: colorSet) {
    colorButton.addItem(cs.getName(), i);
    if (cs.getName().equalsIgnoreCase(defaultColorSetName)) {
      colorButton.activate(i);
    }
    i++;
  }
  //  colorButton.activate(5);

  updateTextfield(VERSION);
}

void updateTextfield(String text) {
  String s = myTextarea.getText();
  s += text+"\n";
  myTextarea.setText(s);
}

void controlEvent(ControlEvent theEvent) {
  println("### Eventname: "+theEvent.getName()+", value: "+theEvent.getValue());

  if (theEvent.isFrom(fpsSlider)) {
    fpsSpeed = theEvent.getValue();
    if (fpsSpeed==0.0f) {
      fpsSpeed = 0.001f;
    }
    println("Event for fpsSpeed: fpsSpeed="+fpsSpeed);
    return;
  }

  if (theEvent.isFrom(modeButton)) {
    selectedMode = int(theEvent.getValue());
    println("Event for modeButton: selectedMode="+selectedMode);
    return;
  }

  if (theEvent.isFrom(colorButton)) {
    colSet = int(theEvent.getValue());
    return;
  }
}

