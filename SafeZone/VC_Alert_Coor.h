//
//  VC_Alert_Coor.h
//  SafeZone
//
//  Created by moviles on 2/20/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKPointAnnotation.h>

@interface VC_Alert_Coor : UIViewController{
    NSString *latitude;
    NSString *longitude;
}
@property NSString * latitude;
@property NSString * longitude;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
