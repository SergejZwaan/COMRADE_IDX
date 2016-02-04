class Scenario{

  PVector carlocation;
  boolean sendswitch;
  
  Scenario(){
    
   sendswitch = false;
    
  }
  
  void run(){
    carlocation = car.getLocation().copy();
    
    draw_road();
    pushMatrix();
    translate(0,0,5);
    draw_road();
    scenario1();
    popMatrix();
  }
  
  // draw the road visual
  void draw_road(){
  
      pushMatrix();
                translate(0,0,-1.1);
                int margin = 75;
                fill(60);
                
                // roads
                strokeWeight(0);
                rect(margin,margin,(gridWidth/2)-margin,margin);                  // rect 1
                rect(margin,margin,margin,(gridHeight/2)-margin);                 // rect 2
                rect(margin,(gridHeight/2)-margin/2,(gridWidth)-margin*2,margin);  // rect 3
                rect((gridWidth)-margin*2,(gridHeight/2),margin,(gridHeight/2)-margin);   // rect 4
                rect((gridWidth/2),gridHeight-margin*2,(gridWidth/2)-margin,margin);      // rect 5
                
                rect((gridWidth/2)-margin/2,margin,margin,gridHeight-margin*2);                 // rect 6
                
                strokeWeight(1);
                // upper left
               
                // corners outer
                fill(60);
                arc(margin*2+margin, margin*2+margin, margin*4, margin*4, PI, PI+HALF_PI);
                arc(margin*2+margin, gridHeight/2-margin/2-margin, margin*4, margin*4, HALF_PI, PI);
                arc( (gridWidth/2)-margin/2+margin*2, gridHeight-margin*2-margin, margin*4, margin*4,  HALF_PI, PI);
                arc((gridWidth/2)-margin/2-margin, margin*2+margin, margin*4, margin*4, PI+HALF_PI, TWO_PI);
                arc( gridWidth - margin*2-margin, gridHeight/2-margin/2+margin*2, margin*4, margin*4,  PI+HALF_PI, TWO_PI);
                arc( gridWidth - margin*2-margin, gridHeight-margin*2-margin, margin*4, margin*4, 0, HALF_PI);
          
                    translate(0,0,-1);
                    fill(30);
                    arc(margin*2+margin, margin*2+margin, margin*2, margin*2, PI, PI+HALF_PI);
                    arc(margin*2+margin, gridHeight/2-margin/2-margin, margin*2, margin*2, HALF_PI, PI);
                    arc( (gridWidth/2)-margin/2+margin*2, gridHeight-margin*2-margin, margin*2, margin*2, HALF_PI, PI);
                    arc((gridWidth/2)-margin/2-margin, margin*2+margin, margin*2, margin*2, PI+HALF_PI, TWO_PI);
                    arc( gridWidth - margin*2-margin, gridHeight/2-margin/2+margin*2, margin*2, margin*2,  PI+HALF_PI, TWO_PI);
                    arc( gridWidth - margin*2-margin, gridHeight-margin*2-margin, margin*2, margin*2, 0, HALF_PI);
                    
                    // path planner screen visual
                    translate(0,0,1);
                    fill(30);
                    arc(margin*2+margin, margin*2+margin, margin*2, margin*2, PI, PI+HALF_PI);
                    arc(margin*2+margin, gridHeight/2-margin/2-margin, margin*2, margin*2, HALF_PI, PI);
                    arc( (gridWidth/2)-margin/2+margin*2, gridHeight-margin*2-margin, margin*2, margin*2, HALF_PI, PI);
                    arc((gridWidth/2)-margin/2-margin, margin*2+margin, margin*2, margin*2, PI+HALF_PI, TWO_PI);
                    arc( gridWidth - margin*2-margin, gridHeight/2-margin/2+margin*2, margin*2, margin*2,  PI+HALF_PI, TWO_PI);
                    arc( gridWidth - margin*2-margin, gridHeight-margin*2-margin, margin*2, margin*2, 0, HALF_PI);
      popMatrix();
  }
  
  void draw_buildings(){
  
  }
  
  void scenario1(){
    int margin = 75;
    // scenario 1 visuals
    pushMatrix();
    // TODO fix this
    if(!firstperson && pathplannerscreen){ translate(0,0,1); }
    if(firstperson){ translate(0,0,-10); }
    
   
    fill(0,0,255);
    rect(580,75,20,80); // area 1
    rect(220,75,20,80); // area 2
    
    fill(30);
    stroke(255);
    rect(240,(gridHeight/2)-margin/2,gridWidth/2,margin); // area 3
    
    translate(280,130,-5);
    fill(255);
    box(20);
    popMatrix();
    
    // area 1
    if(carlocation.x >580 && carlocation.x <600 && carlocation.y >75 && carlocation.y< 155){
      
                    if(controlState == 1){car.setDriveStatus(false);}
                    if(controlState == 2){car.setDriveStatus(true);}
                    
                    if(sendswitch == false && controlState == 1 && serialavailable){
                    myPort.write ('3');
                    sendswitch = true;
      }
      
    // area 2
    }else if(carlocation.x >220 && carlocation.x <240 && carlocation.y >75 && carlocation.y< 155){
            
               if(sendswitch == false && controlState == 2 && serialavailable){
                    myPort.write ('4');
                    sendswitch = true;}

    }else if(carlocation.x > 240 && carlocation.x < 240 + gridWidth/2 && carlocation.y >(gridHeight/2)-(margin/2) && carlocation.y < (gridHeight/2)-(margin/2) + margin ){
            
              println("test3");
              car.setSpeed(2.0);
    
    }else{
        sendswitch = false;
        car.setSpeed(0.5);
    }
  }

}