//
//  APIConfiguration.h
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#ifndef APIConfiguration_h
#define APIConfiguration_h

typedef NS_ENUM(NSUInteger, APIManagerRequsetType) {
    APIManagerRequsetTypeGet = 0,
    APIManagerRequsetTypePost,
    APIManagerRequsetTypePut,
    APIManagerRequsetTypeDelete,
    APIManagerRequsetTypeUpload,
    APIManagerRequsetTypeDownload,
    
};


//***************************
/**********参数**************/
//***************************
//缓存超时时间
static NSTimeInterval kAPICacheTimeOutSeconds   = 300;
//缓存最大条数
static NSUInteger kAPICacheCountLimit           = 1000;

static NSTimeInterval kAPIRequestTimeOut        = 10;


//------------------------------
//-----------Service------------
//------------------------------
extern NSString * const kAPIServiceYaoYD;

#endif /* APIConfiguration_h */
