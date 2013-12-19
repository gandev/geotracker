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

- (NSObject*) createFormattedLocation:(CLLocation *)loc {
    NSNumber *altitude = [[NSNumber alloc] initWithDouble:loc.altitude];
    NSNumber *latitude = [[NSNumber alloc] initWithDouble:loc.coordinate.latitude];
    NSNumber *longitude = [[NSNumber alloc] initWithDouble:loc.coordinate.longitude];
    NSNumber *course = [[NSNumber alloc] initWithDouble:loc.course];
    NSNumber *horizontalAccuracy = [[NSNumber alloc] initWithDouble:loc.horizontalAccuracy];
    NSNumber *speed = [[NSNumber alloc] initWithDouble:loc.speed];
    NSNumber *timestamp = [[NSNumber alloc] initWithDouble:loc.timestamp.timeIntervalSince1970];
    NSNumber *verticalAccuracy = [[NSNumber alloc] initWithDouble:loc.verticalAccuracy];
    
    return @{@"altitude": altitude,
             @"coordinate": @{@"latitude": latitude,
                              @"longitude": longitude},
             @"course": course,
             @"horizontalAccuracy": horizontalAccuracy,
             @"speed": speed,
             @"timestamp": timestamp,
             @"verticalAccuracy": verticalAccuracy};
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    location = [locations lastObject];
    
    NSArray *formatted_locations = @[[self createFormattedLocation:location]];
    
    [mc callMethodName:@"addLocation" parameters:formatted_locations responseCallback:^(NSDictionary *response, NSError *error) {
        NSString *message = response[@"result"];
        
        self.currentLocation.text = message;
    }];
    
}

@end
