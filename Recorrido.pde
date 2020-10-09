public class Recorrido{
  public LinkedListC<NodoG> recorrido;
    
  public Recorrido(){
    recorrido = new LinkedListC();
  }

  public void addS(NodoG nodo){
    recorrido.add(nodo);
  }
  
  public void showListRecords(){
    for(NodoG r: recorrido){
      System.out.print(r.etiquetas+"|");
    }
    System.out.println("");
  }
}
  
