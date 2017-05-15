//
//  DXNearMedicineShopController.m
//  DXDoctor
//
//  Created by Mask on 15/10/7.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXNearMedicineShopController.h"
#import <CoreLocation/CoreLocation.h>
#import "DXMapListController.h"
#import "DXMapListModel.h"
#import <MapKit/MapKit.h>
@interface DXNearMedicineShopController ()<UITableViewDataSource, UITableViewDelegate>{

    DXMapListModel *mapModel;
}

@end

@implementation DXNearMedicineShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviagtionCustom];
    [self creatMapView];
    [self configMapView];
    self.mapListArray = [[NSMutableArray alloc] init];
    
}
/**
 创建导航栏的右边按钮
 */
- (void)createNaviagtionCustom{
    self.navigationItem.title = @"附近药店";
    _listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _listButton.frame = CGRectMake(0, 0, 30, 30);
    _listButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MapList"]];
    [_listButton addTarget:self action:@selector(showMapList:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:_listButton];
    self.navigationItem.rightBarButtonItem = right;
    
}
//附近药店列表
-(void) showMapList:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        if (self.mapListArray.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"暂无数据" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            self.screenView = [[UIView alloc] initWithFrame:self.view.bounds];
            self.screenView.backgroundColor = [UIColor blackColor];
            self.screenView.alpha = 0.3;
            [self.view addSubview:self.screenView];
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 74, SCREENW-20, SCREENH -100) style:UITableViewStylePlain];
            _tableView.layer.cornerRadius=5;
            [self.view addSubview:_tableView];

            
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
        }
    }else{
    
        [self.screenView removeFromSuperview];
        [self.tableView  removeFromSuperview];
        button.selected= NO;
    }
   
    
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.mapListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"MapListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    DXMapListModel *model = self.mapListArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@   %d米", model.address, model.distance]];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:14.0]
     
                          range:NSMakeRange([model.address length], AttributedStr.length-[model.address length])];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:NSMakeRange([model.address length], AttributedStr.length-[model.address length])];
    
    cell.detailTextLabel.attributedText =AttributedStr ;
//    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    
    return cell;

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return @"药店列表";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DXMapListModel *model = self.mapListArray[indexPath.row];
    mapModel=model;
    [UIView animateWithDuration:1.0 animations:^{
         _mapView.centerCoordinate =  CLLocationCoordinate2DMake(model.latitude, model.longitude);
    }];
    
    [self.screenView removeFromSuperview];
    [self.tableView removeFromSuperview];
    
    self.buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENH-49, SCREENW, 49)];
    self.buttomView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:self.buttomView];
    self.nameLabel =  [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREENW - 20, 20)];
    self.nameLabel.text = model.name;
    [self.buttomView addSubview:self.nameLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, SCREENW - 20, 20)];
    self.addressLabel.text = model.address;
    self.addressLabel.font = [UIFont systemFontOfSize:12];
    self.addressLabel.textColor = [UIColor grayColor];
    [self.buttomView addSubview:self.addressLabel];
    
    _listButton.selected = NO;
    
    UIButton *navBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame=CGRectMake(SCREENW-50, (49-20)*0.5-3, 40, 20);
    [navBtn setTitle:@"导航" forState:UIControlStateNormal];
    navBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [navBtn setTitleColor:[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1] forState:UIControlStateNormal];
    [navBtn addTarget:self action:@selector(startNavigateClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttomView addSubview:navBtn];

    
}

-(void)startNavigateClickAction:(id)sender{
    
    //导航
    CLLocationCoordinate2D to;
    
    to.latitude = mapModel.latitude;
    
    to.longitude = mapModel.longitude;
    
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
    
    toLocation.name = mapModel.name;
    
    [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil] launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil] forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
}

/**
 创建地图
 */
- (void)creatMapView{
    
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    //4.设置代理
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    //设置代理
    _locationManager.delegate=self;
    //设置定位精度
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //定位频率,每隔多少米定位一次
    CLLocationDistance distance=10.0;//十米定位一次
    _locationManager.distanceFilter=distance;
    //启动跟踪定位
    [_locationManager startUpdatingLocation];
}


#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    _location = location;
    CLLocationCoordinate2D coordinate=_location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度:%f",coordinate.longitude,coordinate.latitude);
    
    //3.设置地图的中心点在那个位置上
    _mapView.centerCoordinate =  CLLocationCoordinate2DMake(_location.coordinate.latitude, _location.coordinate.longitude);
    [self placeAroundWithCLLocation:_location];
    //2.设置地图的级数（级数与显示区域成反比）
    _mapView.zoomLevel = 14.2;
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}

/**
 配置地图
 */
- (void)configMapView{
    
    //1.是否开启定位
    _mapView.showsUserLocation = YES;//默认为No 只有真机才能定位
    
    //5.设置地图的其他样式
    _mapView.showsCompass = YES;// 设置成 NO 表示关闭指南针;YES 表示显示指南针
    _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 100); //设置指南针的位置
    
}
//周边查找
-(void)placeAroundWithCLLocation:(CLLocation *)location{
    
    //创建搜索对象
    _search = [[AMapSearchAPI alloc]initWithSearchKey:@"bc41a742d358209d9242d16024d9078c" Delegate:self];
    //创建搜索地址
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc]init];
    //设置周边查找
    request.searchType = AMapSearchType_PlaceAround;
    //设置中心点
    request.location =[AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    //设置查找半径
    request.radius = 2000;
    //设置查找的关键字
    request.keywords = @"药店";
    //是否返回扩展信息
    request.requireExtension = YES;
    //开始查找
    [_search AMapPlaceSearch:request];
    
}
//返回搜索结果对应的回调函数
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response{
    NSArray *array = response.pois;
    //遍历所有的兴趣点
    for (AMapPOI *p in array) {
        
        DXMapListModel *model = [[DXMapListModel alloc] init];
        model.latitude = p.location.latitude;
        model.longitude = p.location.longitude;
        model.name = p.name;
        model.address = p.address;
        model.distance = p.distance;
        [self.mapListArray addObject:model];
        
        //创建标注对象
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc]init];
        annotation.coordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        annotation.title = p.name;
        annotation.subtitle =p.address;
        [_mapView addAnnotation:annotation];
        
    }
   // NSLog(@"%ld", self.mapListArray.count);
}
//大头针样式的设置
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout= YES; //设置气泡可以弹出,默认为 NO
//        annotationView.animatesDrop = YES; //设置标注动画显示,默认为 NO
        annotationView.draggable = YES; //设置标注可以拖动,默认为 NO
        annotationView.image=[UIImage imageNamed:@"annotation"];
        if ([[annotation title] isEqualToString:@"当前位置"]) {
//             annotationView.pinColor = MAPinAnnotationColorGreen;
        }else{
//         annotationView.pinColor = MAPinAnnotationColorPurple;
        }
       
        return annotationView;
    }
    
    return nil;

}
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{

    self.nameLabel.text=view.annotation.title;
    self.addressLabel.text=view.annotation.subtitle;
    [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
}
@end
