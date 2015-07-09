//
//  ClusteredMKMapView.m
//  ClusteredMapView
//
//  Created by Swechha Prakash on 08/07/15.
//  Copyright (c) 2015 Swechha. All rights reserved.
//

#import "ClusteredMKMapView.h"
#import "ClusteredAnnotation.h"

@interface ClusteredMKMapView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) MKMapView *originalMapView;

@end

@implementation ClusteredMKMapView

- (id)init
{
	self = [super init];
	if (self) {
		self.originalMapView = [[MKMapView alloc] init];
		[self addGestureRecognizers];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.originalMapView = [[MKMapView alloc] init];
		[self addGestureRecognizers];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.originalMapView = [[MKMapView alloc] initWithCoder:aDecoder];
		[self addGestureRecognizers];
	}
	return self;
}

- (void)addGestureRecognizers
{
	UIPinchGestureRecognizer *pinchRec = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didZoomMap:)];
	[pinchRec setDelegate:self];
	[self addGestureRecognizer:pinchRec];
	
	UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didZoomMap:)];
	tapRec.numberOfTapsRequired = 2;
	[tapRec setDelegate:self];
	[self addGestureRecognizer:tapRec];
}

#pragma mark - Add/remove annotations

- (void)addAnnotation:(id<MKAnnotation>)annotation
{
	[super addAnnotation:annotation];
	[self.originalMapView addAnnotation:annotation];
	[self divideMapIntoRects];
}

- (void)addAnnotations:(NSArray *)annotations
{
	[super addAnnotations:annotations];
	[self.originalMapView addAnnotations:annotations];
	[self divideMapIntoRects];
}

- (void)removeAnnotation:(id<MKAnnotation>)annotation
{
	[super removeAnnotation:annotation];
	[self.originalMapView removeAnnotation:annotation];
}

- (void)removeAnnotations:(NSArray *)annotations
{
	[super removeAnnotations:annotations];
	[self.originalMapView removeAnnotations:annotations];
}

- (void)destroyAnnotation:(id<MKAnnotation>)annotation
{
	[super removeAnnotation:annotation];
}

- (void)createClusteredAnnotation:(id<MKAnnotation>)annotation
{
	[super addAnnotation:annotation];
}

- (void)destroyAllAnnotations
{
	NSArray *annotations = self.annotations;
	[super removeAnnotations:annotations];
}

#pragma mark - On zoom

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}

- (void)didZoomMap:(UIGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
		[self divideMapIntoRects];
	}
}

#pragma mark - divide map view into regions

- (void)divideMapIntoRects
{
	double origin_x = self.visibleMapRect.origin.x;
	double origin_y = self.visibleMapRect.origin.y;
	
	double rect_width = MKMapRectGetWidth(self.visibleMapRect)/6.0;
	double rect_height = rect_width;
	
	[self destroyAllAnnotations];
	while (origin_y < self.visibleMapRect.origin.y+self.visibleMapRect.size.height) {
		while (origin_x < self.visibleMapRect.origin.x+self.visibleMapRect.size.width) {
			MKMapRect mapRect = MKMapRectMake(origin_x, origin_y, rect_width, rect_height);
			NSSet *annotations = [self.originalMapView annotationsInMapRect:mapRect];
			
			[self replaceAnnotationsWithCluster:[annotations allObjects]];
			
			origin_x += rect_width;
		}
		origin_y += rect_height;
		origin_x = self.visibleMapRect.origin.x;
	}
}

- (void)replaceAnnotationsWithCluster:(NSArray *)annotations
{
	NSMutableArray *mAnnotations = [[NSMutableArray alloc] initWithArray:annotations];
	if (mAnnotations.count == 1) {
		[self createClusteredAnnotation:mAnnotations[0]];
		//do nothing
	} else {
		for (id<MKAnnotation> annotation in mAnnotations) {
			if ([annotation isKindOfClass:[MKUserLocation class]]) {
				[mAnnotations removeObject:annotation];
				break;
			}
		}
		if (mAnnotations.count > 1) {
			ClusteredAnnotation *lastAnnotation;
			float latitude=0.0, longitude=0.0;
			for (id<MKAnnotation> annotation in mAnnotations) {
				lastAnnotation = annotation;
				latitude = latitude+lastAnnotation.coordinate.latitude;
				longitude = longitude+lastAnnotation.coordinate.longitude;
				[self destroyAnnotation:annotation];
			}
			
			latitude = latitude/mAnnotations.count;
			longitude = longitude/mAnnotations.count;
			CLLocationCoordinate2D newCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
			
			ClusteredAnnotation *newAnnotation = [[ClusteredAnnotation alloc] initWithCoordinate:newCoordinate title:nil numLocations:mAnnotations.count];
			[self createClusteredAnnotation:newAnnotation];
		}
	}
}

@end
