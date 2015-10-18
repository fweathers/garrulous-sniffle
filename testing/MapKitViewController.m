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
@property (weak, nonatomic) IBOutlet UIButton *pinLocationButton;


@end

@implementation MapKitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // border radius
    [self.mapView.layer setCornerRadius:30.0f];
    

    
    // border
    [self.mapView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.mapView.layer setBorderWidth:1.5f];
    
    [self.pinLocationButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.pinLocationButton.layer setBorderWidth:1.5f];
    
    // drop shadow
    [self.mapView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.mapView.layer setShadowOpacity:0.8];
    [self.mapView.layer setShadowRadius:3.0];
    [self.mapView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    [self.pinLocationButton.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.pinLocationButton.layer setShadowOpacity:0.8];
    [self.pinLocationButton.layer setShadowRadius:3.0];
    [self.pinLocationButton.layer setShadowOffset:CGSizeMake(2.0, 2.0)];

    
    
//    self.placesVisited = [[NSMutableArray alloc]init];
    
    self.placesVisited = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"destinations"]];
    
    
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
    
    [self reloadPins];

}

- (void)reloadPins
{
    //reload pins
    
    if (self.placesVisited.count != 0)
    {
        
        for (int i = 0; i < self.placesVisited.count; i ++)
        {
            NSLog(@"%lu", self.placesVisited.count);
            MKPointAnnotation *mapPin = [[MKPointAnnotation alloc]init];
            mapPin.title = @"The Location";
            //    mapPin.subtitle = @"Sub-title";
            
            NSDictionary *coordinates = [self.placesVisited objectAtIndex:i];
            mapPin.coordinate = CLLocationCoordinate2DMake([[coordinates objectForKey:@"lat"] doubleValue],[[coordinates objectForKey:@"lng"] doubleValue]);
            [self.mapView addAnnotation:mapPin];
            
            NSLog(@"reprint pins");

        }
    }
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
    
    [[NSUserDefaults standardUserDefaults] setObject:self.placesVisited forKey:@"destinations"];
    NSLog(@"Data Saved");
    

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

@end
