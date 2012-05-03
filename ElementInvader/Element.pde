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
  elements.add(new Element("Noble gases", new int[] {20,40,60,80,100}));
  elements.add(new Element("Halogens", new int[] {42,43,44,45,46,47,48}));
  elements.add(new Element("Metalloids", new int[] {1,2,55,44}));
  elements.add(new Element("Actinides", new int[] {23,34,45,56,67,78}));  
}
  

