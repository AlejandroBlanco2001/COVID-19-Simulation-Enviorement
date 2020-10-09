private Graph graph;

void setup(){
   graph = new Graph();
   graph.createNode(6);
   graph = crearRanGrafo(graph);
   for(NodoG g: graph.getNodes()){
     if(g.isInfected){
       System.out.println("INFECTADO|" + g.etiquetas);
     }
     for(Edge e: g.aristas){
       System.out.println("ORIGEN " + e.inicio.etiquetas + "| DESTINO " + e.destino.etiquetas + " CON UN PESO DE " + e.peso);
     }
   }
   graph.update();
   DFSImplementation dfs = new DFSImplementation(graph);
   for(NodoG infectados: graph.infected){
     dfs.dfs(graph.nodes.get(0),infectados, new LinkedListC(),new LinkedListC());
   }
}

public Graph crearRanGrafo(Graph grafo){
  NodoG[] nodos = new NodoG[grafo.nodes.size()]; 
  nodos = grafo.convertArray();
  nodos = Shuffle.randomizeArray(nodos,grafo.nodes.size());
  for(int i = 0; i < nodos.length; i++){
    if(i + 1 != nodos.length){
      float peso = random(1,16);
      NodoG next = nodos[i+1];
      nodos[i].addEdge(new Edge(nodos[i],next,peso));
      nodos[i+1].addEdge(new Edge(next,nodos[i],peso));
    }
    int randomNumber = (int) random(0,nodos.length);
     int randomConexion = (int) random(0,2);
     while(randomNumber == i){
       randomNumber = (int) random(0,nodos.length);
     }
     if(randomConexion == 0){
       nodos[i].addEdge(new Edge(nodos[i],nodos[randomNumber],random(1,101)));
     }else{
       nodos[randomNumber].addEdge(new Edge(nodos[randomNumber],nodos[i],random(1,101)));
     }
  }
  graph.convertList(nodos);
  return graph;
}
