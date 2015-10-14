//
//  MapKitViewController.m
//  testing
//
//  Created by Felicia Weathers on 10/11/15.
//  Copyright © 2015 Felicia Weathers. All rights reserved.
//

#import "MapKitViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface MapKitViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSMutableArray *placesVisited;


@end

@implementation MapKitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.placesVisited = [[NSMutableArray alloc]init];
    
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(40.7, -74);
        MKCoordinateSpan span = MKCoordinateSpanMake(0.8, 0.8);
        [self.mapView setRegion:MKCoordinateRegionMake(center, span)];
    
    //create location manager
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    }

- (IBAction)pinLocationButtonTapped:(id)sender
{
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc]init];
    mapPin.title = @"The Location";
    //    mapPin.subtitle = @"Sub-title";
    mapPin.coordinate = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    [self.mapView addAnnotation:mapPin];
    
    [self.placesVisited addObject:@{@"lat":[NSNumber numberWithDouble:mapPin.coordinate.latitude], @"lng":[NSNumber numberWithDouble:mapPin.coordinate.longitude ]}];
    
    NSLog(@"Pin Location");
    
    //facebook share button
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL
                          URLWithString:@"https://www.facebook.com/FacebookDevelopers"];
    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init];
    shareButton.shareContent = content;
    shareButton.center = self.view.center;
    [self.view addSubview:shareButton];
    

    
}

- (void)locationManager:(CLLocationManager * _Nonnull)manager
     didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations
{
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.8, 0.8);
    [self.mapView setRegion:MKCoordinateRegionMake(center, span)];
    
}

//- (void)addMapAnnotationForLocation: (CLLocation *)currentLocation
//{
//
//    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc]init];
//
////    double lat = [currentLocation[@"location"][@"lat"] doubleValue];
////    double lng = [currentLocation[@"location"][@"lng"] doubleValue];
//
//    // Added array of dictionaries with coordinates
//    //NSDictionary *coordinates = @{ @"lat" : [NSNumber numberWithDouble:lat],
//                                   @"lng" : [NSNumber numberWithDouble:lng]
//                                   };
//    // dictionaries will store each place visited in array
//    [self.placesVisited addObject:coordinates];
//
//    //CLLocationCoordinate2D latLng = CLLocationCoordinate2DMake(lat,lng);
//
//    mapPin.title = @"The Location";
//    mapPin.subtitle = @"Sub-title";
//     [self.mapView addAnnotation:mapPin];
//
//
//    mapPin.coordinate = latLng;
////
////    [self.mapView addAnnotation:mapPin];
////    NSLog(@"pin added");
//
//
//}

@end
