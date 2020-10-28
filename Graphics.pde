public class Graphics {
  private Graph graph;
  private Point[] puntos;
  private float diam;
  private int cont = 0;

  /**
  * Constructor que se encarga de la creacion clase
  * @param graph Grafo a dibujar
  */
  public Graphics(Graph graph) {
    this.graph = graph;
    puntos = new Point[graph.nodes.size()];
    diam = 370/graph.nodes.size();
  }

  /**
  * Subrutina que se encarga de dibujar el grafo
  */
  public void drawGraph() {
    cont = 0;
    drawNodes();
    drawEdges();
    updateGraph(graph);
  }

  /**
  * Subrutina que se encarga de dibujar las aristas
  */
  public void drawEdges() {
    for (NodoG nodo : graph.nodes) {
      for (NodoG adj : nodo.adjacencyNodes) {
        strokeWeight(2);
        if (isBidireccional(adj, nodo)) {
          stroke(199, 44, 65);
          line(puntos[nodo.etiquetas].x, puntos[nodo.etiquetas].y, puntos[adj.etiquetas].x, puntos[adj.etiquetas].y);
        } else {
          stroke(0);
          line(puntos[nodo.etiquetas].x, puntos[nodo.etiquetas].y, (puntos[adj.etiquetas].x+puntos[nodo.etiquetas].x)/2, (puntos[adj.etiquetas].y+puntos[nodo.etiquetas].y)/2);
          stroke(199, 44, 65);
          line((puntos[adj.etiquetas].x+puntos[nodo.etiquetas].x)/2, (puntos[adj.etiquetas].y+puntos[nodo.etiquetas].y)/2, puntos[adj.etiquetas].x, puntos[adj.etiquetas].y);
        }
        strokeWeight(0);
        stroke(0);
        float pendiente = (puntos[nodo.etiquetas].y - puntos[adj.etiquetas].y)/(puntos[nodo.etiquetas].x - puntos[adj.etiquetas].x);
        int numNodo = nodeLineIntersection(puntos[nodo.etiquetas].x, puntos[nodo.etiquetas].y, pendiente, nodo.etiquetas, adj.etiquetas);
        if (numNodo != -1 && cont < 2000) {
          cont++;
          print("La cuenta va por: "+cont+"\n");
          puntos[numNodo] = new Point (random(20+diam, 731-diam), random(20+diam, 640-diam));
          removeCP5();
          setGUI();
          updateGraph(graph);
          return;
        }
      }
    }
  }

  /**
  * Metodo que se encarga de devolver si la relacion entre dos nodos es bidirecional
  * @param adj Nodo de inicio
  * @param nodo Nodo de destino
  * @return {@code true} si es su relacion es bidirecional, de lo contrario, devuelve {@code false} 
  */
  public boolean isBidireccional(NodoG adj, NodoG nodo) {
    for (NodoG adjL : adj.adjacencyNodes) {
      if (adjL.etiquetas == nodo.etiquetas) {
        return true;
      }
    }
    return false;
  }

  /**
  * Subrutina que se encarga de redibujar el grafo
  * @param graph Grafo a redibujar 
  */
  public void updateGraph(Graph graph) { 
    drawEdges();
    for (NodoG nodo : graph.nodes) {
      if (nodo.isIsInfected()) {
        fill(1, 169, 180);
      } else {
        fill(255);
      }
      strokeWeight(3);
      if (nodo.isHasMascarilla()) {
        stroke(66, 245, 96);
      } else {
        stroke(230, 245, 66);
      }
      ellipse(puntos[nodo.etiquetas].x, puntos[nodo.etiquetas].y, diam, diam);
      fill(50);
      textSize(diam/3);
      text(nodo.etiquetas, puntos[nodo.etiquetas].x-(diam/6), puntos[nodo.etiquetas].y-(diam/6));
    }
  }

  /**
  * Subrutina que se encarga de dibujar los nodos
  */
  public void drawNodes() {
    int n = 0;
    for (int i = 0; i < graph.nodes.size(); i++) {
      Point punto = new Point (random(20+diam, 731-diam), random(20+diam, 640-diam));
      while (isIntersected(puntos, punto, i)) {
        punto = new Point (random(20+diam, 731-diam), random(20+diam, 640-diam));
      }
      puntos[i] = punto;
    }
    for (NodoG nodo : graph.nodes) {
      if (nodo.isIsInfected()) {
        fill(1, 169, 180);
      } else {
        fill(255);
      }
      strokeWeight(3);
      if (nodo.isHasMascarilla()) {
        stroke(66, 245, 96);
      } else {
        stroke(245, 75, 66);
      }
      ellipse(puntos[n].x, puntos[n].y, diam, diam);
      strokeWeight(0);
      stroke(0);
      fill(0);
      textSize(diam/3);
      text(nodo.etiquetas, puntos[n].x-(diam/6), puntos[n].y-(diam/6));
      n++;
    }
  }

  /**
  * Metodo que se encarga de devovler si dos nodos se intersectan
  * @param puntos Coordenadas de los nodos en el plano
  * @param punto Coordenada del nodo a verificar
  * @param nodosDibujados Cantidad de nodos dibujados
  * @return v {@code true} si se intersecta con alguno nodo, de lo contrario, retorna {@code false}
  */
  private boolean isIntersected(Point[] puntos, Point punto, int nodosDibujados) {
    boolean v = false;
    for (int i = 0; i < nodosDibujados; i++) {
      if ((punto.x+diam+10 > puntos[i].x && punto.x < puntos[i].x+diam) && (punto.y+diam+10 > puntos[i].y && punto.y < puntos[i].y+diam)) {
        v = true;
      }
    }
    return v;
  }

  /**
  * Metodo que se encarga de devovler si un nodos se intersecta con una linea
  * @param x1 Coordenada en X del punto inicial de la linea
  * @param y1 Coordenada en Y del punto inicial de la linea
  * @param pendiente Pendiente de la linea
  * @param nodoI Nodo inicial
  * @param nodoF Nodo Final
  * @return Devuelve la etiqueta del nodo el cual tenga una interseccion con una linea
  */ 
  private int nodeLineIntersection(float x1, float y1, float pendiente, int nodoI, int nodoF) {
    boolean nodo1 = false, nodo2 = false;
    for (float i = 30; i < 740; i++) {
      float y = pendiente*(i-x1)+y1;
      if (isInNodo(i, y, nodoI)) {
        nodo1 = true;
      }
      if (isInNodo(i, y, nodoF)) {
        nodo2 = true;
      }
      if (nodo1 == true && nodo2 == false) {
        for (NodoG nodo : graph.nodes) {
          if (nodo.etiquetas != nodoI && nodo.etiquetas != nodoF) {
            if (isInNodo(i, y, nodo.etiquetas)) {
              return nodo.etiquetas;
            }
          }
        }
      }
    }
    return -1;
  }

  /**
  * Metodo que se encarga de verificar si un punto esta dentro de una circunferencia, usando la formula de la distancia
  * @param x Coordenada en X del punto
  * @param y Coordenada en Y del punto 
  * @param nodoEtiqueta Etiqueta de la circunferencia del nodo
  * @return {@code true} si el punto esta dentro de la circunferencia, de lo contrario, devuelve {@code false}
  */
  public boolean isInNodo(float x, float y, int nodoEtiqueta) {
    float deltaX = (puntos[nodoEtiqueta].x - x) * (puntos[nodoEtiqueta].x - x);
    float deltaY = (puntos[nodoEtiqueta].y - y) * (puntos[nodoEtiqueta].y - y);
    float raiz = deltaX + deltaY;
    if (sqrt((float)raiz) <= (this.diam/2)+diam/6) {
      return true;
    } else {
      return false;
    }
  }

  /**
  * Metodo que se encarga de devolver la etiqueta del nodo
  * @return i Etiqueta del nodo
  */
  public int showNodo() {
    for (int i = 0; i < puntos.length; i++) {
      float deltaX = (puntos[i].x - mouseX) * (puntos[i].x - mouseX);
      float deltaY = (puntos[i].y - mouseY) * (puntos[i].y - mouseY);
      float raiz = deltaX + deltaY;
      if (sqrt((float)raiz) <= this.diam/2) {
        showInfo(i);
        return i;
      }
    }
    return -1;
  }

  /**
  * Subrutina que se encarga de mostrar toda la informacion del nodo
  * @param i etiqueta del nodo
  */
  private void showInfo(int i) {
    NodoG nodoAnt = null;
    NodoG nodo = graph.getNode(i);
    if (nodo.isIsInfected()) {
      fill(0);
      textSize(45);
      text("Nodo #"+nodo.etiquetas+" infectado en el día: "+nodo.getContagiadoEn(), 30, 690);
      for (NodoG adj : nodo.getAdjacencyNodes()) {
        if (!adj.isIsInfected()) {
          fill(175, 45, 45);
          ellipse(puntos[adj.etiquetas].x, puntos[adj.etiquetas].y, diam, diam);
        }
      }
    } else {

      Sano s = new Sano(nodo);
      s.getMayorRiesgoContagio(new DFSImplementation(), graph.infected);
      for (NodoG rec : s.dangerousPath) {
        NodoG nodoAct = rec;
        if (rec.isIsInfected()) {
          fill(175, 45, 45);
        } else {
          fill(204, 237, 237);
        }
        ellipse(puntos[rec.etiquetas].x, puntos[rec.etiquetas].y, diam, diam);
        fill(0);

        strokeWeight(2);
        if (nodoAnt != null) {
          if (isBidireccional(nodoAnt, nodoAct)) {           
            stroke(255, 0, 239);
            line(puntos[nodoAct.etiquetas].x, puntos[nodoAct.etiquetas].y, puntos[nodoAnt.etiquetas].x, puntos[nodoAnt.etiquetas].y);
          } else {
            stroke(0);
            line(puntos[nodoAct.etiquetas].x, puntos[nodoAct.etiquetas].y, (puntos[nodoAnt.etiquetas].x+puntos[nodoAct.etiquetas].x)/2, (puntos[nodoAnt.etiquetas].y+puntos[nodoAct.etiquetas].y)/2);
            stroke(255, 0, 239);
            line((puntos[nodoAnt.etiquetas].x+puntos[nodoAct.etiquetas].x)/2, (puntos[nodoAnt.etiquetas].y+puntos[nodoAct.etiquetas].y)/2, puntos[nodoAnt.etiquetas].x, puntos[nodoAnt.etiquetas].y);
          }
          textSize(diam/3);
          text(rec.etiquetas, puntos[rec.etiquetas].x-(diam/6), puntos[rec.etiquetas].y-(diam/6));
          textSize(45);
          text("Nodo #"+nodo.etiquetas, 30, 690);
          fill(0);
        }
        nodoAnt = rec;
      }
    }
  }

  /**
  * Abstraccion de la idea de un Punto en el plano
  */
  private class Point {
    private float x;
    private float y;

    /**
    * Constructor de la clase
    */
    public Point(float x, float y) {
      this.x = x;
      this.y = y;
    }
  }
}
