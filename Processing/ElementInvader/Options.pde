private static final String COLOR_SET_NAME = "palette.properties";
private static final String OPTION_FILENAME = "options.properties";

String colorLoadMsg = "";

//load all color set from a file
public List<ColorSet> loadColorsets() {
  List<ColorSet> colorSet = new ArrayList<ColorSet>();

  Properties palette = new Properties();
  try {
    palette.load(createInput(COLOR_SET_NAME));

    for (String key : palette.stringPropertyNames()) {
      try {
        String setColors = palette.getProperty(key);
        String[] colorsAsString = setColors.split(",");

        //convert hex string into int
        int[] colorsAsInt = new int[colorsAsString.length];
        int ofs=0;
        for (String s: colorsAsString) {
          colorsAsInt[ofs++] = Integer.decode(s.trim());
        }
        ColorSet cs = new ColorSet(key, colorsAsInt);
        colorSet.add(cs);
      } 
      catch (Exception e) {
        colorLoadMsg = "Failed to load Palette entry!"+e;
      }
    }

    colorLoadMsg = "ColorSets loaded, "+colorSet.size()+" entries";
  } 
  catch (Exception e) {
    colorLoadMsg = "Failed to load Config, "+e;
    throw new IllegalArgumentException("Configuration error!", e);
  }

  return colorSet;
}


public String getDefaultColorSetName() {
  Properties options = new Properties();
  try {
    options.load(createInput(OPTION_FILENAME));
    return options.getProperty("default.colorset");
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
  return "";
}


public int getDefaultGeneratorNr() {
  Properties options = new Properties();
  try {
    options.load(createInput(OPTION_FILENAME));
    String s = options.getProperty("default.mode.nr");
    return Integer.parseInt(s);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
  return 1;
}


public float getDefaultSpeed() {
  Properties options = new Properties();
  try {
    options.load(createInput(OPTION_FILENAME));
    String s = options.getProperty("default.speed");
    return Float.parseFloat(s);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
  return 0.5f;
}
