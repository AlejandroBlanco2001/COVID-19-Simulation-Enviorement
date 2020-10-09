public class DFSImplementation{
  private Graph graph;
  private LinkedListC<LinkedListC<NodoG>> recorridos;
  
  public DFSImplementation(Graph graph){
    this.graph = graph;
    this.recorridos = new LinkedListC();
  }
    //<>// //<>//
 public boolean visitado(LinkedListC<NodoG> visitados, int etiqueta){
   for(NodoG n: visitados){
     if(n.etiquetas == etiqueta){ //<>//
       return true; //<>//
     } //<>//
   } //<>//
   return false; //<>//
 } //<>//
  //<>//
 public boolean containsInfected(LinkedListC<NodoG> r){ //<>//
   for(NodoG n : r){ //<>//
     if(n.isInfected){ //<>//
       return true; //<>//
     } //<>//
   } //<>//
   return false; //<>//
 } //<>//

 public void dfs(NodoG n,NodoG f, LinkedListC<NodoG> visitados, LinkedListC<NodoG> camino){
   visitados.add(n);
   if(n == f){ //<>//
     for(int i = 0; i < camino.size(); i++){
         System.out.println(camino.get(i).etiquetas);
     }
   }else{
     LinkedListC<NodoG> vecinos = n.adjacencyNodes;
     for(int i = 0; i < vecinos.size(); i++){
       NodoG y = vecinos.get(i); //<>//
       if(!contains(visitados,y.etiquetas) && !(y.isInfected && y != f)){ //<>// //<>//
         visitados.add(y); //<>//
         camino.add(y);
         dfs(y,f,visitados,camino); //<>//
         camino.delete(camino.size()-1); //<>//
       } //<>//
     } //<>//
   } //<>//
   visitados.delete(getIndexRemove(visitados,n));
 } //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
 
 public boolean contains(LinkedListC<NodoG> a, int etiquetas){
   for(NodoG n : a){
     if(n.etiquetas == etiquetas){
       return true;
     }
   } //<>//
   return false; //<>//
 }
 
 public int getIndexRemove(LinkedListC<NodoG> a, NodoG remove){
   int i = 0;
   for(NodoG n : a){
     if(n.etiquetas == remove.etiquetas){
       return i;
     }
     i += 1;
   }
   return 0;
 }
 
 public void showR(){
   for(LinkedListC<NodoG> r : recorridos){
      for(NodoG g : r){
        System.out.print(g.etiquetas+"|");
      }
     System.out.println("");
   }
 }
  
 /*
 public void dfs(NodoG n){
   System.out.println(n.etiquetas + " ");
   LinkedListC<NodoG> vecinos = n.adjacencyNodes; //<>//
   n.isVisited = true; //<>// //<>//
   for(int i = 0; i < vecinos.size(); i++){ //<>//
     NodoG g = vecinos.get(i); //<>// //<>// //<>//
     if(g != null && !g.isVisited){
       dfs(g);
     }
   }
 }
 
  public void dfs(NodoG n, LinkedListC<NodoG> r, NodoG inicio){
   LinkedListC<NodoG> vecinos = n.adjacencyNodes;
   n.isVisited = true;
   if(containsInfected(r,r.get(r.size()-1))){
       r = new LinkedListC();
       r.add(inicio);
   }
   for(int i = 0; i < vecinos.size(); i++){
     NodoG g = vecinos.get(i);
     if(g != null && !g.isVisited){
       r.add(g);
       if(g.isInfected){
         this.recorridos.add(r);
       }else{
         dfs(g,r,inicio);  
       }
     }
   }
 }

 */
}
