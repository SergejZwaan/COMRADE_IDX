class StartScreen{
  
  Button simbutton;

  // Initialize
  StartScreen(){
    simbutton = new Button((width/5)*2,height/2-100,200,200,"SIMULATOR");
  }

  // RUN ALL THE FUNCTIONS
  void run(){
      pushMatrix();
      translate(0,0,5);
      draw_screen();
      translate(-100,0,0);
      draw_configButton((width/5),height/2-100,200,200);
      simbutton.display();
      //draw_RunSimulationButton((width/5)*2,height/2-100,200,200);
      draw_PathPlannerButton((width/5)*3,height/2-100,200,200);
      draw_ScenarioPlannerButton((width/5)*4,height/2-100,200,200);
      popMatrix();
      
      if(simbutton.checkClicked() && simbutton.checkHover()){
         gui.set_GUI_State("SIMULATOR"); 
      }
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
           gui.set_GUI_State("SIMULATOR");
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
                gui.set_GUI_State("PATHPLANNER");
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