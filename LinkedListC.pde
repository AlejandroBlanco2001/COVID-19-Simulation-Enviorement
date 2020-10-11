import java.util.Iterator;

/**
 * Clase que simula el comportamiento y la forma de una Lista Enlazada Simple
 *
 * @author alexz
 * @param <T> Clase generica a pasar
 */
 
public class LinkedListC<T> implements Iterable<T> {

    private Node PTR;

    @Override
    public Iterator<T> iterator() {
        return new LinkedListCIterador<T>(this);
    }

    /**
     * Clase que nos ayuda a recorrer a la clase {@link ListaEnlazada} como un objeto {@link Iterable}
     *
     * @param <T> Nombre de la clase generica a manejar, por ejemplo: String, int y cualquier clase personalizada
     */
    public class LinkedListCIterador<T> implements Iterator<T> {

        /**
         * Posicion donde inicia el recorrido
         */
        Node actual;

        /**
         * Metodo que se encarga de obtener el Nodo inicial a recorrer de la Lista Enlazada Simple, en este caso el PTR.
         *
         * @param lista Lista enlazada que sera recorrida
         */
        public LinkedListCIterador(LinkedListC<T> lista) {
            this.actual = (Node) lista.getPTR();
        }

        @Override
        public boolean hasNext() {
            return actual != null;
        }

        @Override
        public T next() {
            T dato = (T) actual.getDato();
            actual = actual.getLink();
            return dato;
        }
    }

    /**
     * Clase que simula el comportamiento de un Nodo de una Lista Enlazada Simple
     */
    public class Node {

        private Object Dato;
        private Node Link;

        /**
         * Constructor para crear un nodo vacio
         */
        public Node() {
            this.Dato = null;
            this.Link = null;
        }

        /**
         * Metodo que devuelve el objeto que tenga el nodo almacenado
         *
         * @return Dato Objeto que tiene almacenado
         */
        public Object getDato() {
            return Dato;
        }

        /**
         * Metodo que devuelve la direccion de memoria del Nodo siguiente
         * @return Link Direccion de memoria del nodo siguiente
         */
        public Node getLink() {
            return Link;
        }

    }

    /**
     * Crea una Lista Enlazada Simple vacia
     */
    public LinkedListC() {
        PTR = null;
    }

    /**
     * Metodo que se encarga de añadir Nodos a una Lista Enlazada Simple
     * @param item Dato a agregar
     */
    public void add(Object item) {
        Node P = PTR;
        Node Q = new Node();
        if (PTR == null) {
            PTR = new Node();
            PTR.Dato = item;
        } else {
            while (P.Link != null) {
                P = P.Link;
            }
            P.Link = Q;
            Q.Dato = item;
        }
    }

    /**
     * Metodo que se encarga de devolver de acuerdo a una posicion en la Lista Enlazada Simple, el nodo seleccionado
     * @param index Posicion del Nodo a buscar
     * @return Nodo Nodo a buscar, en caso contrario {@code null}
     */
    public T get(int index) {
        int cont = 0;
        Node P = PTR;
        while (P != null) {
            if (cont == index) {
                return (T) P.Dato;
            }
            cont++;
            P = P.Link;
        }
        return null;
    }
    
    public T get(Object item){
        Node P = PTR;
        while (P != null) {
            if (P == item) {
                return (T) P.Dato;
            }
            P = P.Link;
        }
        return null;
    }
    
     /**
     * Metodo que se encarga de eliminar de acuerdo a una posicion en la Lista Enlazada Simple, el nodo seleccionado
     * @param index Posicion del Nodo a buscar
     */
    public void delete(int index){
      Node P = PTR;
      Node antP = PTR;
      if(index == 0){
        antP = PTR.Link;
        PTR = antP; 
      }else{ 
        int i = 0;
        while(i != index){
          antP = P;
          P = P.Link;
          i += 1;
        }
        antP.Link = P.Link;
      } 
    } 
    
     /**
     * Metodo que devuelve el PTR
     * @return PTR Primer nodo de la Lista Enlazada Simple
     */
    public Node getPTR() {
        return PTR;
    }

    /**
     * Metodo que se encarga de limpiar la Lista Enlazada Simple
     */
    public void clear() {
        PTR = null;
    }

    /**
     * Metodo que se encarga de devolvernos la cantidad de nodos que posee una Lista Enlazada Simple
     * @return cont Cantidad de nodos de la Lista Enlazada Simple
     */
    public int size() {
        int cont = 0;
        Node P = PTR;
        while (P != null) {
            P = P.Link;
            cont += 1;
        }
        return cont;
    }
    
    /**
     * Metodo que se encarga de devolver si la Lista Enlazada Simple esta vacia
     * @return Estado {@code True} si el PTR es distinto de Null.
     */
    public boolean isEmpty(){
        return PTR == null;
    }
}
