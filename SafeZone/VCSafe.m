//
//  VCSafe.m
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import "VCSafe.h"
#import "FMDatabase.h"

@interface VCSafe ()

@end


@implementation VCSafe

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mapView.delegate = self;
    self.getAllData;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) mapView:(MKMapView *) mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    
}


- (void)getAllData {
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"safe_zones.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlSelectQuery = @"SELECT * FROM zones";
    
    // Query result
    FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
    while([resultsWithNameLocation next]) {
        NSString *strID = [NSString stringWithFormat:@"%d",[resultsWithNameLocation intForColumn:@"zone_id"]];
        NSString *strName = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"location_name"]];
        NSString *strdes = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"description"]];
        NSString *strlat = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"latitude"]];
        NSString *strlon = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"longitude"]];

        CLLocationCoordinate2D annotationCoord;
        
        annotationCoord.latitude = [strlat doubleValue];
        annotationCoord.longitude =[strlon doubleValue];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.Title = strName;
        annotationPoint.subtitle = strdes;
        [mapView addAnnotation:annotationPoint];
        
        [self performSelector:@selector(zoomInToMyLocation)
                   withObject:nil
                   afterDelay:1];
        
        // loading your data into the array, dictionaries.
        NSLog(@"ID = %@, Name = %@, Location = %@, lat = %@, lon= %@",strID, strName, strdes,strlat,strlon);
    }
    [database close];
}

-(void)zoomInToMyLocation
{
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = 37.733446 ;
    region.center.longitude = -122.455896;
    region.span.longitudeDelta = 0.15f;
    region.span.latitudeDelta = 0.15f;
    [mapView setRegion:region animated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
