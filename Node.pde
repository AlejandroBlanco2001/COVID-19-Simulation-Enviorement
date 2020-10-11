class NodoG{
  public int etiquetas;
  protected LinkedListC<Edge> aristas;
  protected LinkedListC<NodoG> adjacencyNodes;
  private int contagiadoEn;
  private boolean isVisited;
  private boolean hasMascarilla;
  private boolean isInfected;
  private float xCoord;
  private float yCoord;
  
  public NodoG(int etiquetas){
    if((int) random(1,3) == 1){
      hasMascarilla = true;
    }else{
      hasMascarilla = false;
    }
    isInfected = false;
    contagiadoEn = -1;
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
   
   public boolean checkDistance(NodoG fin){
     for(Edge e: this.aristas){
       if(e.destino.etiquetas == fin.etiquetas){
         return e.is2mAway;
       }
     }
     return false;
   }
   
   public float getCost(Edge edge){
     for(Edge e : this.aristas){
      if(e.destino.etiquetas == edge.destino.etiquetas){
        return e.peso;
      }
     }
     return 0f;
   }
   
   public void drawNode(float x, float y){
     xCoord = x;
     yCoord = y;
   }
   
   public String toString(){
     StringBuffer sb = new StringBuffer();
     sb.append("Nodo: ").append(this.etiquetas).append("|").append("Contagiado: ").append(this.isInfected).append("|").append("Desde: ").append(this.contagiadoEn).append("|").append("Mascarilla: ").append(this.hasMascarilla).append("\n");
     return sb.toString();
   }
   
   public void setcontagiadoEn(int value){
     contagiadoEn = value;
   }
   
   public void setHasMascarilla(boolean value){
     hasMascarilla = value;
   }
   
    public int getEtiquetas() {
        return etiquetas;
    }

    public LinkedListC<Edge> getAristas() {
        return aristas;
    }

    public LinkedListC<NodoG> getAdjacencyNodes() {
        return adjacencyNodes;
    }

    public int getContagiadoEn() {
        return contagiadoEn;
    }

    public boolean isIsVisited() {
        return isVisited;
    }

    public boolean isHasMascarilla() {
        return hasMascarilla;
    }

    public boolean isIsInfected() {
        return isInfected;
    }

    public float getxCoord() {
        return xCoord;
    }

    public float getyCoord() {
        return yCoord;
    }
  
}
