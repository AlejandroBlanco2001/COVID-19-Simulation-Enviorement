public class Graphics {
  private Graph graph;
  private Point[] puntos;
  private float diam;
  private int cont = 0;


  public Graphics(Graph graph) {
    this.graph = graph;
    puntos = new Point[graph.nodes.size()];
    diam = 370/graph.nodes.size();
  }

  public void drawGraph() {
    cont = 0;
    drawNodes();
    drawEdges();
    updateGraph(graph);
  }

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

  public boolean isBidireccional(NodoG adj, NodoG nodo) {
    for (NodoG adjL : adj.adjacencyNodes) {
      if (adjL.etiquetas == nodo.etiquetas) {
        return true;
      }
    }
    return false;
  }



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

  private boolean isIntersected(Point[] puntos, Point punto, int m) {
    boolean v = false;
    for (int i = 0; i < m; i++) {
      if ((punto.x+diam+10 > puntos[i].x && punto.x < puntos[i].x+diam) && (punto.y+diam+10 > puntos[i].y && punto.y < puntos[i].y+diam)) {
        v = true;
      }
    }
    return v;
  }

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
  private class Point {
    private float x;
    private float y;

    public Point(float x, float y) {
      this.x = x;
      this.y = y;
    }
  }
}
