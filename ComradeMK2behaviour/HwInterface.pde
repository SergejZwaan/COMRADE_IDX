class HwInterface{

  boolean[] cap = new boolean[8];
  PVector location;
  PVector velocity;
  String input;
  int leftcounter = 0;
  int rightcounter = 0;
  boolean switchInput = false;
  int[] swipeCounter = new int[2];
  
  HwInterface(){
     location = new PVector(0.0,0.0);
     velocity = new PVector(0.0,0.0);
     // reset cap sense value to false
     resetCap();
  }
  
  void run(){
    recieve_input();
    send_output();
    calculate_sprite();
    
  }
  
  void recieve_input(){
    // input message to be returned to the program
    String message;
    // check if serial is avaliable
    while (hwPort.available() > 0) {
      // read serial
      input = hwPort.readString();
    //  println(input);
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
              switchInput = false;
            }

          }
        }
      }
      
    }
    
    void analyze_input(){
      
      //int messageSize = hwInput.length();
      int messageSize = hwInput.indexOf('p');
      println(messageSize);
      if(messageSize > 0){
         resetCap();
         
         for(int i = 0; i < messageSize+1; i++){
           int pad = int(hwInput.charAt(i))-48;
           if(pad > 0 && pad <= 8){
           cap[pad-1] = true;}
         }
         
         if(cap[0] == true || cap[7] == true){
           int counter = 0;
           for(int i = 1; i < 7; i++){
             if(cap[i] == false){
               counter++;
             }
           }
           if(counter == 6){
           hwInput = "no cap input";
           switchInput = false;
           }
         }
      }
      //println(cap);
      
     
      
    }
    
    
  void send_output(){
      PVector location = comrade.get_Location();
     // String message = str(location.x);
      String message = nf(location.x, 4, 1);
      hwPort.write('i' + message + 'e');
    //  println(message);
     
  }
    
  void calculate_sprite(){
  
   float target = 0.0;
      
      if( hwInput != null && !hwInput.equals("no cap input")){
        int pos = 0;
        for(int i = 6; i > 0; i--){
          if(cap[i] == true){
            if(!switchInput){
              location = new PVector(pos*50,0);
              switchInput = true;
            }else{
              target = pos*50;  
            }
          }
          pos++;
        }
      }
      
      if( hwInput != null && hwInput.equals("no cap input")){
      target = 0.0;
      location = new PVector(0,0);
      switchInput = false;
      leftcounter = 0;
      rightcounter = 0;
      }
      
      if(target > location.x){
        velocity.x = 4.0;
        rightcounter++;
        leftcounter = 0;
      } else if( target < location.x){
        velocity.x = -4.0;
        leftcounter++;
        rightcounter= 0;
      }
      
      if(abs((target) - location.x)< 0.2){
        velocity.x = 0.0;
      }
      
      location.add(velocity);
  
      //println(leftcounter + " " + rightcounter);
  
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
  
  PVector getLocation(){
  return location;
  }
  
  int[] getSwipeCounter(){
    swipeCounter[0] = leftcounter;
    swipeCounter[1] = rightcounter;
    return swipeCounter;
  }

}