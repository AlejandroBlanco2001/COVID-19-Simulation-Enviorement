class Sano extends NodoG{
  private LinkedListC<NodoG> dangerousPath;
  private NodoG padre;
    
  /**
  * Constructor de la clase, usa el constructor de su padre {@link Node}
  */
  public Sano(NodoG base){
    super(base.etiquetas);
    padre = base;
    this.adjacencyNodes = base.adjacencyNodes;
    this.xCoord = base.getxCoord();
    this.yCoord = base.getyCoord();
    this.radio = base.getRadio();
  }
  
  public void update(){
    this.xCoord = padre.getxCoord();
    this.yCoord = padre.getyCoord();
    this.radio = padre.getRadio();
  }
  /**
  * Subrutina que se encarga de obtener el camino de más riesgo de contagio del Nodo Sano
  */
  public void getMayorRiesgoContagio(DFSImplementation dfs, LinkedListC<NodoG> infected){
    for(NodoG nodo: infected){
      dfs.dfs(this, nodo, new LinkedListC(), new LinkedListC(),this);
    }
    dangerousPath = dfs.getRecorrido().getCaminoContaigoAlto();
  }
  
  @Override
  public String toString(){
    StringBuffer sb = new StringBuffer();
    sb.append("DERECHA INICIO | IZQUIERDA FIN | Recorrido: ").append(stringfy(dangerousPath));
    return sb.toString();
  }
  
  /**
  * Metodo que se encarga de volver una Lista Enlazada simple una cadena de texto
  * @param lista Lista Enlazada Simple que se quiere convertir
  * @return sb Cadena de texto que contiene la etiquetas de los nodos
  */
  public String stringfy(LinkedListC<NodoG> lista){
    StringBuffer sb = new StringBuffer();
    for(NodoG n: lista){
      sb.append(n.etiquetas).append(",");
    }
    return sb.toString();
  }
  
  public void showInfo(){
    fill(255);
    rect(xCoord, yCoord - 30, 200,200); 
  }
  
}
