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
    
    
    int currentIndex;
    NSString * currentID;
}
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.delegate= self;
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)annotationViewDidBecomeEmpty {
    self.webView.hidden=NO;
}

-(void)annotationViewDidPresentAnnotations {
    self.webView.hidden=YES;
}

-(void)loadObject:(NSString *)_id {
    
    NSLog(@"Loading object %@",_id);
    
    VDARContext *context  = [[VDARSDKController sharedInstance] getContext:_id];
    [self objectParser:context];
    
    //Show map
    NSString * file = [[NSBundle mainBundle] pathForResource:@"map.html" ofType:@"" inDirectory:@"web"];
    if(!file) {
        NSLog(@"Error while loading map screen.");
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:file];
 
    
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

-(void)objectParser:(VDARContext*)context {
    NSString *descr = context.contextDescription;
    
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
   }

-(void)modelDetected:(VDARContext *)model {
    [super modelDetected:model];
    
    NSString *html = [NSString stringWithFormat:@"%@.html",screenType];
    NSString * file = [[NSBundle mainBundle] pathForResource:html ofType:@"" inDirectory:@"web"];
    if(!file) {
        NSLog(@"Unable to find HTML file %@",html);
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:file]]];
    
}

-(void)showFinalScreen {
    
}

-(void)modelLost:(VDARContext*)model {
    [super modelLost:model];
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString * url = request.URL.absoluteString;
    
    if([url hasPrefix:@"museochoix://next"]) {
        currentIndex++;
        if(currentIndex<self.allIDs.count) {
            currentID = self.allIDs[currentIndex];
            [self loadObject:currentID];
        } else {
            [self showFinalScreen];
        }
   
        return NO;
    }
    
    return YES;

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if(_floor) {
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"loadFloor('%@')",_floor]];
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"drawDot(%d,%d,'')",coordX,coordY]];
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
