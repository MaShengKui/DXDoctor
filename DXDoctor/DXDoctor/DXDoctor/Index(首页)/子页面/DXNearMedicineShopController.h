//
//  DXNearMedicineShopController.h
//  DXDoctor
//
//  Created by Mask on 15/10/7.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
//引入搜索库
#import <AMapSearchKit/AMapSearchAPI.h>
@interface DXNearMedicineShopController : UIViewController<MAMapViewDelegate, AMapSearchDelegate, CLLocationManagerDelegate>
{

    //地图一般都设置成全局变量
    MAMapView *_mapView;
    //声明搜索变量
    AMapSearchAPI *_search;
    
    CLLocationManager *_locationManager;
    CLLocation *_location;
    UIButton *_listButton;
    
}
@property (nonatomic, strong) NSMutableArray *mapListArray;
@property (nonatomic, strong) UIView *screenView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *buttomView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@end
