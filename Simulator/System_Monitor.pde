class SystemMonitor{

  int steer;
  
  
SystemMonitor(){

  steer = 512;

}


void run(int Tsteer){
    steer = Tsteer;
    println("serial = " + serialavailable + "  -  " + "steer = " + steer + "  -  " + "controlstate = " +controlState + "  -  " + "theta = " + car.getTheta());
}




}