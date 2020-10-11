public class Recorrido{
  private LinkedListC<StackC> recorridos;
    
  public Recorrido(){
    recorridos = new LinkedListC();
  }

  public void addP(StackC pilaRecorrido){
    recorridos.add(pilaRecorrido);
  }

  public LinkedListC<NodoG> getCaminoContaigoAlto(){
    float min = 0;
    float prob = 1;
    LinkedListC<NodoG> camino = new LinkedListC();
    LinkedListC<NodoG> tempo = new LinkedListC();
    for(StackC r : recorridos){
      while(!r.isEmpty()){
        NodoG last = r.popS(); //<>//
        NodoG actual = r.peek();  //<>//
        if(actual == null){  //<>//
          tempo.add(last);
          break;
        }
        tempo.add(last); //<>//
        prob *= getProbabilidad(last,actual);
      }
      if(prob > min){
        min = prob;
        camino = tempo;
      }
      tempo = new LinkedListC();
    } 
    return camino; //<>//
  }
  
  public float getProbabilidad(NodoG in, NodoG noIn){
    if(in.isHasMascarilla()){
      if(noIn.isHasMascarilla() && noIn.checkDistance(in)){
        return 0.20;
      }else if(noIn.isHasMascarilla() && !noIn.checkDistance(in)){
        return 0.30;
      }else if(!noIn.isHasMascarilla() && noIn.checkDistance(in)){
        return 0.30;
      }else{
        return 0.40;
      }
    }else{
      if(noIn.isHasMascarilla() && noIn.checkDistance(in)){
        return 0.40;
      }else if(noIn.isHasMascarilla() && !noIn.checkDistance(in)){
        return 0.60;
      }else if(!noIn.isHasMascarilla() && noIn.checkDistance(in)){
        return 0.80;
      }else{
        return 0.90;
      }
    }
  } 
}
  
