void communication(){

    String message;
    String zero = "0000";
    
    if(output.length() < 1){
     message = "s" + zero + "n";
    }else{
     message = "s" + output + "n"; 
    
    }
    delay(100);
    Serial.println(message);
  }
