class Edge {
  public NodoG inicio;
  public NodoG destino;
  public float peso;
  /**
   * Variable que se encarga de verificar la distancia entre los nodos
   */
  public boolean is2mAway;

  /** 
   * Constructor de la Clase
   * @param inicio Nodo de inicio
   * @param destino Nodo de destino
   * @param peso Distancia entre los nodos
   */
  public Edge(NodoG inicio, NodoG destino, float peso) {
    this.inicio = inicio;
    this.destino = destino;
    this.peso = peso;
    if (peso > 2) {
      is2mAway = true;
    } else {
      is2mAway = false;
    }
  }
}
