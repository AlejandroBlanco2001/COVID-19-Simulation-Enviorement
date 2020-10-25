public class Graphics { //<>//
  private Graph graph;
  private Point[] puntos;
  private int diametro;


  public Graphics(Graph graph) {
    this.graph = graph;
    puntos = new Point[graph.nodes.size()];
    diametro = 350/graph.nodes.size();
  }

  public void drawGraph() {
    drawNodes();
    drawEdges();
    updateGraph(graph);
  }

  public void drawEdges() {
    for (NodoG nodo : graph.nodes) {
      int i = 1;
      for (NodoG adj : nodo.adjacencyNodes) {
        strokeWeight(3);
        if (isBidireccional(adj, nodo)) {
          stroke(199, 44, 65);
          line(puntos[nodo.etiquetas].x, puntos[nodo.etiquetas].y, puntos[adj.etiquetas].x, puntos[adj.etiquetas].y);
        } else {
          line(puntos[nodo.etiquetas].x, puntos[nodo.etiquetas].y, (puntos[adj.etiquetas].x+puntos[nodo.etiquetas].x)/2, (puntos[adj.etiquetas].y+puntos[nodo.etiquetas].y)/2);
          stroke(199, 44, 65);
          line((puntos[adj.etiquetas].x+puntos[nodo.etiquetas].x)/2, (puntos[adj.etiquetas].y+puntos[nodo.etiquetas].y)/2, puntos[adj.etiquetas].x, puntos[adj.etiquetas].y);
        }
        strokeWeight(0);
        stroke(0);
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
    for (NodoG nodo : graph.nodes) {
      if (nodo.isIsInfected()) {
        fill(1, 169, 180);
      } else {
        fill(255);
      }
      ellipse(puntos[nodo.etiquetas].x, puntos[nodo.etiquetas].y, diametro, diametro);
      fill(50);
      textSize(diametro/3);
      text(nodo.etiquetas, puntos[nodo.etiquetas].x-(diametro/6), puntos[nodo.etiquetas].y-(diametro/6));
    }
  }

  public void drawNodes() {
    int n = 0;
    for (int i = 0; i < graph.nodes.size(); i++) {
      Point punto = new Point ((int)random(20+diametro, 731-diametro), (int)random(20+diametro, 640-diametro));
      while (isIntersected(puntos, punto, i)) {
        punto = new Point ((int)random(20+diametro, 731-diametro), (int)random(20+diametro, 640-diametro));
      }
      puntos[i] = punto;
    }
    for (NodoG nodo : graph.nodes) {
      if (nodo.isIsInfected()) {
        fill(1, 169, 180);
      } else {
        fill(255);
      }
      stroke(0);
      ellipse(puntos[n].x, puntos[n].y, diametro, diametro);
      fill(0);
      textSize(diametro/3);
      text(nodo.etiquetas, puntos[n].x-(diametro/6), puntos[n].y-(diametro/6));
      n++;
    }
  }

  private boolean isIntersected(Point[] puntos, Point punto, int m) {
    boolean v = false;
    for (int i = 0; i < m; i++) {
      if ((punto.x+diametro+10 > puntos[i].x && punto.x < puntos[i].x+diametro) && (punto.y+diametro+10 > puntos[i].y && punto.y < puntos[i].y+diametro)) {
        v = true;
      }
    }
    return v;
  }
}

private class Point {
  private int x;
  private int y;

  public Point(int x, int y) {
    this.x = x;
    this. y = y;
  }
}
