//
//  MapViewController.m
//  Museochoix
//
//  Created by Mathieu Monney on 08.11.14.
//  Copyright (c) 2014 Vidinoti. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<UIWebViewDelegate> {
    NSString *_floor;
    int coordX,coordY;
    NSString *screenType;
    BOOL isAR;
    NSString * contentType;
    
    NSMutableArray * oldPoints;
    
    int currentIndex;
    NSString * currentID;
    BOOL mapShown;
    
    UIView *targetView;
    UILabel *lblInstruction;
    
    
}
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    oldPoints = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    float statusBar;
    
    if(!UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        statusBar=[UIApplication sharedApplication].statusBarFrame.size.width;
    } else {
        statusBar=[UIApplication sharedApplication].statusBarFrame.size.height;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        float minSize = MIN(self.view.frame.size.width-120,self.view.frame.size.height-120);
        targetView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, minSize, minSize)];
        targetView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        targetView.center=self.view.center;
        UIImageView *targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        targetImgView.image = [UIImage imageNamed:@"target_corner_3"];
        [targetView addSubview:targetImgView];
        
        
        targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(targetView.frame.size.width-40, 0, 40, 40)];
        targetImgView.image = [UIImage imageNamed:@"target_corner_4"];
        [targetView addSubview:targetImgView];
        
        
        targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, targetView.frame.size.height-40, 40, 40)];
        targetImgView.image = [UIImage imageNamed:@"target_corner_2"];
        [targetView addSubview:targetImgView];
        
        
        targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(targetView.frame.size.width-40, targetView.frame.size.height-40, 40, 40)];
        targetImgView.image = [UIImage imageNamed:@"target_corner_1"];
        [targetView addSubview:targetImgView];
        
        
        
        
        targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        targetImgView.image = [UIImage imageNamed:@"camOverlay_iPad"];
        targetImgView.frame=CGRectMake((targetView
                                        .frame.size.width-40-targetImgView.image.size.width)/2, 0, targetImgView.image.size.width, targetImgView.image.size.height);
        
        UIView *overlayView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, targetView
                                                                     .frame.size.width-40, targetImgView.image.size.height+45+10)];
        
        overlayView.center=CGPointMake(targetView.frame.size.width/2, targetView.frame.size.height/2);
        [overlayView addSubview:targetImgView];
        
        lblInstruction = [[UILabel alloc] initWithFrame:CGRectMake(0, targetImgView.frame.origin.y+targetImgView.frame.size.height+10, overlayView
                                                                   .frame.size.width, 45)];
        lblInstruction.textColor=[UIColor whiteColor];
        lblInstruction.backgroundColor=[UIColor clearColor];
        lblInstruction.opaque=NO;
        lblInstruction.font=[UIFont systemFontOfSize:26];
        lblInstruction.textAlignment=NSTextAlignmentCenter;
        lblInstruction.layer.shadowOpacity=0.5;
        lblInstruction.numberOfLines=2;
        [overlayView addSubview:lblInstruction];
        overlayView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [targetView addSubview:overlayView];
        
        [self.view addSubview:targetView];
    } else {
        
        float y = 0;
        
        
        float maxHeight = self.view.frame.size.height-y-20-statusBar;
        float size = MIN(self.view.frame.size.width-40,maxHeight);
        targetView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-size)/2, (self.view.frame.size.height-size)/2-statusBar, size, size)];
        
        
        
        targetView.autoresizingMask=UIViewAutoresizingNone;
        UIImageView *targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        targetView.autoresizingMask=UIViewAutoresizingNone;
        targetImgView.image = [UIImage imageNamed:@"target_corner_3"];
        targetImgView.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [targetView addSubview:targetImgView];
        
        
        targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(targetView.frame.size.width-40, 0, 40, 40)];
        targetImgView.image = [UIImage imageNamed:@"target_corner_4"];
        targetImgView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [targetView addSubview:targetImgView];
        
        
        targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, targetView.frame.size.height-40, 40, 40)];
        targetImgView.image = [UIImage imageNamed:@"target_corner_2"];
        targetImgView.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [targetView addSubview:targetImgView];
        
        
        targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(targetView.frame.size.width-40, targetView.frame.size.height-40, 40, 40)];
        targetImgView.image = [UIImage imageNamed:@"target_corner_1"];
        targetImgView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [targetView addSubview:targetImgView];
        
        
        
        targetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        targetImgView.image = [UIImage imageNamed:@"camOverlay_iPhone"];
        targetImgView.frame=CGRectMake((targetView
                                        .frame.size.width-40-targetImgView.image.size.width)/2, 0, targetImgView.image.size.width, targetImgView.image.size.height);
        
        UIView *overlayView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, targetView
                                                                     .frame.size.width-40, targetImgView.image.size.height+45+10)];
        
        overlayView.center=CGPointMake(targetView.frame.size.width/2, targetView.frame.size.height/2);
        [overlayView addSubview:targetImgView];
        
        overlayView.autoresizesSubviews=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayView.contentMode=UIViewContentModeScaleAspectFit;
        
        lblInstruction = [[UILabel alloc] initWithFrame:CGRectMake(0, targetImgView.frame.origin.y+targetImgView.frame.size.height+10, overlayView
                                                                   .frame.size.width, 45)];
        lblInstruction.numberOfLines=0;
        lblInstruction.textColor=[UIColor whiteColor];
        lblInstruction.backgroundColor=[UIColor clearColor];
        lblInstruction.opaque=NO;
        lblInstruction.font=[UIFont systemFontOfSize:16];
        lblInstruction.textAlignment=NSTextAlignmentCenter;
        lblInstruction.layer.shadowOpacity=0.5;
        lblInstruction.autoresizesSubviews=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [overlayView addSubview:lblInstruction];
        overlayView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [targetView addSubview:overlayView];
        
        [self.view addSubview:targetView];
    }
    
#if TARGET_IPHONE_SIMULATOR
    btnBlack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btnBlack.frame=CGRectMake(self.view.frame.size.width-10-120,10+statusBar,120,40);
    
    [btnBlack addTarget:self action:@selector(blackFrame:) forControlEvents:UIControlEventTouchUpInside];
    btnBlack.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:btnBlack];
#endif
    

    
    
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.delegate= self;
    [self.view addSubview:self.webView];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    
    float widthScreen,heightScreen,statusBar;
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            widthScreen=self.annotationView.frame.size.width;
            heightScreen=self.annotationView.frame.size.height;
            statusBar=[UIApplication sharedApplication].statusBarFrame.size.height;
        } else {
            widthScreen=self.annotationView.frame.size.height;
            heightScreen=self.annotationView.frame.size.width;
            statusBar=[UIApplication sharedApplication].statusBarFrame.size.width;
        }
    } else {
        if(!UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            widthScreen=self.annotationView.frame.size.width;
            heightScreen=self.annotationView.frame.size.height;
            statusBar=[UIApplication sharedApplication].statusBarFrame.size.width;
        } else {
            widthScreen=self.annotationView.frame.size.height;
            heightScreen=self.annotationView.frame.size.width;
            statusBar=[UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    
    float y = statusBar+10;
    float maxHeight = heightScreen-y-20-statusBar;
    float size = MIN(widthScreen-40,maxHeight);
    [UIView animateWithDuration:duration animations:^{
        if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            
            if(!UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
                targetView.frame=CGRectMake((widthScreen-size)/2, y+(heightScreen-y-size)/2,size,size);
            } else {
                targetView.frame=CGRectMake((widthScreen-size)/2, (heightScreen-size)/2,size,size);
            }
        }
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextscreen {
    currentIndex++;
    if(currentIndex<self.allIDs.count) {
        currentID = self.allIDs[currentIndex];
        [self loadObject:currentID];
    } else {
        [self showFinalScreen];
    }
}

-(void)annotationViewDidBecomeEmpty {
  //  self.webView.hidden=NO;
    targetView.hidden=NO;
    [self nextscreen];
}

-(void)annotationViewDidPresentAnnotations {
  //  self.webView.hidden=YES;
    targetView.hidden=YES;
}

-(void)loadObject:(NSString *)_id {
    
    NSLog(@"Loading object %@",_id);
    
    VDARModel *context  = [[VDARModelManager sharedInstance] modelForRemoteID:_id];
    [self objectParser:context];
    
    //Show map
    NSString * file = [[NSBundle mainBundle] pathForResource:@"map.html" ofType:@"" inDirectory:@"web"];
    if(!file) {
        NSLog(@"Error while loading map screen.");
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:file];
 
    mapShown=YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    if(currentID) {
        currentIndex++;
    }
    currentID = self.allIDs[currentIndex];
    [self loadObject:currentID];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.webView removeFromSuperview];
    [self.view addSubview:self.webView];
    
}

-(void)objectParser:(VDARModel*)context {
    NSString *descr = context.modelDescription;
    
    NSArray * lines = [descr componentsSeparatedByString:@"\n"];
    
    if(lines.count<4) {
        NSLog(@"Invalid description for the museum object %@",context.remoteID);
        return;
    }
    
    //First line is floor
    _floor = lines[0];
    NSString *coordoninate = lines[1];
    NSArray *xy = [coordoninate componentsSeparatedByString:@","];
    
    coordX=coordY=0;
    
    if(xy.count!=2) {
        NSLog(@"Invalid coordinates.");
    }
    
    coordX=[xy[0] integerValue];
    coordY=[xy[1] integerValue];
    
    isAR = [lines[3] boolValue];
    
    screenType = lines[2];
    
    [oldPoints addObject:@[[NSNumber numberWithInt:coordX], [NSNumber numberWithInt:coordY]]];
}

-(void)modelDetected:(VDARModel *)model {
    [super modelDetected:model];
    
    NSString *html = [NSString stringWithFormat:@"%@.html",screenType];
    NSString * file = [[NSBundle mainBundle] pathForResource:html ofType:@"" inDirectory:@"web"];
    if(!file) {
        NSLog(@"Unable to find HTML file %@",html);
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:file]]];
    mapShown = NO;
    
}

-(void)showFinalScreen {
    
}

-(void)modelLost:(VDARModel*)model {
    [super modelLost:model];
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString * url = request.URL.absoluteString;
    
    if([url hasPrefix:@"museochoix://next"]) {
        [self nextscreen];
   
        return NO;
    }
    
    return YES;

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if(_floor && mapShown) {
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"loadFloor('%@')",_floor]];
        
        /* all points */
        int nb=0;
        for(NSArray * arr in oldPoints) {
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"drawDot(%@,%@,'%@')",arr[0],arr[1],nb==oldPoints.count-1 ? @"active":@""]];
            nb++;
        }
        
        
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"showButton('%@')",isAR ? @"photo" : @"beacon"]];
    }
 }

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
