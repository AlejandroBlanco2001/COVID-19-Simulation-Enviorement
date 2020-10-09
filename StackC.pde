  public class StackC{
    private LinkedListC<NodoG> nodos;
    private int current;
   
    public StackC(){
      this.nodos = new LinkedListC();
      this.current = -1;
    }
    
    public void pushS(NodoG nodo){
      nodos.add(nodo);
      this.current += 1;
    }
    
    public NodoG popS(){
      NodoG g = nodos.get(this.current);
      nodos.delete(this.current);
      this.current -= 1;
      return g;
    }
  
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
    
    public NodoG peek(){
      return nodos.get(current);
    }
    
    public boolean isEmpty(){
      return this.current == -1;
    }
  }
