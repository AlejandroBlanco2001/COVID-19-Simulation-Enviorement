import java.util.Random;

public static class Shuffle{
  
  public static NodoG[] randomizeArray(NodoG nodos[], int size){
    Random r = new Random();
    for(int i = size-1; i > 0; i--){
      int j = r.nextInt(i+1);
      NodoG temp = nodos[i];
      nodos[i] = nodos[j];
      nodos[j] = temp;
    }
    return nodos;
  }
  
  public static NodoG[] merge(NodoG nodos[]){
    return null;
  }
}
