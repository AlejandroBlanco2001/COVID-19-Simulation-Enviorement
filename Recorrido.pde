public class Recorrido { //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
  private LinkedListC<StackC> recorridos;

  /**
   * Constructor de la clase
   */
  public Recorrido() {
    recorridos = new LinkedListC();
  }

  public void addP(StackC pilaRecorrido) {
    recorridos.add(pilaRecorrido);
  }

  /**
   * Subrutina que se encarga de agregar los recorridos en forma de {@link StackC}
   */
  public LinkedListC<NodoG> getCaminoContaigoAlto() {
    float min = 0;
    float prob;
    LinkedListC<NodoG> camino = new LinkedListC();
    LinkedListC<NodoG> tempo = new LinkedListC();
    for (StackC r : recorridos) {
      prob = 1;
      while (!r.isEmpty()) {
        NodoG last = r.popS();
        NodoG actual = r.peek(); 
        if (actual == null) { 
          tempo.add(last);
          break;
        }
        tempo.add(last);
        println("DE " + last.etiquetas + " a " + actual.etiquetas + " " + getProbabilidad(actual, last));
        prob *= getProbabilidad(actual, last);
      }
      if (prob > min) {
        min = prob;
        camino = tempo;
      }
      tempo = new LinkedListC();
    } 
    return camino;
  }

  /**
   * Metodo que se encarga de calcular las posibiliades de que un Nodo Sano se infecte debido a uno Infectado
   * @param in Nodo infectado
   * @param noIn Nodo no Infectado
   * @return prob Devuelve la probabilidad de que una infeccion suceda.
   */
  public float getProbabilidad(NodoG in, NodoG noIn) {
    if (in.isHasMascarilla()) {
      if (noIn.isHasMascarilla()) {
        if (in.checkDistance(noIn)) {
          return 0.2f;
        } else {
          return 0.3f;
        }
      } else {
        if (in.checkDistance(noIn)) {
          return 0.3f;
        } else {
          return 0.4;
        }
      }
    } else {
      if (noIn.isHasMascarilla()) {
        if (in.checkDistance(noIn)) {
          return 0.4f;
        } else {
          return 0.6f;
        }
      } else {
        if (in.checkDistance(noIn)) {
          return 0.8f;
        } else {
          return 0.9;
        }
      }
    }
  }
}
