class StartScreen{
  
  Button simbutton;
  Button configbutton;
  Button plannerbutton;
  Button scenariobutton;

  // Initialize
  StartScreen(){
    simbutton = new Button((width/5)*2,height/2-100,200,200,"SIMULATOR");
    configbutton = new Button((width/5),height/2-100,200,200,"CONFIG");
    plannerbutton = new Button((width/5)*3,height/2-100,200,200, "PLANNER");
    scenariobutton = new Button((width/5)*4,height/2-100,200,200, "SCENARIO");
  }

  // RUN ALL THE FUNCTIONS
  void run(){
      pushMatrix();
      translate(0,0,5);
      draw_screen();
      translate(-100,0,0);
     
      simbutton.display();
      configbutton.display();
      plannerbutton.display();
      scenariobutton.display();
      
     
      popMatrix();
      
      if(simbutton.checkClicked() && simbutton.checkHover()){
         gui.set_GUI_State("SIMULATOR"); 
      }
      
      if(configbutton.checkClicked() && configbutton.checkHover()){
         gui.set_GUI_State("CONFIG"); 
      }
      
      if(plannerbutton.checkClicked() && plannerbutton.checkHover()){
         gui.set_GUI_State("PLANNER"); 
      }
      
      if(scenariobutton.checkClicked() && scenariobutton.checkHover()){
         gui.set_GUI_State("SCENARIO"); 
      }
  }
  
  void draw_screen(){
      fill(30);
      rect(0,0,width,height);
  }
}