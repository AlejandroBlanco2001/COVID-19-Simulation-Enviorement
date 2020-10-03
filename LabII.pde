Graph graph;


void setup(){
   graph = new Graph();
   graph.createNode(5);
   graph = crearGrafo(graph);
   for(NodoG g: graph.getNodes()){
     for(Edge e: g.aristas){
       System.out.println("ORIGEN " + e.inicio.etiquetas + "| DESTINO " + e.destino.etiquetas);
     }
   }
}

public Graph crearGrafo(Graph grafo){ //<>//
  int conexionR;
  NodoG randomN;
  if(isConexo(grafo) == true){ //<>//
    return grafo;
  }else{
     conexionR = (int) random(0,3);
     randomN = graph.getRandomNode();
     NodoG g = graph.getRandomNode();
     while(g.etiquetas == randomN.etiquetas){
       g = graph.getRandomNode();
     }  
     if(conexionR == 0){
         g.salidas = 1;
         randomN.entradas = 1;
         g.addEdge(new Edge(g,randomN));
   }else if(conexionR == 1){
         g.entradas = 1;
         randomN.salidas = 1;
         randomN.addEdge(new Edge(randomN,g));  
     }else{
         g.entradas = 1;
         g.salidas = 1;
         randomN.entradas = 1;
         randomN.salidas = 1;
         randomN.addEdge(new Edge(randomN,g));  
         g.addEdge(new Edge(g,randomN));
     }
    return crearGrafo(grafo);
  }
}

/*
public ArrayList<NodoG> crearGrafo(ArrayList<NodoG> grafo){
  int conexionR;
  NodoG randomN;
  if(isConexo(grafo) == true){
    return grafo;
  }else{
    conexionR = (int) random(0,1);
    randomN = grafo.get((int) random(0,grafo.size()));
    for(NodoG g: grafo){
      if(conexionR == 0){
        if(g.etiquetas != randomN.etiquetas){
          if(g.salidas > -1){
            g.salidas = 1;
            randomN.entradas = 1;
            g.addEdge(new Edge(g,randomN));
          }
        }else{
          if(randomN.salidas > -1){
            g.entradas = 1;
            randomN.salidas = 1;
            randomN.addEdge(new Edge(randomN,g));  
          }
        }
      }
    }
    return crearGrafo(grafo);
  }
}
*/

public boolean isConexo(Graph grafo){
  for(NodoG g: grafo.getNodes()){
    if(g.isBalanced() == false){ //<>//
      return false;
    }
  }
  return true;
}
