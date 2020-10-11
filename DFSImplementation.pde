public class DFSImplementation{
  private Recorrido recorrido;
  
  public DFSImplementation(){
    this.recorrido = new Recorrido();
  }
  
 // DFS para busqueda de un camino entre dos puntos 
 public void dfs(NodoG n,NodoG f, LinkedListC<NodoG> visitados, LinkedListC<NodoG> camino, NodoG inicio){
   visitados.add(n);
   if(n == f){
     StackC stack = new StackC();
     stack.pushS(inicio);
     for(int i = 0; i < camino.size(); i++){
         stack.pushS(camino.get(i));
         if(camino.get(i).isInfected){
           recorrido.addP(stack);
           stack = new StackC();
           stack.pushS(inicio);
         }
     }
   }else{
     LinkedListC<NodoG> vecinos = n.adjacencyNodes;
     for(int i = 0; i < vecinos.size(); i++){
       NodoG y = vecinos.get(i);
       if(!contains(visitados,y.etiquetas) && !(y.isInfected && y != f)){ 
         visitados.add(y);
         camino.add(y);
         dfs(y,f,visitados,camino,inicio);
         camino.delete(camino.size()-1);
       }
     }
   }
   visitados.delete(getIndexRemove(visitados,n));
 }
 
 public boolean contains(LinkedListC<NodoG> a, int etiquetas){
   for(NodoG n : a){
     if(n.etiquetas == etiquetas){
       return true;
     }
   }
   return false;
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

 public void showRecorridos(){
   for(StackC pila : recorrido.recorridos){
     System.out.println("Camino" + " \n" + "-------------------------------------------" + "\n");
     while(!pila.isEmpty()){
       System.out.print(pila.popS().etiquetas+",");
     }
     System.out.println("\n" + "-------------------------------------------");
   }
 }
  
 /*
 public void dfs(NodoG n){
   System.out.println(n.etiquetas + " ");
   LinkedListC<NodoG> vecinos = n.adjacencyNodes; //<>// //<>// //<>//
   n.isVisited = true;  //<>// //<>// //<>//
   for(int i = 0; i < vecinos.size(); i++){ //<>// //<>// //<>//
     NodoG g = vecinos.get(i); //<>// //<>// //<>//
     if(g != null && !g.isVisited){
       dfs(g);
     }
   }
 }
 */
}
