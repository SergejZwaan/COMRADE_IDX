Table table;

void setup() {
  
  




  
}

void draw(){
  table = loadTable("../data/sharedmemory.csv", "header");
   for (TableRow row : table.rows()) {
    
    int serialAvailable = row.getInt("Serial Available");
    float steer = row.getFloat("Steer Value");
    int controlState = row.getInt("Control State");
    println(serialAvailable + " " + steer + " " + controlState);
  }


}