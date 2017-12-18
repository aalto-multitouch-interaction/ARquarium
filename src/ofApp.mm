#include "ofApp.h"
#include "ofxCv.h"
#include "ofBitmapFont.h"

using namespace cv;
using namespace ofxCv;

void drawMarker(float size, const ofColor & color){
    //ofDrawAxis(size);
    ofPushMatrix();
    // move up from the center by size*.5
    // to draw a box centered at that point
    ofTranslate(0,size*0.5,0);
    ofFill();
    ofSetColor(color,50);
    ofDrawBox(size);
    ofNoFill();
    ofSetColor(color);
    ofDrawBox(size);
    ofPopMatrix();
}

void ofApp::drawTankTest(float size, const ofColor & color){
    ofPushMatrix();
    ofTranslate(.2, 0,0);
    ofFill();
    ofSetColor(color, 10);
    ofScale(1.25, 0.5);
    water.begin();
    waterLight.enable();
    ofDrawBox(size);
    waterLight.disable();
    water.end();
    
    ofSetColor(ofColor::gray, 60);
    ofScale(1,1.1);
    ofTranslate(0,0.01,0);
    glassLight.enable();
    ofDrawBox(size);
    glassLight.disable();
    ofNoFill();
    ofSetColor(ofColor::black, 100);
    ofSetLineWidth(2);
    glassLight.enable();
    ofDrawBox(size);
    glassLight.disable();
    //ofDrawBox(size);
    ofPopMatrix();
}

//--------------------------------------------------------------
void ofApp::setup(){
    width = ofGetWindowWidth();
    height = ofGetWindowHeight();
    font.load("Avenir.ttc", 12);
    
    string boardName = "boardConfiguration.yml";
    ofSetVerticalSync(true);
    
    ofSetOrientation(OFXIOS_ORIENTATION_PORTRAIT);
    
    grabber.setup(960, 540, OF_PIXELS_BGRA);
    
    video = &grabber;
    aruco.setup("intrinsics.int", video->getWidth(), video->getHeight(), boardName);
    aruco.getBoardImage(board.getPixels());
    board.update();
    
    showMarkers = true;
    showBoard = false;
    showBoardImage = false;
    
    ofEnableAlphaBlending();
    ofEnableLighting();
    
    myBox.set(100);
    xAq = yAq = -20;
    tankWidth = tankLength = 0;
    tankSize = 0;
    
    sizer = 350;
    
    //LIGHTING EFFECTS
    waterLight.setDiffuseColor(ofColor(76, 219, 255));
    waterLight.setDirectional();
    
    roomLight.setAmbientColor(ofColor(255,255,255));
    roomLight.setDirectional();
    
    glassLight.setPointLight();
    glassLight.setSpecularColor(ofColor::white);
    
    //MATERIAL EFFECTS
    water.setEmissiveColor(ofColor(76, 219, 255));

    
}

//--------------------------------------------------------------
void ofApp::update(){
    
    
    video->update();
    if(video->isFrameNew()){
        aruco.detectBoards(video->getPixels());
    }
    
    markerCenter.x = width + 10;
    markerCenter.y = height + 10;
    doesContain = false;
    
}

//--------------------------------------------------------------
void ofApp::draw(){	
    
    roomLight.enable();

    ofSetColor(255);
    video->draw(0,0);
    
    
    //ofEnableDepthTest();
    //ofEnableLighting();
    
    if(showMarkers){
        
        cornerMarkers.clear();
        xAq= -20;
        yAq= -20;
        
        
        for(int i=0;i<aruco.getNumMarkers();i++){
            aruco.begin(i);
            markers = aruco.getMarkers();
            
            //drawMarker(0.05,ofColor::blue);
            
            markerArea = markers[i].getArea();
            currentMarker = markers[i].idMarker;
            
            theMarker = markers[0].getArea();
            
            //cout << currentMarker << endl;
            
            markerCenter = markers[i].getCenter();
            
            
            cornerMarkers.push_back(markerCenter);
            
            aruco.end();
        }
    }
    
    //2 MARKER BOX
    //This finds the centerpoint between the two markers
    
    //draw red circle at center of the four
    
    
    if (cornerMarkers.size() == 2) {
        //cout << "EXACTLY 2" << endl;
        
        
        for (int j = 0;j<cornerMarkers.size();j++) {

            xAq = ((cornerMarkers[0].x + cornerMarkers[1].x)/2);
            yAq = ((cornerMarkers[0].y + cornerMarkers[1].y)/2);
            
        }
        
        tankWidth = abs(cornerMarkers[0].x - cornerMarkers[1].x);
        tankLength = abs(cornerMarkers[1].y - cornerMarkers[0].y);
        
        float distOfMarkers =(ofDist(cornerMarkers[0].x, cornerMarkers[0].y, cornerMarkers[1].x, cornerMarkers[1].y));
        tankSize = distOfMarkers/sizer;
        
        cout << "distOfMarkers: " << distOfMarkers << endl;
        cout << "Tank Size: " << tankSize << endl;
    
        aruco.begin(0);
        roomLight.disable();
        waterLight.enable();
        
        drawTankTest(tankSize, ofColor::deepSkyBlue);
        
        waterLight.disable();
        roomLight.enable();
        aruco.end();
        
        
    }
    
    if(showBoard && aruco.getBoardProbability()>0.03){
        for(int i=0;i<aruco.getNumBoards();i++){
            aruco.beginBoard(i);
            drawMarker(.5,ofColor::blue);
            aruco.end();
        }
    }
    
 
    // DEBUG
//    ofFill();
//    ofSetColor(ofColor::red);
//    ofDrawBitmapString("markers detected: " + ofToString(aruco.getNumMarkers()),20,20);
//    ofDrawBitmapString("sizer: " + ofToString(sizer), 20,40 );
    
    roomLight.disable();
    
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}



//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    if(touch.y < height/2){
        sizer += 10;
        }
    else if(touch.y > height/2) {
        sizer -= 10;
    }
}



//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}












































































































































