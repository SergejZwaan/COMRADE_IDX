class Connection{
  
  String message = "empty";
  String steervalue = "empty";
  String control;
  
  
  Connection(){
  
  
  }
  
  
  void run(){
  
      if ( serialavailable && myPort.available() > 0 ) 
      {  // If data is available,
      message = myPort.readStringUntil('n');         // read it and store it in val
      
      
        //println(message);
        if(message != null && message.length() > 5){
        String initial = message.substring(2,7);
       
        println(initial);
          if( initial.equals("start")){
          
           steervalue = message.substring(7,message.indexOf('b'));
           control = message.substring(message.indexOf('b')+1,message.indexOf('/'));
          
          
          controlState = int(control);
          }
        }
     
      }
      
  
  }

  int getSteerValue(){
    int val = int(steervalue);
    return val;
  
  }
  
  

}