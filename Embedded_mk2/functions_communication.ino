void communication(){

    system_output();
    system_input();
    
  }

void system_output(){
  
    String message;
    String zero = "0000";
    
    if(output.length() < 1){
     message = "s" + zero + "n";
    }else{
    // message = "s" + output + "p" + systemInput +  "n"; 
     message = "s" + output + "p" + 0 + "n";
     //message = "p";
    }
    delay(5);
    Serial.println(message);
  
  
  }


void system_input(){

 // if (Serial.available() > 0) {
                 // read the incoming byte:
                // input = Serial.read();
                // location = input.toFloat();
                 //Serial.println(location);
        // }

  }




