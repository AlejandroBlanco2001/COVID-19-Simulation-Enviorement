public class APathfinding{
  
  public LinkedListC<NodeStar> open;
  public LinkedListC<NodeStar> closed;
  public LinkedListC<NodoG> path;
  
  public APathfinding(){
    open = new LinkedListC();
    closed = new LinkedListC();
    path = new LinkedListC();
  }
  
  public class NodeStar{
    private NodoG node;
    private NodeStar parent;
    private float hCost;
    private float gCost;
    private float fCost;
   
    public NodeStar(NodoG node){
      this.node = node;
    }
    
    public void setG(float value){
      this.gCost = value;
    }
    
    public float getG(){
      return gCost;
    }
    
    public void setH(float value){
      this.hCost = value;
    }
    
    public float getH(){
      return hCost;
    }
    
    public void setF(){
      this.fCost = this.hCost + this.gCost;
    }
    
    public void setF(float value){
      this.fCost = value;
    }
    
    public void setParent(NodeStar parent){
      this.parent = parent;
    }
    
    public NodeStar getParentN(){
      return this.parent;
    }
    
    public void setNode(NodoG node){
      this.node = node;
    }
    
    public NodoG getNode(){
      return node;
    }
    
    public float getFCost(){
      return fCost;
    }
  }
  
  public void find(NodoG begin, NodoG end){
    NodeStar beginS = new NodeStar(begin);
    beginS.setNode(begin); //<>//
    beginS.setF(setH(begin,end));
    open.add(beginS);
    NodeStar temp; //<>//
    while(beginS.getNode() != end){ //<>//
      for(NodoG n : beginS.getNode().adjacencyNodes){ //<>//
        if(isIn(n,closed) == false){ //<>//
          temp = new NodeStar(n); //<>//
          temp.setH(setH(temp.getNode(),end)); //<>//
          temp.setG(setG(beginS, temp)); //<>//
          temp.setF(); //<>//
          temp.setParent(beginS); //<>//
          update(temp,open);  //<>//
        }
      }
      closed.add(beginS);
      int deleteIndex = getMinimumFCostIndex(open,beginS.getNode().etiquetas); //<>// //<>// //<>//
      open.delete(deleteIndex);  //<>//
      beginS = getMinimumFCost(open); //<>//
      if(beginS.getNode() == end){
        closed.add(beginS); //<>//
      }
    } //<>//
    construct(closed); //<>// //<>//
  }
  
  public boolean isIn(NodoG nodo,LinkedListC<NodeStar> lista){
    for(NodeStar n: lista){
      if(n.getNode().etiquetas == nodo.etiquetas){
        return true;
      }
    }
    return false;
  } 
   //<>//
  public void construct(LinkedListC<NodeStar> open){ //<>//
    NodeStar parent = open.get(open.size()-1); //<>//
    float sum = 0;
    while(parent != null){ //<>//
      path.add(parent.getNode()); //<>//
      sum += parent.getFCost();
      parent = parent.getParentN(); //<>//
    }
    for(NodoG node : path){ //<>//
      System.out.println(node.etiquetas); //<>//
    }
    System.out.println(sum);
  }
  
  public NodeStar getMinimumFCost(LinkedListC<NodeStar> nodes){
    float min = Float.MAX_VALUE;
    NodeStar mini = null;
    for(NodeStar n: nodes){
      if(n.getFCost() < min){
        min = n.getFCost();
        mini = n;
      }
    }
    return mini;
  }
  
  public int getMinimumFCostIndex(LinkedListC<NodeStar> nodes, int etiqueta){
    int i = 0;
    for(NodeStar n : nodes){
      if(etiqueta == n.getNode().etiquetas){
        return i;
      }
      i++;
    }
    return 0;
  }
 
  /**
    Heuristica de Manhattan
  **/
  public float setH(NodoG begin, NodoG end){
    return abs(begin.xCoord - end.xCoord) + abs(begin.yCoord - end.yCoord);
  }

  public float setG(NodeStar begin, NodeStar destination){
    float sum = 0;
    for(Edge e: begin.getNode().aristas){
      if(e.destino == destination.getNode()){
        sum = e.peso;
      }
    } 
    while(begin.getParentN() != null){
      sum = begin.getG() + sum;
      begin = begin.getParentN();
    }
    return sum;
  }
  
  public void update(NodeStar updateItem, LinkedListC<NodeStar> openList){
    for(NodeStar starN : openList){
      if(starN.getNode().etiquetas == updateItem.getNode().etiquetas){
        if(starN.getG() > updateItem.getG()){
          starN.setF(updateItem.getG() + starN.getH()); //<>//
          starN.setParent(updateItem.getParentN()); //<>//
        }
        return; //<>//
      }
    }
    openList.add(updateItem);
  }
 
}
