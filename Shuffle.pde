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
  
  static void mergeSort(NodoG nodos[], int start, int end) {
    if(start < end) {
      int mid = (start + end) / 2;
      mergeSort(nodos, start, mid);
      mergeSort(nodos, mid+1, end);
      merge(nodos, start, mid, end);
    }
  }

  public static NodoG[] getOrdered(NodoG nodos[]){
    mergeSort(nodos, 0, nodos.length-1); 
    return nodos;
  }  

  // Codigo sacado de https://www.interviewbit.com/tutorial/merge-sort-algorithm/
  public static void merge(NodoG nodos[], int start, int mid, int end){
    NodoG sub1[] = new NodoG[end-start+1];
    int i = start, j = mid + 1, k = 0;
    while(i <= mid && j <= end){
      if(nodos[i].etiquetas <= nodos[j].etiquetas){
        sub1[k] = nodos[i];
        k += 1;
        i += 1;
      }else{
         sub1[k] = nodos[j];
          k += 1;
          j += 1;
      }
   }
      
    while(i <= mid){
      sub1[k] = nodos[i];
      k += 1;
      i += 1;      
    }
      
    while(j <= end){
      sub1[k] = nodos[j];
      k += 1;
      j += 1;
    }
    
    for(i = start; i <= end; i += 1){
      nodos[i] = sub1[i - start];
    }
  }

}
