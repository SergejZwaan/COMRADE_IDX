class HwInterface{

  boolean[] cap = new boolean[8];
  String input;
  
  HwInterface(){
  
     // reset cap sense value to false
     resetCap();
  }
  
  void run(){
    recieve_input();
    
  }
  
  void recieve_input(){
    // input message to be returned to the program
    String message;
    // check if serial is avaliable
    while (hwPort.available() > 0) {
      // read serial
      input = hwPort.readString();
        // check if message is a full message
        if(input.length()>= 3 && input != null){
          //locate the end index
          int end = input.indexOf("n");
          // check if n > 0 and if first character is an s
          if(end>0 && input.charAt(0)== 's'){
          // construct message
          message = input.substring(1,end);
          hwInput = message;
          analyze_input();
          // identify no cap input
            if(message.equals("0000")){
              hwInput = "no cap input";
            }
          }
        }
      }
      
    }
    
    void analyze_input(){
      int messageSize = hwInput.length();
      if(messageSize > 0){
         resetCap();
         for(int i = 0; i < messageSize; i++){
           int pad = int(hwInput.charAt(i))-48;
           if(pad > 0 && pad <= 8){
           cap[pad-1] = true;}
         }
      }
      println(cap);
    }
        

     
   
    
   // println(cap);
  
 

  void resetCap(){
      for( int i = 0; i<cap.length; i++){
       cap[i] = false;
     }
  
  }
  
  boolean[] getCap(){
  return cap;
  }

}