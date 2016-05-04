class PathPlannerPoint{

  PVector location;
  int id;
  float pointSize = 5.0;
  
  PathPlannerPoint(float x, float y, int i){
    id = i;
    location = new PVector(x,y);
  }
  
  void display(){
    pushMatrix();
      fill(0,50,50);
      translate(0,0,2);
      ellipse(location.x,location.y,pointSize,pointSize);
      translate(0,0,2);
      ellipse(location.x,location.y,pointSize,pointSize);
      translate(0,0,1);
    popMatrix();
  }
  
  PVector getLocation(){
    return location;
  }
}

class PersonPoint {
  PVector location;
  int id;
  float pointSize = 5.0;
  
  PersonPoint(float x, float y, int i){
    id = i;
    location = new PVector(x,y);
  }
  
  void display(){
    pushMatrix();
      fill(0,50,50);
      
      // gui
      translate(0,0,-2);
      ellipse(location.x,location.y,pointSize,pointSize);
      
      // person
      translate(0,0,20);
      if(gui.get_GUI_State() == "PLANNER"){
      ellipse(location.x,location.y,pointSize,pointSize);
      }
      
      translate(location.x,location.y,-35);
      box(10,10,30);
      //shape(testDummy,10,10);
    popMatrix();
  }

}