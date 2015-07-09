//
//  ClusteredAnnotation.h
//  ClusteredMapView
//
//  Created by Swechha Prakash on 08/07/15.
//  Copyright (c) 2015 Swechha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ClusteredAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) NSInteger numLocations;
@property (nonatomic, copy) NSString *title;

- (MKAnnotationView *)annotationView;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title numLocations:(NSInteger)numLocations;

@end
