class SwInterface {

  String input = "";

  SwInterface() {
    //input = -1;// save value
  }

  void run() {
    if (Comrade_Client.available() > 0) {
      input = Comrade_Client.readStringUntil('e');
      if(input.charAt(0) == 'i'){
      //println("input check= " + input);
      // autonomous drive
      char a = input.charAt(1);
      char b = input.charAt(3);
      int intA = int(a)-48;
      
      int intB = int(b)-48;

      // autonomous driving state
      if (intA == 0) {
        comrade.Set_Manual_Drive();
      } else if (intA == 1) {
        comrade.Set_Autonomous_Drive();
      } else {
        // do nothing
        // stay in current mode
      }
       
      // testState
      testState = intB;
      
      println(testState + " " + intA);
    }
   }
  }
}