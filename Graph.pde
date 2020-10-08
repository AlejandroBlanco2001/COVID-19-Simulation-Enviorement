class Graph{
  private LinkedListC<NodoG> nodes;
  public Graph(){
    nodes = new LinkedListC();
  }
  
  public NodoG getRandomNode(){
    NodoG node = nodes.get((int) random(0,nodes.size()));
    return node;
  }
  
  public void createNode(int number){
    NodoG node;
    for(int i = 0; i < number; i++){
      node = new NodoG(i);
      nodes.add(node);
    }
  }
  
  public LinkedListC<NodoG> getNodes(){
    return nodes;
  } 
  

}
