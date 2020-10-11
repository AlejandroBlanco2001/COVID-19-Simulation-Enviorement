class Infectado extends NodoG{
  
  public Infectado(NodoG base){
    super(base.etiquetas);
    this.adjacencyNodes = base.adjacencyNodes;
    this.isInfected = true;
  }
  
  public void infecta(){
    boolean infecto;
    for(NodoG vecino: adjacencyNodes){
       if(this.isHasMascarilla()){
        if(vecino.isHasMascarilla() && vecino.checkDistance(this)){
          infecto = Verificador(2);
        }else if(vecino.isHasMascarilla() && !vecino.checkDistance(this)){
          infecto = Verificador(3);
        }else if(!vecino.isHasMascarilla() && vecino.checkDistance(this)){
          infecto = Verificador(3);
        }else{
          infecto = Verificador(4);
        }
      }else{
        if(vecino.isHasMascarilla() && vecino.checkDistance(this)){
          infecto = Verificador(4);
        }else if(vecino.isHasMascarilla() && !vecino.checkDistance(this)){
          infecto = Verificador(6);
        }else if(!vecino.isHasMascarilla() && vecino.checkDistance(this)){
          infecto = Verificador(8);
        }else{
          infecto = Verificador(9);
        }
      }
      if(infecto){
        vecino.isInfected = true;
      }
    }
  }
  
  public boolean Verificador(int prob){
    int randomN = (int) random(1,11);
    switch(prob){
      case 1:
        if(randomN == 1){
          return true;
        }
        break;
      case 2:
        if(randomN <= 2){
          return true;
        }
        break;
      case 3:
        if(randomN <= 3){
          return true;
        }
        break;
      case 4:
        if(randomN <= 4){
          return true;
        }
        break;
      case 5:
        if(randomN <= 5){
          return true;
        }
        break;
      case 6:
        if(randomN <= 6){
          return true;
        }
        break;
      case 7:
        if(randomN <= 7){
          return true;
        }
        break;
      case 8:
        if(randomN <= 8){
          return true;
        }
        break;
      case 9:
        if(randomN <= 9){
          return true;
        }
        break;
      default:
        System.out.println("NO");
    }
      return false;
  }
}
