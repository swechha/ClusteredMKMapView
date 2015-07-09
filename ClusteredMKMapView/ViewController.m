//
//  ViewController.m
//  ClusteredMKMapView
//
//  Created by Swechha Prakash on 09/07/15.
//  Copyright (c) 2015 Swechha. All rights reserved.
//

#import "ViewController.h"
#import "ClusteredMKMapView.h"
#import "ClusteredAnnotation.h"

@interface ViewController () <MKMapViewDelegate>

@property (nonatomic, strong) ClusteredMKMapView *mapView;
@property (nonatomic, strong) NSArray *coordinates; //some dummy coordinates
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.locationManager = [[CLLocationManager alloc] init];
	if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
		[self.locationManager requestWhenInUseAuthorization];
	}
	
	self.mapView = [[ClusteredMKMapView alloc] initWithFrame:self.view.bounds];
	self.coordinates = @[
						 @[@"19.137203", @"72.83230700000001"],
						 @[@"19.137126000000016", @"72.83268199999998"],
						 @[@"19.137546", @"72.831555"],
						 @[@"19.136117", @"72.833337"],
						 @[@"19.138028", @"72.832245"],
						 @[@"19.136837", @"72.829297"],
						 @[@"19.136715", @"72.829248"],
						 @[@"19.136325", @"72.82765999999992"],
						 @[@"19.1326357", @"72.8338119"],
						 @[@"19.140791181381744", @"72.83193155819708"],
						 @[@"19.141046", @"72.830942"],
						 @[@"19.141129", @"72.831033"],
						 @[@"19.141134", @"72.830995"],
						 @[@"19.141133", @"72.83088099999998"],
						 @[@"19.141137", @"72.830898"],
						 @[@"19.141163", @"72.83099"],
						 @[@"19.141188", @"72.830941"],
						 @[@"19.141194", @"72.830792"],
						 @[@"19.141213", @"72.830882"],
						 @[@"19.141264", @"72.830874"],
						 @[@"19.141268", @"72.830896"],
						 @[@"19.14126", @"72.830813"],
						 @[@"19.141279", @"72.830821"],
						 @[@"19.141317", @"72.83109999999999"],
						 @[@"19.1315126", @"72.8334541"],
						 @[@"19.1413", @"72.830787"],
						 @[@"19.141321", @"72.830833"],
						 @[@"19.141324", @"72.830807"],
						 @[@"19.141324", @"72.830807"],
						 @[@"19.141377", @"72.830933"]
						 ];
	[self setupMapView];
}

- (void)setupMapView
{
	CLLocationCoordinate2D currentCoordinates = CLLocationCoordinate2DMake(19.1326357, 72.8338119);
	MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.02);
	MKCoordinateRegion region = MKCoordinateRegionMake(currentCoordinates, span);
	[self.mapView setRegion:region];
	self.mapView.showsUserLocation = YES;
	[self.view addSubview:self.mapView];
	
	[self addAnnotations];
	self.mapView.delegate = self;
}

- (void)addAnnotations
{
	for (NSArray *coordinate in self.coordinates) {
		CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake([coordinate[0] floatValue], [coordinate[1] floatValue]);
		ClusteredAnnotation *annotation = [[ClusteredAnnotation alloc] initWithCoordinate:locationCoordinate title:@"1"];
		[self.mapView addAnnotation:annotation];
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	if (annotation == mapView.userLocation) {
		return nil;
	}
	
	MKAnnotationView *annotationView = [(ClusteredAnnotation *)annotation annotationView];
	return annotationView;
}

@end
