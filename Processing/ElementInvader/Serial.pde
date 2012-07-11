//Serial
private Lpd6803 lpd6803;
private boolean initialized;
private long lastSendTime;

//flip seconds scanline 
static int[] flipSecondScanline(int[] data) {
  int[] ret = data.clone();
  int ofs;
  int tmp;
  for (int y=1; y<NR_OF_PIXELS_Y; y+=2) {
    ofs = y*NR_OF_PIXELS_X;
    for (int x=0; x<NR_OF_PIXELS_X/2-1; x++) {
      tmp=ret[ofs+x];
      ret[ofs+x] = ret[ofs+NR_OF_PIXELS_X-1-x];
      ret[ofs+NR_OF_PIXELS_X-1-x] = tmp;
    }
  }

  return ret;
}

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
      lpd6803.sendRgbFrame(flipSecondScanline(colorArray), ColorFormat.RGB);
      lastSendTime = System.currentTimeMillis();
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}

