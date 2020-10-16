class Graph{
  private LinkedListC<NodoG> nodes;
  private LinkedListC<NodoG> infected;
  private LinkedListC<NodoG> healthy;
  public LinkedListC<Table> tablas;
  private Table table;
  
  public Graph(){
    nodes = new LinkedListC();
    infected = new LinkedListC();
    healthy = new LinkedListC();
    tablas = new LinkedListC();
    table = new Table();  
  }
  
  public NodoG getRandomNode(){
    NodoG node = nodes.get((int) random(0,nodes.size()));
    return node;
  }
  
  public void createNode(int number){
    NodoG node;
    for(int i = 0; i < number; i++){
      node = new NodoG(i);
      this.nodes.add(node);
    }
  }
  
  public void setMode(int mode){
    for(NodoG g: nodes){
      if(mode == 0){
        g.setHasMascarilla(true);
      }else if(mode == 1){
        g.setHasMascarilla(false);
      }else{
        if((int) random(0,2) == 1){
          g.setHasMascarilla(true);
        }else{
          g.setHasMascarilla(false);
        }
      }
    }
  }
  
  public NodoG[] convertArray(){
    NodoG[] nodos = new NodoG[nodes.size()];
    int i = 0;
    for(NodoG n : this.nodes){
      nodos[i] = n;
      i += 1;
    }
    return nodos;
  }
  
  public void convertList(NodoG[] array){
    LinkedListC<NodoG> n = new LinkedListC();
    for(int i = 0; i < array.length; i++){
      n.add(array[i]);
    }
    this.nodes = n;
  }
  
  public void update(){
    int cont = 0;
    int randomPacienteCero = (int) random(0,nodes.size());
    for(NodoG g: nodes){
      if(cont == randomPacienteCero){
        g.setcontagiadoEn(0);
        infected.add(new Infectado(g));
        g.setInfected(true);
      }else{
        healthy.add(new Sano(g));
      }
      cont += 1;
    }
  }
  
  public void update(int iteracion){
    int cont = 0;
    for(NodoG g: nodes){
      if(g.isInfected == true){
        if(!contains(infected,g)){
          infected.add(new Infectado(g));
          g.setcontagiadoEn(iteracion);
          removeN(healthy,g);
          cont += 1;
        }  
      }
    }
    System.out.println("INFECTADOS POR DIA " + cont);
    makeTablaRegistro(null);
  }
  
 public boolean contains(LinkedListC<NodoG> lista, NodoG n){
    for(NodoG g: lista){
      if(g.etiquetas == n.etiquetas){
        return true;
      }
    }
    return false;
  }
 
  public void removeN(LinkedListC<NodoG> lista, NodoG eliminar){
    int cont = 0;
    for(NodoG g: lista){
      if(g.etiquetas == eliminar.etiquetas){
        lista.delete(cont);  
        return;
      }
      cont += 1;
    }
  }
 
  public LinkedListC<NodoG> getNodes(){
    return nodes;
  } 
  
  public Table makeTablaRegistro(NodoG g){
    if(this.table != null && g == null){
      table = new Table();
      table.addColumn("Modo de la simulacion");
      table.addColumn("Cantidad de Nodos");
      table.addColumn("Etiqueta del Nodo");
      table.addColumn("Estado de Salud (Infectado)");
      table.addColumn("Tiene Mascarilla");
      table.addColumn("Dia de infeccion"); 
    }else{
      TableRow row = table.addRow();
      row.setInt("Modo de la simulacion",1);
      row.setInt("Cantidad de Nodos",nodes.size());
      row.setInt("Etiqueta del Nodo",g.etiquetas);
      if(g.isInfected){
         row.setString("Estado de Salud (Infectado)","Si");
      }else{
         row.setString("Estado de Salud (Infectado)","No");
      }
      if(g.hasMascarilla){
        row.setString("Tiene Mascarilla","Si");
      }else{
        row.setString("Tiene Mascarilla","No");
      }
      row.setString("Dia de infeccion",String.valueOf(g.getContagiadoEn()));
    }
    return table;
   }
      
  public void reporteMinisterioDeSalud(int dia){
    for(NodoG g: nodes){
      System.out.println(g.toString());
      table = makeTablaRegistro(g);
    }
    if(healthy.size() != 0){
      System.out.println("---------------------- RUTA MÁS PROBABLE DE INFECCION PARA LOS SANOS --------------------");
      for(NodoG g : healthy){
        Sano s = (Sano) g;
        s.getMayorRiesgoContagio(new DFSImplementation(), infected);
        System.out.println(s.toString());
      }
    }
    tablas.add(table);
  }

  public boolean isAllInfected(){
    return this.healthy.size() == 0;
  }
  
  public LinkedListC<NodoG> getHealthy(){
    return healthy;
  } 
}
