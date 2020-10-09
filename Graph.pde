class Graph{
  private LinkedListC<NodoG> nodes;
  private LinkedListC<NodoG> infected;
  
  public Graph(){
    nodes = new LinkedListC();
    infected = new LinkedListC();
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
  
  public NodoG[] convertArray(){
    NodoG[] nodos = new NodoG[nodes.size()];
    int i = 0;
    for(NodoG n : this.nodes){
      nodos[i] = n;
      i += 1;
    }
    return nodos;
  }
  
  public void convertList(NodoG[] array){
    this.nodes.clear();
    for(int i = 0; i < array.length; i++){
      this.nodes.add(array[i]);
    }
  }
  
  public void update(){
    for(NodoG g: nodes){
      if(g.isInfected == true){
        infected.add(g);
      }
    }
  }
  
  public LinkedListC<NodoG> getNodes(){
    return nodes;
  } 
}
