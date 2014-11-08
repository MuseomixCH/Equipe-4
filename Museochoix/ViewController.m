//
//  ViewController.m
//  Museochoix
//
//  Created by Mathieu Monney on 08.11.14.
//  Copyright (c) 2014 Vidinoti. All rights reserved.
//

#import "ViewController.h"
#import <VDARSDK/VDARSDK.h>

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Synchro
    [[VDARRemoteController sharedInstance] syncRemoteModelsAsynchronouslyWithPriors:@[ [VDARTagPrior tagWithName:@"museomix"] ] withCompletionBlock:^(id result, NSError *err) {
        NSLog(@"Synced %lu models",((NSArray*)result).count);
    }];
    
    //[self parseURL:[NSURL URLWithString:@"museomix://loadContexts?ids=bja43whspny60x2,knliyajr8y6x0yt,xrhnpx6pfdlquob"]];
    
    NSString * file = [[NSBundle mainBundle] pathForResource:@"form.html" ofType:@"" inDirectory:@"web"];
    if(!file) {
        NSLog(@"Error while loading intro screen.");
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:file];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)parseURL:(NSURL*)url {
    NSString *q = url.query;
    
    q = [q substringFromIndex:4];
    
    NSArray * ids = [q componentsSeparatedByString:@","];
    
  //  [[VDARSDKController sharedInstance] unloadAllNonRootContexts];
    
    for(NSString* _id in ids) {
      //  [[VDARSDKController sharedInstance] loadContext:_id];
    }
    
    [self performSegueWithIdentifier:@"showMap" sender:self];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString * url = request.URL.absoluteString;
    
    if([url hasPrefix:@"museochoix://"]) {
                return NO;
    }
    
    return YES;
}

@end
