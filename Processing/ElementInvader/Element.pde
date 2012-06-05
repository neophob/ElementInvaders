private static int staticElementId = 0;

public class Element {

  private String name;
  
  private int id;
  
  private int[] selectedElements;
  
  public Element(String name, int[] selectedElements) {
    this.name = name;
    this.id = staticElementId++;
    this.selectedElements = selectedElements.clone();
  }  

  public String getName() {
    return name;
  }

  public int getId() {
    return id;
  }

  public int[] getSelectedElements() {
    return selectedElements.clone();
  }
}

public void initElements() {
  elements = new ArrayList<Element>();
 
  elements.add(new Element("Noble gases", new int[] {38,58,78,98,118,138,158}));
  elements.add(new Element("Halogens", new int[] {57,77,97,117,137,157}));
  elements.add(new Element("Non Metals", new int[] {21,54,55,56,75,76,96}));
  elements.add(new Element("Metalloids", new int[] {53,74,94,95,115,116,136}));
  elements.add(new Element("Other Metals", new int[] {73,93,113,114,133,134,135,153,154,155,156}));
  elements.add(new Element("Transition Metals", new int[] {
    83,84,85,86,87,88,89,90,91,92,
    103,104,105,106,107,108,109,110,111,112,
    124,125,126,127,128,129,130,131,132,
    144,145,146,147,148,149,150,151,152
  }));  
  elements.add(new Element("Rare Earth Elements", new int[] {123,143}));  
  elements.add(new Element("Alkaline Metals", new int[] {42,62,82,102,122,142}));  
  elements.add(new Element("Alkali Metals", new int[] {41,61,81,101,121,141}));  
}
  
  
