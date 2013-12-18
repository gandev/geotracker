//
//  de_gandevViewController.m
//  GeoTracker
//
//  Created by Andreas Gabriel on 18.12.13.
//  Copyright (c) 2013 Andreas Gabriel. All rights reserved.
//

#import "de_gandevViewController.h"

@interface de_gandevViewController ()

@end

@implementation de_gandevViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)activateTracking:(id)sender
{
    NSString *url = self.connectionURL.text;
    
    mc = [[MeteorClient alloc] init];
    ddp = [[ObjectiveDDP alloc] initWithURLString:url delegate:mc];
    mc.ddp = ddp;
    
    [ddp connectWebSocket];
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    location = [locations lastObject];
    self.currentLocation.text = location.description;
    
    NSNumber *altitude = [[NSNumber alloc] initWithDouble:location.altitude];
    
    NSArray *parameters = @[@{@"description": location.description,
                              @"altitude": altitude}];
    
    [mc callMethodName:@"addLocation" parameters:parameters responseCallback:^(NSDictionary *response, NSError *error) {
//        NSString *message = response[@"result"];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Meteor Todos"
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"Great"
//                                              otherButtonTitles:nil];
//        [alert show];
    }];
    
}

@end
