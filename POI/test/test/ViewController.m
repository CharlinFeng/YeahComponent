//
//  ViewController.m
//  test
//
//  Created by 冯成林 on 16/2/3.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ViewController.h"



#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

//#import < BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface ViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKPoiSearchDelegate>

@property (nonatomic,strong)  BMKMapView *mapView;

@property (nonatomic,strong) BMKLocationService *locationService;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic,assign) BMKCoordinateRegion limitMapRegion;

@property (nonatomic,strong) BMKPoiSearch *poiSearch;

@end

@implementation ViewController




- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.mapView = mapView;
    self.mapView.showsUserLocation = YES;
    
    
    [self.contentView addSubview:mapView];
    
    BMKLocationService *locationService = [[BMKLocationService alloc] init];
    self.locationService = locationService;
    locationService.delegate = self;
    [locationService startUserLocationService];
    
    self.poiSearch = [[BMKPoiSearch alloc] init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.poiSearch.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.poiSearch.delegate = nil;
}


-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    BMKCoordinateRegion limitMapRegion = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.003, 0.003));
    self.limitMapRegion = limitMapRegion;
    [self.mapView setRegion:limitMapRegion animated:YES];
    [self.mapView updateLocationData:userLocation];
}

- (IBAction)userLocationBtnClick:(id)sender {
    [self.mapView setRegion:self.limitMapRegion animated:YES];
}

- (IBAction)POISearchAction:(id)sender {
    
//    let citySearchOption = BMKCitySearchOption()
//    citySearchOption.pageIndex = currPageIndex
//    citySearchOption.pageCapacity = 10
//    citySearchOption.city = cityField.text
//    citySearchOption.keyword = keywordField.text
//    if poiSearch.poiSearchInCity(citySearchOption) {
//        print("城市内检索发送成功！")
//    }else {
//        print("城市内检索发送失败！")
//    }
    
    //创建一个POI条件
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc] init];
    
    //设置城市区域限定
    option.city = @"成都市";
    
    //设置POI关键字
    option.keyword = @"酒吧";
    
    //开始
    [self.poiSearch poiSearchInCity:option];
}


#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{

    BMKPointAnnotation *annotation = view.annotation;

    NSLog(@"您选中了%@,坐标是:(%f,%f)",annotation.title, annotation.coordinate.latitude,annotation.coordinate.longitude);
}


@end
