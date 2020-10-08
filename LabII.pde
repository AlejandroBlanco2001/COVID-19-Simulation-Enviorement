Graph graph;


void setup(){
   graph = new Graph();
   graph.createNode(15);
   graph = crearGrafo(graph);
   for(NodoG g: graph.getNodes()){
     for(Edge e: g.aristas){
       System.out.println("ORIGEN " + e.inicio.etiquetas + "| DESTINO " + e.destino.etiquetas + " CON UN PESO DE " + e.peso);
     }
   }
   APathfinding pathF = new APathfinding();
   pathF.find(graph.nodes.get(0),graph.nodes.get(1));
}

public Graph crearGrafo(Graph grafo){ //<>//
  NodoG randomN;
  int conex = (int) random(0,2);
  while(isConexo(grafo) != true){
     randomN = grafo.getRandomNode();
     NodoG g = grafo.getRandomNode();
     while(g.etiquetas == randomN.etiquetas){
       g = grafo.getRandomNode();
     }  
     float weight = random(0,101);
     Edge e;
     if(conex == 0){
       e = new Edge(g,randomN,weight);
       if(g.addEdge(e) == true){
         randomN.salidas += 1;
         g.entradas += 1;
       }
     }else{
       e = new Edge(randomN, g,weight);
       if(randomN.addEdge(e) == true){
         randomN.entradas += 1;
         g.salidas += 1;
       }
     }  //<>//
  } 
  return grafo;
}

public boolean isConexo(Graph grafo){
  for(NodoG g: grafo.getNodes()){
    if(g.isBalanced() == false){
      return false;
    }
  }
  return true;
}
