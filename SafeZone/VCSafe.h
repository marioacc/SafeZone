//
//  VCSafe.h
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <sqlite3.h>

@interface VCSafe : UIViewController <MKMapViewDelegate>{
    
    MKMapView *mapView;
    
    
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
