private static int staticId = 0;

public class Element {

  private String name;
  
  private int id;
  
  private int[] selectedElements;
  
  public Element(String name, int[] selectedElements) {
    this.name = name;
    this.id = staticId++;
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

  

