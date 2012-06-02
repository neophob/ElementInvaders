

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  //parse float messages
  if (theOscMessage.checkTypetag("f")) {
    if (theOscMessage.checkAddrPattern("/speed")) {
      float val = theOscMessage.get(0).floatValue();
      if (val>0.0) {
        fpsSpeed = val;
        fpsSlider.setValue(fpsSpeed);
      }
    }
  }

  //parse int messages
  if (theOscMessage.checkTypetag("i")) {
    
    //change mode
    if (theOscMessage.checkAddrPattern("/mode")) {
      int mode = theOscMessage.get(0).intValue();
      if (mode>=0 && mode<5) {
        selectedMode = mode;
        modeButton.activate(selectedMode);
      }
    }
    if (theOscMessage.checkAddrPattern("/colorset")) {
      int selectedColorSet = theOscMessage.get(0).intValue();
      if (selectedColorSet>=0 && selectedColorSet<colorSet.size()) {
        colSet = selectedColorSet;
        colorButton.activate(colSet);
      }
    }
  }
  
}

