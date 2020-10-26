public class Recorrido {
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
    float prob = 1;
    LinkedListC<NodoG> camino = new LinkedListC();
    LinkedListC<NodoG> tempo = new LinkedListC();
    for (StackC r : recorridos) {
      while (!r.isEmpty()) {
        NodoG last = r.popS();
        NodoG actual = r.peek(); 
        if (actual == null) { 
          tempo.add(last);
          break;
        }
        tempo.add(last);
        prob *= getProbabilidad(actual,last);
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
      if (noIn.isHasMascarilla() && noIn.checkDistance(in)) {
        return 0.20;
      } else if (noIn.isHasMascarilla() && !noIn.checkDistance(in)) {
        return 0.30;
      } else if (!noIn.isHasMascarilla() && noIn.checkDistance(in)) {
        return 0.30;
      } else {
        return 0.40;
      }
    } else {
      if (noIn.isHasMascarilla() && noIn.checkDistance(in)) {
        return 0.40;
      } else if (noIn.isHasMascarilla() && !noIn.checkDistance(in)) {
        return 0.60;
      } else if (!noIn.isHasMascarilla() && noIn.checkDistance(in)) {
        return 0.80;
      } else {
        return 0.90;
      }
    }
  }
}
