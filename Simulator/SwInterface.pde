class SwInterface {

  int input;

  SwInterface() {
    input = -1;// save value
  }

  void run() {
    if (Comrade_Client.available() > 0) {
      input = Comrade_Client.read();
      if (input == 0) {
        comrade.Set_Manual_Drive();
      } else if (input == 1) {
        comrade.Set_Autonomous_Drive();
      } else {
        // do nothing
        // stay in current mode
      }
    }
  }
}