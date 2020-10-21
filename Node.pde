class NodoG{
  public int etiquetas;
  protected LinkedListC<Edge> aristas;
  protected LinkedListC<NodoG> adjacencyNodes;
  protected int contagiadoEn;
  protected boolean hasMascarilla;
  protected boolean isInfected;
  protected int xCoord;
  protected int yCoord;
  protected int radio;
  
  /**
  * Constructor de la clase
  * @param etiquetas Etiqueta o nombre que recibira el nodo
  */
  public NodoG(int etiquetas){
    isInfected = false;
    contagiadoEn = -1;
    xCoord = 0;
    yCoord = 0;
    aristas = new LinkedListC();
    adjacencyNodes = new LinkedListC();
    this.etiquetas = etiquetas;  
  }
  
  /**
  * Metodo que se encarga de crear y añadir las aristas a cada nodo
  * @param edge Arista a añadir
  * @return {@code true} si logro crear la arista, de lo contrario, {@code false}
  */
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
  
  /**
  * Metodo que se encarga de verificar si el nodo ya tiene uan arista
  * @param edge Arista a verificar
  * @return {@code true} si dicho nodo contiene esa arista, de lo contrario, {@code false}
  */
  public boolean checkEdge(Edge edge){
    for(Edge e : this.aristas){
      if(e.inicio.etiquetas == edge.inicio.etiquetas && e.destino.etiquetas == edge.destino.etiquetas){
        return true;
      }
    }
    return false;
   }
   
   /** 
   * Metodo que se encarga de verificar si dos nodos se encuentran a más de 2m de distancia
   * @param fin Nodo de destino
   * @return {@code true} si el Nodo esta a más de 2m de distancia, de lo contrario, {@code false}
   */
   public boolean checkDistance(NodoG fin){
     for(Edge e: this.aristas){
       if(e.destino.etiquetas == fin.etiquetas){
         return e.is2mAway;
       }
     }
     return false;
   }
   
   /**
   * Metodo que se encarga de obtener la distancia entre dos nodos
   * @param edge Arista a la cual ver su distancia
   * @return peso La distancia entre los nodos
   */
   public float getCost(Edge edge){
     for(Edge e : this.aristas){
      if(e.destino.etiquetas == edge.destino.etiquetas){
        return e.peso;
      }
     }
     return 0f;
   }
   
   /**
   * Subrutina que se encarga de obtener los datos donde se dibujo el Nodo
   * @param x Coordenada X del Canvas del Nodo
   * @param y Coordenada Y del Canvas del Nodo
   * @param radio Radio del Nodo
   */
   public void setNodeCoords(int x, int y, int radio){
     xCoord = x;
     yCoord = y;
     this.radio = radio;
   }
   
   @Override
   public String toString(){
     StringBuffer sb = new StringBuffer();
     sb.append("Nodo: ").append(this.etiquetas).append("|").append("Contagiado: ").append(this.isInfected).append("|").append("Desde: ").append(this.contagiadoEn).append("|").append("Mascarilla: ").append(this.hasMascarilla).append("\n");
     return sb.toString();
   }
   
   /**
   * Subrutina que se encarga de colocar el dia de infeccion del Nodo
   * @param value Dia de contagio
   */
   public void setcontagiadoEn(int value){
     contagiadoEn = value;
   }
   
   /**
   * Subrutina que se encargas de colocar si el nodo lleva o no mascarilla
   * @param value Decidir si lleva o no mascarilla
   */
   public void setHasMascarilla(boolean value){
     hasMascarilla = value;
   }
   
   /**
   * Subrutina que se encargas de colocar si el nodo es infectado o no
   * @param value Decidir si fue infectado o no
   */
   public void setInfected(boolean value){
     isInfected = value;
   }
   
   /**
   * Metodo que se encarga de obtener la etiqueta del Nodo
   * @return etiquetas Etiqueta del nodo
   */
   public int getEtiquetas() {
     return etiquetas;
   }

    /**
    * Metodo que se encarga de devolver la Lista Enlazada Simple que contiene las aristas
    * @return aristas Aristas del Nodo
    */
    public LinkedListC<Edge> getAristas() {
      return aristas;
    }

    /*
    * Metodo que se encarga de devolver la Lista Enlazada Simple que contiene los nodos adyacentes a el
    * @return adjacencyNodes Nodos adyacentes al Nodo
    */
    public LinkedListC<NodoG> getAdjacencyNodes() {
        return adjacencyNodes;
    }

    /**
    * Metodo que se encarga de devolver el dia en el que fue contagiado el Nodo
    * @return contagiadoEn Dia en el cual fue contagiado el Nodo
    */
    public int getContagiadoEn() {
        return contagiadoEn;
    }

    /*
    * Metodo que devuelve si un Nodo tiene o no mascarilla 
    * @return hasMascarilla {@code true} si el nodo tiene, de lo contrario, {@code false}
    */
    public boolean isHasMascarilla() {
        return hasMascarilla;
    }

    /**
    * Metodo que se encarga de devolver si un nodo esta infectado
    * @param isInfected {@code true} si el nodo esta infectado, de lo contrario, {@code false}
    */
    public boolean isIsInfected() {
        return isInfected;
    }
    
    /**
    * Metodo que se encarga de devolver la coordenada X del Nodo
    * @return xCoord Coordenada X del Nodo
    */
    public int getxCoord() {
        return xCoord;
    }

    /**
    * Metodo que se encarga de devolver la coordenada Y del Nodo
    * @return yCoord Coordenada Y del Nodo
    */
    public int getyCoord() {
        return yCoord;
    }
    
    /**
    * Metodo que se encarga de devolver el radio de la esfera contenedora del Nodo
    * @return radio Radio de la esfera de la esfera contenedora del Nodo
    */
    public int getRadio() { 
      return radio;
    }
    
   /**
   * Subrutina que se encargas de asignar la coordenada en X del Nodo
   * @param value Coordenada en X a asignar
   */
   public void setXCoord(int value){
     this.xCoord = value;
   }
    
   /**
   * Subrutina que se encargas de asignar la coordenada en Y del Nodo
   * @param value Coordenada en Y a asignar
   */
   public void setYCoord(int value){
     this.yCoord = value;
   }
    
   /**
   * Subrutina que se encargas de asignar el radio de esfera contenedora del Nodo
   * @param value Valor del radio
   */ 
   public void setRadio(int value){
     this.radio = value;
   }
  
}
