class Graph {
  private LinkedListC<NodoG> nodes;
  private LinkedListC<NodoG> infected;
  private LinkedListC<NodoG> healthy;
  public LinkedListC<Table> tablas;
  private Table table;

  /**
   * Constructor de la clase
   */
  public Graph() {
    nodes = new LinkedListC();
    infected = new LinkedListC();
    healthy = new LinkedListC();
    tablas = new LinkedListC();
    table = new Table();
  }

  /**
   * Metodo que se encarga de devolver un nodo aleatorio del grafo
   * @return node Nodo aleatorio
   */
  public NodoG getRandomNode() {
    NodoG node = nodes.get((int) random(0, nodes.size()));
    return node;
  }

  /**
   * Subrutina que se encarga de crear una cantidad N de nodos del grafo
   * @param number Cantidad de nodos a crear
   */
  public void createNode(int number) {
    NodoG node;
    for (int i = 0; i < number; i++) {
      node = new NodoG(i);
      this.nodes.add(node);
    }
  }

  /**
   * Subrutina que se encarga de seleccionar si el Nodo debe llevar o no mascarilla
   * @param mode Decision del usuario con respecto al porte de mascarillas, 0 todos deben llevar, 1 ninguno debe llevar y 2 aleatorio
   */
  public void setMode(int mode) {
    for (NodoG g : nodes) {
      if (mode == 0) {
        g.setHasMascarilla(true);
      } else if (mode == 1) {
        g.setHasMascarilla(false);
      } else {
        if ((int) random(0, 2) == 1) {
          g.setHasMascarilla(true);
        } else {
          g.setHasMascarilla(false);
        }
      }
    }
  }

  /**
   * Metodo que se encarga de convertir una Lista Enlazada Simple a una array con el mismo tamaño
   * @return nodos Array que contiene los nodos de la lista
   */
  public NodoG[] convertArray() {
    NodoG[] nodos = new NodoG[nodes.size()];
    int i = 0;
    for (NodoG n : this.nodes) {
      nodos[i] = n;
      i += 1;
    }
    return nodos;
  }

  /**
   * Subrutina que se encarga de convertir en una Lista Enlazada Simple dada una Array.
   * @param array Array a convertir en Lista Enlazada Simple
   */
  public void convertList(NodoG[] array) {
    LinkedListC<NodoG> n = new LinkedListC();
    for (int i = 0; i < array.length; i++) {
      n.add(array[i]);
    }
    this.nodes = n;
  }

  /**
   * Subrutina que se encarga de actualizar los datos del grafo en el dia 0
   */
  public void update() {
    int cont = 0;
    int randomPacienteCero = (int) random(0, nodes.size());
    for (NodoG g : nodes) {
      if (cont == randomPacienteCero) {
        g.setcontagiadoEn(0);
        infected.add(new Infectado(g));
        g.setInfected(true);
      } else {
        healthy.add(new Sano(g));
      }
      cont += 1;
    }
  }

  /**
   * Subrutina que se encarga de actualizar los datos del grafo a partir del dia 1 en adelante
   * @param iteracion Dia de la actualizacion del grafo
   */
  public void update(int iteracion) {
    int cont = 0;
    for (NodoG g : nodes) {
      if (g.isInfected == true) {
        if (!contains(infected, g)) {
          infected.add(new Infectado(g));
          g.setcontagiadoEn(iteracion);
          removeN(healthy, g);
          cont += 1;
        }
      }
    }
    System.out.println("INFECTADOS POR DIA " + cont);
    makeTablaRegistro(null, 0);
  }

  /*
 * Metodo que se encarga de verificar si un elemento se encuentra en una lista
   * @param lista Lista Enlazada Simple a inspeccionar
   * @param n Nodo a verificar si existe contenido en la lista
   * @return {@code true} si el nodo esta contenido en la Lista, de lo contrario, devuelve {@code false}
   */
  public boolean contains(LinkedListC<NodoG> lista, NodoG n) {
    for (NodoG g : lista) {
      if (g.etiquetas == n.etiquetas) {
        return true;
      }
    }
    return false;
  }

  public void removeN(LinkedListC<NodoG> lista, NodoG eliminar) {
    int cont = 0;
    for (NodoG g : lista) {
      if (g.etiquetas == eliminar.etiquetas) {
        lista.delete(cont);  
        return;
      }
      cont += 1;
    }
  }

  /*
  * Metodo que devuelve la lista de nodos del grafo
   * @return nodes Nodos del grafo
   */
  public LinkedListC<NodoG> getNodes() {
    return nodes;
  } 

  /*
  * Metodo que se encarga de añadir en cada fila los nodos de esa iteracion
   * @param g Nodo a añadir a la tabla
   * @param dia Dia en el cual se creo
   * @return table Tabla del dia respectivo
   */
  public Table makeTablaRegistro(NodoG g, int dia) {
    if (this.table != null && g == null) {
      table = new Table();
      table.addColumn("Día");
      table.addColumn("Modo de la simulacion");
      table.addColumn("Cantidad de Nodos");
      table.addColumn("Etiqueta del Nodo");
      table.addColumn("Estado de Salud (Infectado)");
      table.addColumn("Tiene Mascarilla");
      table.addColumn("Dia de infeccion");
    } else {
      TableRow row = table.addRow();
      row.setInt("Día", dia);
      row.setInt("Modo de la simulacion", 1);
      row.setInt("Cantidad de Nodos", nodes.size());
      row.setInt("Etiqueta del Nodo", g.etiquetas);
      if (g.isInfected) {
        row.setString("Estado de Salud (Infectado)", "Si");
      } else {
        row.setString("Estado de Salud (Infectado)", "No");
      }
      if (g.hasMascarilla) {
        row.setString("Tiene Mascarilla", "Si");
      } else {
        row.setString("Tiene Mascarilla", "No");
      }
      row.setString("Dia de infeccion", String.valueOf(g.getContagiadoEn()));
    }
    return table;
  }

  /**
   * Subrutina que se encarga de mostrar en pantalla los nodos infectados, sanos y la ruta de mayor contagio para cada nodo sano
   * @param dia Iteraccion en la que se encuentra la simulacion
   */
  public void reporteMinisterioDeSalud(int dia) {
    for (NodoG g : nodes) {
      System.out.println(g.toString());
      table = makeTablaRegistro(g, dia);
    }
    if (healthy.size() != 0) {
      System.out.println("---------------------- RUTA MÁS PROBABLE DE INFECCION PARA LOS SANOS --------------------");
      for (NodoG g : healthy) {
        Sano s = (Sano) g;
        s.getMayorRiesgoContagio(new DFSImplementation(), infected);
        System.out.println(s.toString());
      }
    }
    tablas.add(table);
  }

  /**
   * Metodo que se encarga de retornar el tamaño de la lista de personas saludables 
   * @return {@code true} si todos los nodos estan infectados, de lo contrario, {@code false} si no lo estan
   */
  public boolean isAllInfected() {
    return this.healthy.size() == 0;
  }

  /**
   * Metodo que se encarga de devovler la lista de las personas saludables
   * @return healthy Lista Enlazada Simple de las personas saludables
   */
  public LinkedListC<NodoG> getHealthy() {
    return healthy;
  } 
  /**
   * Metodo que se encarga de buscar y devovler un nodo segun su etiqueta
   * @param etiqueta Etiqueta del nodo a buscar
   * @return nodo Si el nodo ha sido encontrado
   */
  public NodoG getNode(int etiqueta) {
    for (NodoG nodo : nodes) {
      if (nodo.etiquetas == etiqueta) {
        return nodo;
      }
    }
    return null;
  }
}
