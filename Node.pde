class NodoG{
  public int entradas;
  public int limitEntradas;
  public int salidas;
  public int limitSalidas;
  public int etiquetas;
  public ArrayList<Edge> aristas;
  public boolean isInfected;
  
  public NodoG(int etiquetas){
    if((int) random(1,3) == 1){
      isInfected = true;
    }else{
      isInfected = false;
    }
    aristas = new ArrayList();
    salidas = 0;
    entradas = 0;
    this.etiquetas = etiquetas;  
  }
  
  public boolean isBalanced(){
    return entradas == 1 && salidas == 1;
  }
  
  public void addEdge(Edge edge){
    if(edge != null){
      if(checkEdge(edge) != true){
        aristas.add(edge);
      }
    }
  }
  
  public boolean checkEdge(Edge edge){
    for(Edge e : aristas){
      if(e.inicio == edge.inicio && e.destino == edge.destino){
        return true;
      }
    }
    return false;
  }
}
