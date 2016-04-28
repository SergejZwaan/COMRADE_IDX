class PlannerScreen{

PlannerScreen(){

}

void display(){
  pushMatrix();
  translate(0,0,10);
  fill(0,200,250);
  line(mouseX,0,mouseX,gridHeight);
  line(0,mouseY,gridWidth,mouseY);
  ellipse(mouseX,mouseY,10,10);
  popMatrix();
}


}