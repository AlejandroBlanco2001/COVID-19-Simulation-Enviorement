class Sano extends NodoG{
  private LinkedListC<NodoG> dangerousPath;
  
  public Sano(NodoG base){
    super(base.etiquetas);
    this.adjacencyNodes = base.adjacencyNodes;
  }
  
  public void getMayorRiesgoContagio(DFSImplementation dfs, LinkedListC<NodoG> infected){
    for(NodoG nodo: infected){
      dfs.dfs(this, nodo, new LinkedListC(), new LinkedListC(),this);
    }
    dangerousPath = dfs.getRecorrido().getCaminoContaigoAlto();
  }
  
  public String toString(){
    StringBuffer sb = new StringBuffer();
    sb.append("DERECHA INICIO | IZQUIERDA FIN | Recorrido: ").append(stringfy(dangerousPath));
    return sb.toString();
  }
  
  public String stringfy(LinkedListC<NodoG> lista){
    StringBuffer sb = new StringBuffer();
    for(NodoG n: lista){
      sb.append(n.etiquetas).append(",");
    }
    return sb.toString();
  }
}
