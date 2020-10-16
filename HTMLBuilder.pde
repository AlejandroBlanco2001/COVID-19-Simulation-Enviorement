import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException; 

public class HTMLBuilder{
  
  public int contadorDias = 0;
  private String path;
  private LinkedListC<String> tablasString;
  PrintWriter htmlFinalFile;
  
  public HTMLBuilder(){
    tablasString = new LinkedListC();
  }
  
  public void createTableHtml(LinkedListC<Table> tables){
    int cont = 0;
    for(Table t : tables){
      saveTable(t,"data/temp/day"+cont+".html","html");
      cont++;  
    }
    path = dataPath("");
    contadorDias = cont-1;  
  }
  
  public void seperateTagsTable(){
    String html;
    String m[] = null;
    for(int i = 0; i <= contadorDias; i++){
      html = makeFileAString("\\temp\\day"+i+".html");
      m = match(html,"<table>(.|\n)*?</table>");
      tablasString.add(m[0]);
    }
    createHTML(tablasString,"\\temp\\");
  }
  
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
  }
  
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
       htmlFinalFile.println("<img src="+p+">"); //<>//
       htmlFinalFile.println("<br>");
       htmlFinalFile.println(table);
       htmlFinalFile.println("<hr>");
       cont += 1;
     } 
     htmlFinalFile.flush();
     htmlFinalFile.close();
   }
}
