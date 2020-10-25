import controlP5.*; //<>//

private Graph graph;
private boolean startA = false;
private boolean step = false;
private int mode = 2;
private boolean started = true;
private boolean createdResume = false;
private int population = -1;
private Graphics graphics;
private boolean infoToggled = false;
int contador = 0;
double inicio; 
double time;
ControlP5 cp5;

void setup() {
  size(1080, 720);
  cp5  = new ControlP5(this);
  setGUI();
  surface.setTitle("COVID-19 Simulation");
  PFont p = createFont("Verdana", 10); 
  ControlFont font = new ControlFont(p);
  cp5.setFont(font);
}

void draw() {
  if (startA) {
    if (!graph.isAllInfected()) {
      if (System.currentTimeMillis() - inicio > 60000 || step) {
        simulate();
        step = false;
      }
    } else {
      println("SE ACABO LA SIMULACION con " + contador + " iteraciones");
      startA = false;
      started = true;
      createdResume = true;
      graph = null;
    }
  }
  if (infoToggled) {
    if (System.currentTimeMillis() - time > 2000) {
      removeCP5();
      setGUI();
      graphics.updateGraph(graph);
      infoToggled = !infoToggled;
    }
  }
}

public void setGUI() {
  noStroke();
  background(255, 255, 255);
  rectMode(CORNER);
  fill(0, 0, 0, 30);
  rect(30, 30, 730, 600);
  rectMode(CENTER);
  fill(0, 0, 0, 30);
  rect(920, 130, 260, 210);
  fill(0, 0, 0, 30);
  rect(920, 360, 260, 190);
  textSize(16);
  fill(0, 0, 0);
  text("Cantidad de personas", 835, 170);
  text("Uso de la mascarilla", 840, 70);
  if (population == -1) {
    cp5.addSlider("peopleValues").setPosition(820, 180).setSize(200, 30).setValue(2).setRange(2, 100).setNumberOfTickMarks(100).setSliderMode(Slider.FLEXIBLE);
    cp5.getController("peopleValues").setCaptionLabel("");
  }
  cp5.addButton("inicia").setPosition(820, 290).setSize(200, 30);
  cp5.getController("inicia");
  cp5.getController("inicia").setCaptionLabel("Inicia la simulacion");
  cp5.addButton("Genera_Nuevo_Grafo").setPosition(820, 330).setSize(200, 30);
  cp5.getController("Genera_Nuevo_Grafo").setCaptionLabel("Genera un nuevo grafo aleatorio");
  cp5.addButton("Ver_Resumen").setPosition(820, 370).setSize(200, 30);
  cp5.getController("Ver_Resumen").setCaptionLabel("Generar sumario de la simulacion");
  cp5.addButton("Siguiente_Dia").setPosition(820, 410).setSize(200, 30);
  cp5.getController("Siguiente_Dia").setCaptionLabel("Avanzar al siguiente dia");
  cp5.addButton("Mascarilla").setPosition(800, 90).setSize(75, 30);
  cp5.getController("Mascarilla").setCaptionLabel("Obligatorio");   
  cp5.addButton("Sin_Mascarilla").setPosition(880, 90).setSize(75, 30);
  cp5.getController("Sin_Mascarilla").setCaptionLabel("Nadie");   
  cp5.addButton("Aleatorio").setPosition(960, 90).setSize(75, 30);
  cp5.getController("Aleatorio").setCaptionLabel("Uso aleatorio");
}


/*public void buildIndex(){
 HTMLBuilder htmlB = new HTMLBuilder();
 htmlB.createTableHtml(graph.tablas);
 htmlB.seperateTagsTable(); 
 }*/

private void reload(int modo, int poblacion) {
  graph = new Graph();
  graph.createNode(poblacion);
  graph = crearRanGrafo(graph);
  /*println("-----------------------DISPOSICION DE LA SIMULACION--------------------------------");
   for (NodoG g : graph.getNodes()) {
   if (g.isInfected) {
   println("INFECTADO|" + g.etiquetas);
   }
   for (Edge e : g.aristas) {
   println("ORIGEN " + e.inicio.etiquetas + "| DESTINO " + e.destino.etiquetas + " CON UN PESO DE " + e.peso);
   }
   }
   println("---------------------------------------------------------------------------------------");*/
  graph.setMode(modo);
  graph.update();
  inicio = System.currentTimeMillis();
  graphics = new Graphics(graph);
  graphics.drawGraph();
  contador = 0;
}


private void simulate() {
  saveFrame("/data/temp/Day"+contador+".png");
  contador += 1;
  avanzaGeneracion();
  graph.update(contador);
  graphics.updateGraph(graph);
  println("REPORTE DEL MINISTERIO DE SALUD - DIA " + contador);
  println("SALUDABLES " + graph.getHealthy().size());
  graph.reporteMinisterioDeSalud(contador);
  println("--------------------------------------------------------------");
  inicio = System.currentTimeMillis();
}

public void Sin_Mascarilla() {
  mode = 1;
}

public void Aleatorio() {
  mode = 2;
}

public void Mascarilla() {
  mode = 0;
}
public void inicia() {
  println("ARRANCA");
  if (started) {
    if (graph!=null) {
      startA = true;  
      started = false;
      createdResume = false;
    }
  }
}

public void peopleValues(int persona) {
  population = persona;
}

public void lala() {
  print("awnodale");
}

public void Ver_Resumen() {
  if (createdResume) {
    String path = dataPath("");
    //buildIndex();
    println("Dirigite a " + path + "\\temp\\index.html, no borre la carpeta temp");
  } else {
    println("ARCHIVO NO GENERADO AUN");
  }
}

public void Genera_Nuevo_Grafo() {
  println("REINICIA");
  startA = false;
  started = true;
  clear();
  int pop = population;
  removeCP5(); 
  population = pop;
  setGUI();
  reload(mode, pop);
}

public void removeCP5() {
  cp5.getController("inicia").remove();
  cp5.getController("Genera_Nuevo_Grafo").remove();
  cp5.getController("Ver_Resumen").remove();
  cp5.getController("Siguiente_Dia").remove();
  cp5.getController("Mascarilla").remove();   
  cp5.getController("Sin_Mascarilla").remove();   
  cp5.getController("Aleatorio").remove();
}

public void Siguiente_Dia() {
  if (startA) { 
    println("EL OTRO DIA...");
    step = true;
  } else {
    println("SIMULACION TERMINADA, POR FAVOR, CREE UN NUEVO GRAFO");
  }
}

private void avanzaGeneracion() {
  for (NodoG n : graph.infected) {
    Infectado i = (Infectado) n;
    i.infecta();
  }
}

private Graph crearRanGrafo(Graph grafo) {
  NodoG[] nodos = new NodoG[grafo.nodes.size()]; 
  nodos = grafo.convertArray();
  nodos = Shuffle.randomizeArray(nodos, grafo.nodes.size());
  for (int i = 0; i < nodos.length; i++) {
    if (i + 1 != nodos.length) {
      float peso = random(1, 11);
      NodoG next = nodos[i+1];
      nodos[i].addEdge(new Edge(nodos[i], next, peso));
      nodos[i+1].addEdge(new Edge(next, nodos[i], peso));
    }
    int randomNumber = (int) random(0, nodos.length);
    int randomConexion = (int) random(0, 2);
    while (randomNumber == i) {
      randomNumber = (int) random(0, nodos.length);
    }
    if (randomConexion == 0) {
      nodos[i].addEdge(new Edge(nodos[i], nodos[randomNumber], random(1, 11)));
    } else {
      nodos[randomNumber].addEdge(new Edge(nodos[randomNumber], nodos[i], random(1, 11)));
    }
  }
  graph.convertList(Shuffle.getOrdered((nodos)));
  return graph;
}

public void mousePressed() {
  println(mouseX + " | " + mouseY);
  if (startA) {
    time = System.currentTimeMillis();
    if (infoToggled == false) {
      if (graphics.showNodo() != -1) {
        infoToggled = true;
      }
    }
  }
}
