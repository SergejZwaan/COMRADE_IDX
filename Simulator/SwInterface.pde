class SwInterface {

  int input;

  SwInterface() {
  }


  void run() {
    if (Comrade_Client.available() > 0) {
      input = Comrade_Client.read();
    }
    println(input);

    if (input == 0) {
      comrade.Set_Manual_Drive();
    }

    if (input == 1) {
      comrade.Set_Autonomous_Drive();
    }
  }
}