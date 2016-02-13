class SystemMonitor{

  int steer;
  Table table;
  
  
SystemMonitor(){

  steer = 512;
  table = new Table();
  
  //table.addColumn("Serial Available");
  table.addColumn("Steer Value");
  table.addColumn("Control State");
  
  TableRow newRow = table.addRow();
  newRow.setFloat("Steer Value", steer);
  
}


void run(int Tsteer){
    steer = Tsteer;
    println(
    "serial = " + serialavailable + "  -  " + 
    "steer = " + steer + "  -  " + 
    "controlstate = " +controlState + "  -  " + 
    "theta = " + car.getTheta() + "  -  " + 
    "Speed = " + car.getSpeed() + "  -  " + 
    "drive status = " + car.getDriveStatus() + "  -  " + 
    "Nspeed = " + car.getNettoSpeed()
    );
    
  // save to shared memory
  
  //newRow.setBoolean("Serial Available", serialavailable);
   TableRow row = table.getRow(0);
   row.setFloat("Steer Value", steer);
 // newRow.setInt("name", "Lion");
  saveTable(table, "data/sharedmemory.csv");
}




}