void init_cap(){
   if (!cap.begin(0x29)) {
    Serial.println("CAP1188 not found");
    while (1);
  }
  Serial.println("CAP1188 found!");
}


void run_cap(){
  
 uint8_t touched = cap.touched();

  if (touched == 0) {
    return;
  }
  
  for (uint8_t i=0; i<8; i++) {
    if (touched & (1 << i)) {
      //Serial.print("C"); Serial.print(i+1); Serial.print("\t");
      output = output + String(i+1);
    } 
  }
 
  

  }
  
