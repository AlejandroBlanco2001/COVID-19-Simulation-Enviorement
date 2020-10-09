class NodoG{
  public int etiquetas;
  public LinkedListC<Edge> aristas;
  public LinkedListC<NodoG> adjacencyNodes;
  public boolean isVisited;
  public boolean isInfected;
  private float xCoord;
  private float yCoord;
  
  public NodoG(int etiquetas){
    if((int) random(1,3) == 1){
      isInfected = true;
    }else{
      isInfected = false;
    }
    xCoord = 0;
    yCoord = 0;
    aristas = new LinkedListC();
    adjacencyNodes = new LinkedListC();
    this.etiquetas = etiquetas;  
  }
  
  public boolean addEdge(Edge edge){
    if(edge != null){
      if(checkEdge(edge) != true){
        if(edge.destino != this){
          adjacencyNodes.add(edge.destino);
        }
        Edge inverse = new Edge(edge.destino,edge.inicio,0);
        if(edge.destino.checkEdge(inverse) == true){
          float peso = edge.destino.getCost(inverse);
          Edge e = new Edge(edge.inicio,edge.destino,peso);
          aristas.add(e);
        }else{
          aristas.add(edge);
        }
        return true;
      }
      return false;
    }
    return false;
  }
  
  public boolean checkEdge(Edge edge){
    for(Edge e : this.aristas){
      if(e.inicio.etiquetas == edge.inicio.etiquetas && e.destino.etiquetas == edge.destino.etiquetas){
        return true;
      }
    }
    return false;
   }
   
   public float getCost(Edge edge){
     for(Edge e : this.aristas){
      if(e.inicio.etiquetas == edge.inicio.etiquetas && e.destino.etiquetas == edge.destino.etiquetas){
        return e.peso;
      }
     }
     return 0f;
   }
   
   public void drawNode(float x, float y){
     xCoord = x;
     yCoord = y;
   }
}
