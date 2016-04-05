# ClusteredMKMapView

ClusteredMKMapView is a special type of map view, that clusters all the annotations that are close together. On zooming in/out on map, clustering or de-clustering of annotaions is triggered.

## Usage

ClusteredMKMapView can be created and initialized just like an MKMapView

e.g. `ClusteredMKMapView *mapView = [[ClusteredMKMapView alloc] initWithFrame:self.view.bounds];`

ClusteredMKMapView uses ClusteredAnnotation objects for showing annotations.

Annotations can be initialized and added to map view as:

`ClusteredAnnotation *annotation = [[ClusteredAnnotation alloc] initWithCoordinate:<coordinate> title:@"title"];`

`[mapView addAnnotation:annotation]`

