# ClusteredMKMapView

ClusteredMKMapView can be created and initialized just like an MKMapView

e.g. `ClusteredMKMapView *mapView = [[ClusteredMKMapView alloc] initWithFrame:self.view.bounds];`

ClusteredMKMapView uses ClusteredAnnotation objects for showing annotations.

Annotations can be initialized and added to map view as:

`ClusteredAnnotation *annotation = [[ClusteredAnnotation alloc] initWithCoordinate:<coordinate> title:@"title"];`
`[mapView addAnnotation:annotation]`

On zooming in/out on map, clustering or de-clustering of annotaions is triggered.
