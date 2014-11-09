//
//  AppDelegate.m
//  Museochoix
//
//  Created by Mathieu Monney on 08.11.14.
//  Copyright (c) 2014 Vidinoti. All rights reserved.
//

#import "AppDelegate.h"
#import <VDARSDK/VDARSDK.h>
#import "MyCameraImageSource.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *modelDir=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"models"];
    
    unsigned long featureRight= kVDARRightInsertNewModel | kVDARRightRemoteModelFetch | kVDARRightSendVisualClickNotifications | kVDARRightImageRecognition | kVDARRightAnnotationJSRendering;
    if(![VDARModelManager startManager:modelDir withFeatureRights:featureRight andLicenseKey:@"698s5w7llqmk7qewoj83"]) {
        if(![VDARModelManager sharedInstance]) {
            NSLog(@"Error while loading the model manager. Fatal.");
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Application error",@"") message:NSLocalizedString(@"Unable to launch augmented reality system.",@"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"Button for clausing error alert box") otherButtonTitles:nil];
            [alertView show];
        }
    }
    
    [VDARModelManager sharedInstance].enableCodesRecognition=YES;
    
    MyCameraImageSource *cameraSource=[[MyCameraImageSource alloc] init];
    
    [VDARModelManager sharedInstance].imageSender=cameraSource;

    
    [[VDARModelManager sharedInstance] application:application didReceiveRemoteNotification:launchOptions];

    
    // Override point for customization after application launch.
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    [[VDARModelManager sharedInstance] saveModels];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
