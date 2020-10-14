private Graph graph;
int contador = 0;
double inicio; 

void setup(){
   graph = new Graph();
   size(1080,720);
   int r = (int) random(0,3);
   graph.createNode(5);
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
}

void draw(){
  if(!graph.isAllInfected()){
    if(System.currentTimeMillis() - inicio > 1000){
      saveFrame("/data/temp/Day"+contador+".png");
      contador += 1;
      avanzaGeneracion();
      graph.update(contador);
      System.out.println("REPORTE DEL MINISTERIO DE SALUD - DIA " + contador);
      System.out.println("SALUDABLES " + graph.getHealthy().size());
      graph.reporteMinisterioDeSalud(contador);
      System.out.println("--------------------------------------------------------------");
      inicio = System.currentTimeMillis();
    }
  }else{
    HTMLBuilder htmlB = new HTMLBuilder();
    htmlB.createTableHtml(graph.tablas);
    htmlB.seperateTagsTable();
    System.out.println("SE ACABO LA SIMULACION con " + contador + " iteraciones, todos se murieron");
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
