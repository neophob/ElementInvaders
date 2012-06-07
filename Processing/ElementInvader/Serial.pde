//Serial
private Lpd6803 lpd6803;
private boolean initialized;
private long lastSendTime;


void initSerial() {
  updateTextfield("Init serial port");
  try {
    lpd6803 = new Lpd6803(this, NR_OF_PIXELS_X*NR_OF_PIXELS_Y);          
    this.initialized = lpd6803.ping();
    println("Ping result: "+ this.initialized);
    updateTextfield(" -> Ping result: "+ this.initialized);
  } 
  catch (NoSerialPortFoundException e) {
    updateTextfield(" -> Failed to initialize serial port!");
    println("failed to initialize serial port!");
  }
}

void sendSerial() {
  //send serial data if initialized and wait at least 45ms before sending again
  if (initialized && System.currentTimeMillis()-lastSendTime > 19) {    
    println(lastSendTime+" send: "+colorArray.length);
    try {
      lpd6803.sendRgbFrame(colorArray, ColorFormat.RGB);
      lastSendTime = System.currentTimeMillis();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }  
}

