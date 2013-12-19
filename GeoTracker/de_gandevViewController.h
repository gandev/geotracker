//
//  de_gandevViewController.h
//  GeoTracker
//
//  Created by Andreas Gabriel on 18.12.13.
//  Copyright (c) 2013 Andreas Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

#import <ObjectiveDDP/ObjectiveDDP.h>
#import <ObjectiveDDP/MeteorClient.h>


@interface de_gandevViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *location;
    MeteorClient *mc;
    ObjectiveDDP *ddp;
}

@property (nonatomic, strong) IBOutlet UILabel *currentLocation;
@property (nonatomic, strong) IBOutlet UITextField *connectionURL;

- (IBAction)activateTracking:(id)sender;

- (NSObject*)createFormattedLocation:(CLLocation *)loc;

@end
