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
 
  elements.add(new Element("Noble gases", new int[] {18,38,58,78,98,118,138}));
  elements.add(new Element("Halogens", new int[] {37,57,77,97,117,137}));
  elements.add(new Element("Non Metals", new int[] {1,34,35,36,55,56,76}));
  elements.add(new Element("Metalloids", new int[] {33,54,74,75,95,96,116}));
  elements.add(new Element("Other Metals", new int[] {53,73,93,94,113,114,115,133,134,135,136}));
  elements.add(new Element("Transition Metals", new int[] {
    63,64,65,66,67,68,69,70,71,72,
    83,84,85,86,87,88,89,90,91,92,
    104,105,106,107,108,109,110,111,112,
    124,125,126,127,128,129,130,131,132
  }));  
  elements.add(new Element("Rare Earth Elements", new int[] {103,123}));  
  elements.add(new Element("Alkaline Metals", new int[] {22,42,62,82,102,122}));  
  elements.add(new Element("Alkali Metals", new int[] {21,41,61,81,101,121}));  
}
  
  
