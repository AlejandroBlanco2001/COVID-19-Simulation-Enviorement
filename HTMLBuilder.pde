import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException; 
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class HTMLBuilder{
  
  public int contadorDias = 0;
  private String path;
  private LinkedListC<String> tablasString;
  PrintWriter htmlFinalFile;
  
  /** 
  * Constructor de la clase
  */
  public HTMLBuilder(){
    tablasString = new LinkedListC();
  }
  
  /**
  * Subrutina que se encarga de crear en el directorio del proyecto las tablas de infeccion de cada iteracion.
  * @param tables Lista enlazada simple que contiene todas las tablas a generar
  */
  public void createTableHtml(LinkedListC<Table> tables){
    int cont = 0;
    for(Table t : tables){
      saveTable(t,"data/temp/day"+cont+".html","html");
      cont++;  
    }
    path = dataPath("");
    contadorDias = cont-1;  
  }
  
  /**
  * Subrutina que se encarga de extraer las tablas en formato HTML, es decir, las etiquetas <table> y su contenido
  */
  public void seperateTagsTable(){
    String html;
    int begin = 0, end = 0;
    // MEJOR MANERA -> CAUSA BUG String pat = "<table>(.|\\n)*</table>";
    String m = "";
    for(int i = 0; i <= contadorDias; i++){  //<>// //<>//
        html = makeFileAString("\\temp\\day"+i+".html");  //<>// //<>//
        Pattern pattern = Pattern.compile("<table>");
        Matcher matcher = pattern.matcher(html); //<>// //<>//
        while(matcher.find()){  //<>// //<>//
          begin = matcher.start();  //<>// //<>//
        }
        pattern = Pattern.compile("</table>");
        matcher = pattern.matcher(html);
        while(matcher.find()){
          end = matcher.end();
        }
        m = html.substring(begin,end+1);  //<>// //<>//
        tablasString.add(m);  //<>// //<>//
    }
    createHTML(tablasString,"\\temp\\");
  }
    
  /**
  * Metodo que se encarga devolver una Cadena, es decir, leer el archivo 
  * @param filename Ruta del archivo HTML 
  * @return sb Cadena de la conversion del archivo HTML  
  */
  public String makeFileAString(String filename){
    filename = path + filename;
    StringBuffer sb = new StringBuffer();
        try {
            BufferedReader br = new BufferedReader(new FileReader(filename));
            String line = br.readLine();
            while (line != null) {
                sb.append(line).append("\n");
                line = br.readLine();
            }
            br.close();
        } catch (IOException e) {
            System.out.println("NO SE");
        }
        return sb.toString(); 
  }  //<>// //<>//
  
  /**
  * Subrutina que se encarga de unificar las tablas en un solo documento HTML con las imagenes de cada iteracion
  * @param tablas Lista enlazada simple que contiene las tablas en formato HMTL
  * @param imgRoute Cadena que contiene las rutas de las imagenes a anexar en el documento HTML
  */ //<>// //<>//
  public void createHTML(LinkedListC<String> tablas, String imgRoute){
     htmlFinalFile = createWriter("data/index.html");
     String css = "<link rel=\"stylesheet\" href=\"style.css\">";
     String title = "<title> Simulation Data Summary </title>";
     htmlFinalFile.println(css);
     htmlFinalFile.println(title);
     int cont = 0;
     String ruta = path + imgRoute; 
     for(String table : tablas){
       String p = ruta + "Day"+ cont+".png";
       htmlFinalFile.println("<img src="+p+">"); //<>// //<>// //<>//
       htmlFinalFile.println("<br>");
       htmlFinalFile.println(table);
       htmlFinalFile.println("<hr>");
       cont += 1;
     } 
     htmlFinalFile.flush();
     htmlFinalFile.close();
   }
}
