ArrayList<NodoG> grafo;


void setup(){
   grafo = new ArrayList();
   NodoG n1 = new NodoG(1);
   NodoG n2 = new NodoG(2);
   NodoG n3 = new NodoG(3);
   NodoG n4 = new NodoG(5);
   NodoG n5 = new NodoG(4);
   NodoG n6 = new NodoG(6);
   grafo.add(n1);
   grafo.add(n2);
   grafo.add(n3);
   grafo.add(n4);
   grafo.add(n5);
   grafo.add(n6);
   grafo = crearGrafo(grafo);
   for(NodoG g: grafo){
     for(Edge e: g.aristas){
       System.out.println("ORIGEN " + e.inicio.etiquetas + "| DESTINO " + e.destino.etiquetas);
     }
   }
}

public ArrayList<NodoG> crearGrafo(ArrayList<NodoG> grafo){ //<>//
  int conexionR;
  NodoG randomN;
  if(isConexo(grafo) == true){ //<>//
    return grafo;
  }else{
     conexionR = (int) random(0,3);
     randomN = grafo.get((int) random(0,grafo.size()));
     NodoG g = grafo.get((int) random(0,grafo.size()));
     while(g.etiquetas == randomN.etiquetas){
       g = grafo.get((int) random(0,grafo.size()));
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

public boolean isConexo(ArrayList<NodoG> grafo){
  for(NodoG g: grafo){
    if(g.isBalanced() == false){ //<>//
      return false;
    }
  }
  return true;
}
