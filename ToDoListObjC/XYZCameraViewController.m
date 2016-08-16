//
//  XYZCameraViewController.m
//  multiCamera
//
//  Created by mattw/Users/mattwd7/Documents/Developer/iOS Dev/multiCamera/ToDoListObjC/XYZCameraViewController.md7 on 7/26/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import "XYZCameraViewController.h"
#import "XYZPhoto.h"
#import "XYZToDoListTableViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface XYZCameraViewController ()

@end

@implementation XYZCameraViewController{
	BOOL sessionStarted;
}
AVCaptureSession *session;
AVCaptureStillImageOutput *stillImageOutput;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Prevent clashing camera sessions
		sessionStarted = NO;
    }
    return self;
}

- (BOOL)prefersStatusBarHidden{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
	if ( !sessionStarted ){
		session = [[AVCaptureSession alloc] init];
		[session setSessionPreset:AVCaptureSessionPresetPhoto];
		
		AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
		NSError *error;
		AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
		
		if([session canAddInput:deviceInput]){
			[session addInput:deviceInput];
		}
		
		AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
		[previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
		CALayer *rootLayer = [[self view] layer];
		[rootLayer setMasksToBounds:YES];
		CGRect frame = self.cameraView.frame;
		
		[previewLayer setFrame:frame];
		
		[rootLayer insertSublayer:previewLayer atIndex:0];
		
		stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
		NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
		[stillImageOutput setOutputSettings:outputSettings];
		
		[session addOutput:stillImageOutput];
		[session startRunning];
		sessionStarted = YES;
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.photoData = [[NSMutableArray alloc] init];
	NSString *defects = [NSString stringWithFormat:@"DEFECTS: %@", self.labelString];
	self.cameraLabel.text = defects;
	
	self.whiteFlash = [[UIView alloc] initWithFrame:self.view.frame];
    self.whiteFlash.layer.opacity = 0.0f;
    self.whiteFlash.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    [self.view addSubview:self.whiteFlash];

}

- (IBAction)cancelCamera:(id)sender {
	
	[self.rootVC.photos addObjectsFromArray:self.photoData];
	[self dismissViewControllerAnimated:YES completion:NULL];
	
}

- (IBAction)takePhoto:(id)sender {
	[self flashScreen];
	AVCaptureConnection *videoConnection = nil;
	
	for (AVCaptureConnection *connection in stillImageOutput.connections){
		for (AVCaptureInputPort *port in [connection inputPorts]){
			if ( [[port mediaType] isEqual:AVMediaTypeVideo]){
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection){
			break;
		}
	}
	
	[stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
		if (imageDataSampleBuffer != NULL){
			NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation: imageDataSampleBuffer];
			UIImage *image = [UIImage imageWithData:imageData];
			XYZPhoto *photo = [[XYZPhoto alloc] init];
			photo.img = image;
			photo.associatedItems = self.labelString;
			[self.photoData addObject:photo];
			//[self showImagePreview:image];
		}
		XYZPhoto *previewImage = [self.photoData lastObject];
		[self showImagePreview:previewImage.img];
	}];
	
}

-(void)flashScreen {
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    NSArray *animationValues = @[ @0.8f, @0.0f ];
    NSArray *animationTimes = @[ @0.3f, @1.0f ];
    id timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    NSArray *animationTimingFunctions = @[ timingFunction, timingFunction ];
    [opacityAnimation setValues:animationValues];
    [opacityAnimation setKeyTimes:animationTimes];
    [opacityAnimation setTimingFunctions:animationTimingFunctions];
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = YES;
    opacityAnimation.duration = 0.4;
	
    [self.whiteFlash.layer addAnimation:opacityAnimation forKey:@"animation"];
}

- (void)showImagePreview:(UIImage *)image{
	XYZImagePreview *imgP = [[XYZImagePreview alloc] init];
	imgP.previewPhoto = image;
	imgP.cameraVC = self;
	[self presentViewController:imgP animated:NO completion:NULL];
	
}

@end
