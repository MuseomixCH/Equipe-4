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
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"form.html" ofType:@""]];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString * url = request.URL.absoluteString;
    
    if([url hasPrefix:@"museochoix://"]) {
        NSString *q = request.URL.query;
        
        q = [q substringFromIndex:4];
        
        NSArray * ids = [q componentsSeparatedByString:@","];
        
        [[VDARSDKController sharedInstance] unloadAllNonRootContexts];
        
        for(NSString* _id in ids) {
            [[VDARSDKController sharedInstance] loadContext:_id];
        }
        
        [self performSegueWithIdentifier:@"showMap" sender:self];
        
        return NO;
    }
    
    return YES;
}

@end
