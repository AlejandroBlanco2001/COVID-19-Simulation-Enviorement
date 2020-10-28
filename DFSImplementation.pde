public class DFSImplementation { //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
  private Recorrido recorrido;

  /*
  * Constructor de la clase
  */
  public DFSImplementation() {
    this.recorrido = new Recorrido();
  }

  /**
   * Subrutina que se encarga de la busqueda de todos los posibles caminos de un nodo no infectado a un infectado
   * @param n Nodo no infectado
   * @param f Nodo infectado
   * @param visitados Lista enlazada simple que contiene los nodos visitados previamente
   * @param camino Lista enlazada simple que se encarga de guardar el camino que ha ido recorriendo 
   * @param inicio Nodo no infectado
   */
   public void dfsConGepardex(NodoG n, NodoG f, LinkedListC<NodoG> visitados, LinkedListC<NodoG> camino, NodoG inicio){
    visitados.add(n);
    if(n != inicio){
      visitados.delete(getIndexRemove(visitados,n));
    }
    if (n.etiquetas == f.etiquetas) {
      StackC stack = new StackC(); 
      stack.pushS(inicio);
      for (int i = 0; i < camino.size(); i++) {
        println(camino.get(i).etiquetas); //<>//
        stack.pushS(camino.get(i)); //<>//
      }
      recorrido.addP(stack); //<>//
    } else { //<>//
      for (int i = 0; i < n.adjacencyNodes.size(); i++) { //<>//
        NodoG y = n.adjacencyNodes.get(i); //<>//
        if (!contains(visitados, y.etiquetas) && !y.isInfected) {
          visitados.add(y);
          camino.add(y); //<>//
          dfsConGepardex(y, f, visitados, camino, inicio); //<>//
          camino.delete(camino.size()-1); //<>//
        }
      }
    }
    visitados.delete(getIndexRemove(visitados, n));
  }

  /**
   * Metodo que se encarga de verificar si dentro de la Lista Enlaza simple se encuentra un nodo
   * @param lista Lista enlaza simple a inspeccionar
   * @param etiquetas Etiqueta del nodo a inspeccionar
   * @return {@code true} si el nodo se encuentra en la lista, de lo contrario, devuelve {@code false}
   */
  public boolean contains(LinkedListC<NodoG> a, int etiquetas) {
    for (NodoG n : a) {
      if (n.etiquetas == etiquetas) {
        return true;
      }
    }
    return false;
  }

  /**
   * Metodo que se encarga de obtener la posicion del elemento a eliminar de la Lista Enlazada simple
   * @param lista Lista enlazada simple a inspeccionar
   * @param remove Nodo a eliminar
   * @return -1 si el Nodo no se encuentra en la lista, de lo contrario retorna su posicion
   */
  public int getIndexRemove(LinkedListC<NodoG> a, NodoG remove) {
    int i = 0;
    for (NodoG n : a) {
      if (n.etiquetas == remove.etiquetas) {
        return i;
      }
      i += 1;
    }
    return 0;
  }

  /**
   * Metodo que se encarga de devolver el objeto {@link Recorrido}
   * @return El objeto recorrido
   */
  public Recorrido getRecorrido() {
    return recorrido;
  }
}
