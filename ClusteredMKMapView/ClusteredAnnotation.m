//
//  ClusteredAnnotation.m
//  ClusteredMapView
//
//  Created by Swechha Prakash on 08/07/15.
//  Copyright (c) 2015 Swechha. All rights reserved.
//

#import "ClusteredAnnotation.h"

#define map_locaiton_annotation_id @"location_resuse_id"

@implementation ClusteredAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title
{
	self = [super init];
	if (self) {
		self.numLocations = 1;
		self.title = title;
		self.coordinate = coordinate;
	}
	return self;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title numLocations:(NSInteger)numLocations
{
	self = [super init];
	if (self) {
		self.numLocations = numLocations;
		self.title = title;
		self.coordinate = coordinate;
	}
	return self;
}

- (MKAnnotationView *)annotationView
{
	MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:map_locaiton_annotation_id];
	annotationView.frame = CGRectMake(0, 0, 30, 30);
	annotationView.enabled = YES;
	annotationView.canShowCallout = YES;
	
	UILabel *outletNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.0, 2.0, annotationView.frame.size.width-4.0, annotationView.frame.size.height-4.0)];
	outletNameLabel.numberOfLines = 2;
	outletNameLabel.textColor = [UIColor whiteColor];
	outletNameLabel.backgroundColor = [UIColor blueColor];
	outletNameLabel.font = [UIFont systemFontOfSize:12.0];
	outletNameLabel.textAlignment = NSTextAlignmentCenter;
	if (self.numLocations == 1) {
		outletNameLabel.text = self.title;
	} else {
		outletNameLabel.text = [NSString stringWithFormat:@"%d", (int)self.numLocations];
	}
	outletNameLabel.layer.masksToBounds = YES;
	outletNameLabel.layer.cornerRadius = 4.0;
	[annotationView addSubview:outletNameLabel];
	
	return annotationView;
}

@end
