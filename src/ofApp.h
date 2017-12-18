#pragma once

#include "ofxiOS.h"
#include "ofxAruco.h"
#include "AudioSample.h"

class ofApp : public ofxiOSApp{
	
	public:
        void setup();
        void update();
        void draw();
        void exit();
    
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);
	
        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        int width, height;
        ofTrueTypeFont font;
		
		ofVideoGrabber grabber;

        ofBaseVideoDraws * video;
    
    
        ofxAruco aruco;
        bool useVideo;
        bool showMarkers;
        bool showBoard;
        bool showBoardImage;
        bool doesContain;
        bool play;
        bool first;
        ofImage board;
        ofImage marker;
    
    void drawTankTest(float size, const ofColor & color);
    
        vector<aruco::Marker> markers;
    
        cv::Point2f markerCenter;

        vector <cv::Point2f> cornerMarkers;
    
        float theMarker;
    
        ofBoxPrimitive myBox;
    
        ofLight waterLight;
        ofLight roomLight;
        ofLight glassLight;
    
        ofMaterial water;
        //of3dGraphics theBox;
    
        bool addSound;
        bool doneRecording;
    
    
        int		sampleRate;
        int	initialBufferSize;

        double outputs;
        float * buffer;
    
    
        int volume;
        float volMultiplier;
    
        vector<float> audio;
        int currentMarker;
        float markerArea;
    
    
        vector<AudioSample> samples;
    
    float xAq, yAq;
    float tankWidth;
    float tankLength;
    float tankSize;
    float sizer;


};
