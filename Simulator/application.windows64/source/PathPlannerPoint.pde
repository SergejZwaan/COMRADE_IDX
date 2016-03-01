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
      translate(0,0,-2);
      ellipse(location.x,location.y,pointSize,pointSize);
      translate(0,0,2);
      ellipse(location.x,location.y,pointSize,pointSize);
      translate(0,0,-1);
    popMatrix();
  }
  
  PVector getLocation(){
    return location;
  }
}