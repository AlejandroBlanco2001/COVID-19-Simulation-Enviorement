private Graph graph;
private Graphics graphics;
int contador = 0;
double inicio; 


void setup(){
   size(1080,720);
   int r = (int) random(0,3);
   graph = new Graph();
   graph.createNode(20);
   graph = crearRanGrafo(graph);
   System.out.println("-----------------------DISPOSICION DE LA SIMULACION--------------------------------");
   for(NodoG g: graph.getNodes()){
     if(g.isInfected){
       System.out.println("INFECTADO|" + g.etiquetas);
     }
     for(Edge e: g.aristas){
       System.out.println("ORIGEN " + e.inicio.etiquetas + "| DESTINO " + e.destino.etiquetas + " CON UN PESO DE " + e.peso);
     }
   }
   System.out.println("---------------------------------------------------------------------------------------");
   graph.setMode(r);
   graph.update();
   inicio = System.currentTimeMillis();
   graphics = new Graphics(graph);
   graphics.drawGraph();
}

void draw(){
  
  if(!graph.isAllInfected()){
      if(System.currentTimeMillis() - inicio > 1000){
      contador += 1;
      avanzaGeneracion();
      graph.update(contador);
      graphics.updateGraph(graph);
      System.out.println("REPORTE DEL MINISTERIO DE SALUD - DIA " + contador);
      System.out.println("SALUDABLES " + graph.getHealthy().size());
      graph.reporteMinisterioDeSalud(contador);
      System.out.println("--------------------------------------------------------------");
      inicio = System.currentTimeMillis();
      }
  }else{
    System.out.println("SE ACABO LA SIMULACION con " + contador + " iteraciones");
    noLoop();
  }
}


public void avanzaGeneracion(){
  for(NodoG n: graph.infected){
    Infectado i = (Infectado) n;
    i.infecta();
  }
}

public Graph crearRanGrafo(Graph grafo){
  NodoG[] nodos = new NodoG[grafo.nodes.size()]; 
  nodos = grafo.convertArray();
  nodos = Shuffle.randomizeArray(nodos,grafo.nodes.size());
  for(int i = 0; i < nodos.length; i++){
    if(i + 1 != nodos.length){
      float peso = random(1,11);
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
       nodos[i].addEdge(new Edge(nodos[i],nodos[randomNumber],random(1,11)));
     }else{
       nodos[randomNumber].addEdge(new Edge(nodos[randomNumber],nodos[i],random(1,11)));
     }
  }
  graph.convertList(Shuffle.getOrdered((nodos)));
  return graph;
}

/*
   DFSImplementation dfs = new DFSImplementation();
   for(NodoG infectados: graph.infected){
     dfs.dfs(graph.nodes.get(0),infectados, new LinkedListC(),new LinkedListC(), graph.nodes.get(0));
   }
   LinkedListC<NodoG> camino = dfs.recorrido.getCaminoContaigoAlto();

*/
