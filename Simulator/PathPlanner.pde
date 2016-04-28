class PathPlanner {


  boolean listfull = false; // if list is full
  boolean listcreated = false; // if list is created
  boolean mousePres = false;

  boolean createpersonlist = true;
  boolean personlistfull = false;
  boolean personlistcreated = false;

  boolean autonomousdrive = false; // autonomous drive switch state

  boolean find_closest_checkpoint = false;
  boolean autonomous_driving_running = false; // if autonomous driving is running

  int identity = 0;
  int focusCheckPoint = 0;
  int pointnumbers = 40;

  PVector force;

  int[] xcor = {783, 781, 766, 747, 715, 661, 514, 379, 300, 232, 185, 157, 140, 132, 132, 132, 138, 151, 171, 196, 299, 603, 871, 1079, 1283, 1374, 1433, 1469, 1497, 1505, 1505, 1495, 1453, 1383, 1287, 916, 865, 820, 797, 785};
  int[] ycor = {362, 211, 180, 155, 137, 134, 130, 128, 128, 126, 137, 158, 185, 219, 251, 288, 321, 349, 374, 384, 383, 383, 383, 383, 385, 386, 397, 421, 458, 494, 560, 623, 675, 701, 702, 701, 689, 667, 634, 601};

  int[] xcor1 = {
    871,716,625,363,118,59,202,385,594,730,869,1074,1203,964,851,742,1141,1285,1519,1408
  };
  
  int[] ycor1 = {
    297,210,57,172,91,311,451,342,348,348,345,352,449,450,551,593,737,733,632,468
  };
  

  int[] xcor2 = {
    851,750,841,822,600,483,456,437,254,220,
    125,72,68,70,245,196,338,617,589,712,
    880,949,1005,1048,1146,1305,1254,1427,1528,1492,
    1389,1080,1181,865,842,747,760,814,1000,1292
  };
  
  int[] ycor2 = {
    337,261,176,110,58,56,167,166,59,58,
    99,189,304,317,449,451,353,449,449,349,
    350,451,443,355,356,352,447,479,581,673,
    732,640,636,620,557,519,630,713,734,632
  };

 int[] xcor3 = {
    828,862,822,814,862,817,852,832,783,805,
    712,725,609,638,541,523,559,404,345,357,
    222,196,137,117,87,120,91,69,87,89,
    115,149,171,208,254,285,217,324,399,366,
    474,512,550,568,617,708,684,792,853,852,
    895,960,942,1037,1054,1053,1012,1116,1092,1147,
    1165,1201,1226,1262,1243,1300,1329,1306,1373,1406,
    1419,1358,1311,1237,1231,1279,1143,1183,1067,1026,
    1000,928,929,894,859,834,860,878,823,822
  };
  
  int [] ycor3 = {
    340,312,276,304,240,219,176,141,140,164,
    66,94,85,85,65,92,90,64,47,71,
    60,99,129,109,151,138,228,269,287,300,
    398,400,414,440,444,429,424,412,412,428,
    423,411,421,434,445,446,454,422,444,427,
    444,431,421,421,433,445,455,420,420,437,
    448,428,423,447,444,427,445,445,428,458,
    646,645,635,628,655,658,658,660,660,639,
    659,658,633,627,603,606,631,658,534,480
  };
  

  int xcounter = 0;
  int ycounter = 0;

  // array list of point objects
  ArrayList<PathPlannerPoint> ppp;
  ArrayList<PersonPoint>      pp;

  PathPlanner() {
    ppp = new ArrayList<PathPlannerPoint>();// create new array list
    pp = new ArrayList<PersonPoint>();// create new array list
    if (loadpreset) {// if load preset is true
      loadPreset(); // fil arraylist
      listcreated = true;
      listfull = true;
    }
    
    for( int i = 0; i < xcor1.length; i++){ pp.add(new PersonPoint(xcor1[i], ycor1[i], i));}
    for( int i = 0; i < xcor2.length; i++){ pp.add(new PersonPoint(xcor2[i], ycor2[i], i));}
    for( int i = 0; i < xcor3.length; i++){ pp.add(new PersonPoint(xcor3[i], ycor3[i], i));}
  }

  void run() {
    
    if(createpersonlist){
    
    //personupdate();
    persondisplay();
    }
    
    if (startpathplanner) { 
      update();
      displayArray();
      findNearestCheckpoint();
      checkCheckPointSwitch();
      if (autopilot) {
        calculateForce(focusCheckPoint);
      }
    }
  }

  void update() {
    if (mousePressed && listfull == false  && mousePres == false && (mouseButton == RIGHT)) {
      ppp.add(new PathPlannerPoint(mouseX, mouseY, identity));
      //pp.add(new PersonPoint(mouseX, mouseY, identity));
      identity++;
      xcor[xcounter] = mouseX;
      ycor[ycounter] = mouseY;
      xcounter++;
      ycounter++;
      print("{");
      for (int i = 0; i < 40; i++) {
        print(xcor[i] + ",");
      }
      println("}");
      print("{");
      for (int i = 0; i < 40; i++) {
        print(ycor[i] + ",");
      }
      println("}");

      listcreated = true;
      mousePres = true;
    }

    if (ppp.size() > pointnumbers) {
      listfull = true;
    }
  }
  
  void personupdate() {
    if (mousePressed && personlistfull == false  && mousePres == false && (mouseButton == RIGHT)) {
      pp.add(new PersonPoint(mouseX, mouseY, identity));
      println("run");
      identity++;
      xcor1[xcounter] = mouseX;
      ycor1[ycounter] = mouseY;
      xcounter++;
      ycounter++;
      print("{");
      for (int i = 0; i < xcor1.length; i++) {
        print(xcor1[i] + ",");
      }
      println("}");
      print("{");
      for (int i = 0; i < ycor1.length; i++) {
        print(ycor1[i] + ",");
      }
      println("}");

      personlistcreated = true;
      mousePres = true;
    }

    if (pp.size() > xcor1.length) {
      personlistfull = true;
    }
  }
  
  void persondisplay(){
   if(testState == 1){
      for ( int i = 0; i < xcor1.length; i++) {
      PersonPoint p = pp.get(i);
      p.display();
     }
   }
   
   if(testState == 2){
     for ( int i = 0; i < xcor2.length + xcor1.length; i++) {
      PersonPoint p = pp.get(i);
      p.display();
     }
   }
   
   if(testState == 3){
     for ( int i = 0; i < xcor3.length + xcor2.length + xcor1.length; i++) {
      PersonPoint p = pp.get(i);
      p.display();
     }
   
   }
   
   
  }

  void displayArray() {
    for ( int i = 0; i < ppp.size(); i++) {
      PathPlannerPoint p = ppp.get(i);
      PVector LocationFormerPoint = new PVector();
      PVector locationPoint = p.getLocation();

      if (i == 0) {
        PathPlannerPoint f = ppp.get(ppp.size()-1);
        LocationFormerPoint = f.getLocation();
      } else {
        PathPlannerPoint f = ppp.get(i-1);
        LocationFormerPoint = f.getLocation();
      }

      pushMatrix();
      strokeWeight(1);
      line(locationPoint.x, locationPoint.y, LocationFormerPoint.x, LocationFormerPoint.y);
      translate(0, 0, -4);
      strokeWeight(4);
      stroke(0, 200, 200);
      line(locationPoint.x, locationPoint.y, LocationFormerPoint.x, LocationFormerPoint.y);
      stroke(255);
      strokeWeight(1);
      popMatrix();


      p.display();
    }
  }

  void findNearestCheckpoint() {
    if ( autonomousdrive == true &&
      find_closest_checkpoint == false &&
      autonomous_driving_running == false) {

      PVector carloc = car.getLocation().copy();
      int idx_closest = 0;
      float closest_dist = gridHeight;
      for ( int i = 0; i < ppp.size(); i++) {
        PathPlannerPoint p = ppp.get(i);
        PVector pointloc = p.getLocation().copy();
        float d = PVector.dist(carloc, pointloc);
        if (d < closest_dist) {
          idx_closest = i;
          closest_dist = d;
        }
      }

      //println(idx_closest + " " + closest_dist);
      find_closest_checkpoint = true;
      // always go to the next point
      if (idx_closest < 39) {
        focusCheckPoint = idx_closest + 1;
      }
      autonomous_driving_running = true;
    }
  }

  void checkCheckPointSwitch() {


    if (listcreated == true && 
      car.getDriveStatus() == true &&
      autonomousdrive == true &&
      find_closest_checkpoint == true //&&
      //autonomous_driving_running == false
      ) {


      PVector carloc = car.getLocation().copy();
      PathPlannerPoint p = ppp.get(focusCheckPoint);
      PVector pointloc = p.getLocation().copy();
      float distance = PVector.dist(carloc, pointloc);
      if (distance < 30 ) {
        focusCheckPoint++;
        if (focusCheckPoint >= ppp.size()) {
          focusCheckPoint = 0;
        }
      }
    }
  }

  void calculateForce(int idx_checkpoint) {
    if (listcreated == true && 
      car.getDriveStatus() == true &&
      autonomousdrive == true &&
      find_closest_checkpoint == true //&&
      //autonomous_driving_running == false
      ) {
      PVector carloc = car.getLocation().copy();
      PathPlannerPoint p = ppp.get(idx_checkpoint);
      PVector pointloc = p.getLocation().copy();
      PVector force = pointloc.sub(carloc);

      force.normalize();
      force.setMag(0.01);
      //  carloc.mult(0.1);

      car.applyForce(force);
    }
  }

  void checkmouseMoved() {
    mousePres = false;
  }

  void startAutonomousDriving(boolean status) {
    autonomousdrive = status;
  }

  void resetPathPlanner() {
    autonomousdrive = false;

    find_closest_checkpoint = false;
    autonomous_driving_running = false;
  }

  void loadPreset() {
    for (int i = 0; i<40; i++) {
      ppp.add(new PathPlannerPoint(xcor[i], ycor[i], i));
      //println("add new p" + i);
    }
  }
}