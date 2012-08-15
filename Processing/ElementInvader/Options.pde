private static final String COLOR_SET_NAME = "palette.properties";

String colorLoadMsg = "";

//load all color set from a file
public List<ColorSet> loadColorsets() {
  List<ColorSet> colorSet = new ArrayList<ColorSet>();

  Properties palette = new Properties();
  try {
    palette.load(createInput(COLOR_SET_NAME));

    for(String key : palette.stringPropertyNames()) {
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

