  public class StackC{
    /**
    * Representacion por medio de Lista Enlazada Simple debido a la necesidad dinamica del programa
    */
    private LinkedListC<NodoG> nodos;
    /**
    * Tope de la pila
    */
    private int current;
   
    /**
    * Constructor de la clase
    */
    public StackC(){
      this.nodos = new LinkedListC();
      this.current = -1;
    }
    
    /**
    * Subrutina que se encarga de agregar Nodos a la Pila e incrementa el tope
    * @param nodo Nodo a agregar
    */
    public void pushS(NodoG nodo){
      nodos.add(nodo);
      this.current += 1;
    }
    
    /**
    * Metodo que se encarga retornar el ultimo elemento agregado a la Pila e eliminarlo de esta
    * @return g Ultimo elemento agregado a la Pila
    */
    public NodoG popS(){
      NodoG g = nodos.get(this.current);
      nodos.delete(this.current);
      this.current -= 1;
      return g;
    }
  
    /**
    * Metodo que se encarga de retornar si un elemento se encuentra en la Pila
    * @param etiquetas Etiquetas del nodo a buscar
    * @return Devuelve {@code true} si el nodo es encontrado, de lo contrario, devuelve {@code false}
    */
    public boolean search(int etiquetas){
      int i = this.current;
      while(i != -1){
        if(nodos.get(i).etiquetas == etiquetas){
          return true;
        }
        i -= 1; 
      }
      return false;
    }
    
    /**
    * Metodo que se encarga de devolver el ultimo elemento agregado a la Pila
    * @return 
    */
    public NodoG peek(){
      return nodos.get(current);
    }
    
    /**
    * Metodo que se encarga de devolver si la Pila se encuentra Vacia 
    * @return Devuelve {@code true} si la Pila se encuentra vacia, de lo contrario, devuelve {@code false}.
    */
    public boolean isEmpty(){
      return this.current == -1;
    }
  }
