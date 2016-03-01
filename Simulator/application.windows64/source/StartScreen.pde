class StartScreen{

  // Initialize
  StartScreen(){
  }

  // RUN ALL THE FUNCTIONS
  void run(){
  
      pushMatrix();
      translate(0,0,5);
      draw_screen();
      translate(-100,0,0);
      draw_configButton((width/5),height/2-100,200,200);
      draw_RunSimulationButton((width/5)*2,height/2-100,200,200);
      draw_PathPlannerButton((width/5)*3,height/2-100,200,200);
      draw_ScenarioPlannerButton((width/5)*4,height/2-100,200,200);
      popMatrix();
  
  }
  
  void draw_screen(){
    
      fill(30);
      rect(0,0,width,height);
  }
  
  
  
  void draw_RunSimulationButton(int x, int y, int w, int h){
  
    fill(255);
    rect(x,y,w,h);
    fill(0);
    text("Simulator", x+10, y+20);
    
     if (mousePressed == true ) {
       if(mouseX < (x+w) && mouseX > x){
         if(mouseY < ( y+w) && mouseY > y){
            // code for mousepressed 
           println("button run simulator pressed");
           startscreen = false;
           firstperson = true;
           
           pathplannerscreen = false;
           
            }
         }
      }
  
  
  }
  
  
    void draw_PathPlannerButton(int x, int y, int w, int h){
  
        fill(255);
        rect(x,y,w,h);
        fill(0);
        text("PathPlanner", x+10, y+20);
        
         if (mousePressed == true ) {
           if(mouseX < (x+w) && mouseX > x){
             if(mouseY < ( y+w) && mouseY > y){
                // code for mousepressed 
               println("button run pathplanner pressed");
               startscreen = false;
               firstperson = false;
               startpathplanner = true;
               pathplannerscreen = true;
              
                }
             }
          }
  
  
  }
  
   void draw_configButton(int x, int y, int w, int h){
  
        fill(255);
        rect(x,y,w,h);
        fill(0);
        text("config", x+10, y+20);
        
         if (mousePressed == true ) {
           if(mouseX < (x+w) && mouseX > x){
             if(mouseY < ( y+w) && mouseY > y){
                // code for mousepressed 
               println("button run pathplanner pressed");
               startscreen = false;
               firstperson = false;
               startpathplanner = true;
              
                }
             }
          }
  
  
  }
  
  void draw_ScenarioPlannerButton(int x, int y, int w, int h){
  
        fill(255);
        rect(x,y,w,h);
        fill(0);
        text("ScenarioPlanner", x+10, y+20);
        
         if (mousePressed == true ) {
           if(mouseX < (x+w) && mouseX > x){
             if(mouseY < ( y+w) && mouseY > y){
                // code for mousepressed 
               println("button run pathplanner pressed");
               startscreen = false;
               firstperson = false;
               //startpathplanner = true;
              
                }
             }
          }

  }
  
  
  

}