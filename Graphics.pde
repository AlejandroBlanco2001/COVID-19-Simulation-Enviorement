public class Graphics{
  public Graph graph;
  private Point[] puntos;
  private int radio;
  
  
  public Graphics(Graph graph){
    this.graph = graph;
    puntos = new Point[graph.nodes.size()];
    radio = 400/graph.nodes.size();
  }
  
  public void drawGraph() {
    drawNodes();
    drawEdges(); //<>// //<>//
  }
  
  public void drawEdges() {
    for (NodoG nodo: graph.nodes) {
      for(NodoG adj: nodo.adjacencyNodes) {
          line(puntos[nodo.etiquetas].x, puntos[nodo.etiquetas].y, puntos[adj.etiquetas].x, puntos[adj.etiquetas].y); //<>//
      }
    }
  }
  public void updateGraph(Graph graph) {
    for (NodoG nodo: graph.nodes) {
       if (nodo.isIsInfected()) {
         fill(1,169,180);
       } else {
         fill(255);
       }
       ellipse(puntos[nodo.etiquetas].x, puntos[nodo.etiquetas].y, radio, radio);
       fill(50);
       text(nodo.etiquetas, puntos[nodo.etiquetas].x-(radio/5), puntos[nodo.etiquetas].y-(radio/5));
    }
  }
  
  public void drawNodes() {
    int n = 0;
    rect(10, 10, 800, 550);
    for (int i = 0; i < graph.nodes.size(); i++) {
    Point punto = new Point ((int)random(50, 750),(int)random(50,500));
    
    while (isIntersected(puntos, punto,i)) {
      punto = new Point ((int)random(50, 750),(int)random(50,500));
    }
    
     puntos[i] = punto;
     }
     for (NodoG nodo: graph.nodes) {
       
       if (nodo.isIsInfected()) {
         fill(1,169,180);
       } else {
         fill(255);
       }
       ellipse(puntos[n].x, puntos[n].y, radio, radio); //<>//
       fill(50);
       text(nodo.etiquetas, puntos[n].x-(radio/5), puntos[n].y-(radio/5));
       n++;
     }
     
  }
  private boolean isIntersected(Point[] puntos, Point punto, int m) {
    boolean v = false;
    for (int i = 0; i < m; i++) {
      if ((punto.x+radio+10 > puntos[i].x && punto.x < puntos[i].x+radio) && (punto.y+radio+10 > puntos[i].y && punto.y < puntos[i].y+radio)) {
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
