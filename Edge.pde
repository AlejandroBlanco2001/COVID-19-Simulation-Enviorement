class Edge{
    public NodoG inicio;
    public NodoG destino;
    public float peso;
    public boolean is2mAway;
    
    public Edge(NodoG inicio, NodoG destino, float peso){
      this.inicio = inicio;
      this.destino = destino;
      this.peso = peso;
      if(peso > 2){
        is2mAway = true;
      }else{
        is2mAway = false;
      }
    }
}
