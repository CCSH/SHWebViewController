//
//  AppDelegate.m
//  SHWebViewController
//
//  Created by CSH on 2018/8/10.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initShare];
    return YES;
}

- (void)initShare{
    
//    [ShareSDK registerApp:@"14157c6e15860"
//          activePlatforms:@[
//                            @(SSDKPlatformTypeSinaWeibo),
//                            @(SSDKPlatformTypeTencentWeibo),
//                            @(SSDKPlatformTypeMail),
//                            @(SSDKPlatformTypeSMS),
//                            @(SSDKPlatformTypeCopy),
//                            @(SSDKPlatformTypeFacebook),
//                            @(SSDKPlatformTypeTwitter),
//                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformTypeDouBan),
//                            @(SSDKPlatformTypeRenren),
//                            @(SSDKPlatformTypeKaixin),
//                            @(SSDKPlatformTypeGooglePlus),
//                            @(SSDKPlatformTypePocket),
//                            @(SSDKPlatformTypeInstagram),
//                            @(SSDKPlatformTypeLinkedIn),
//                            @(SSDKPlatformTypeTumblr),
//                            @(SSDKPlatformTypeFlickr),
//                            @(SSDKPlatformTypeWhatsApp),
//                            @(SSDKPlatformTypeYouDaoNote),
//                            @(SSDKPlatformTypeLine),
//                            @(SSDKPlatformTypeYinXiang),
//                            @(SSDKPlatformTypeEvernote),
//                            @(SSDKPlatformTypeYinXiang),
//                            @(SSDKPlatformTypeAliPaySocial),
//                            @(SSDKPlatformTypePinterest),
//                            @(SSDKPlatformTypeKakao),
//                            @(SSDKPlatformSubTypeKakaoTalk),
//                            @(SSDKPlatformSubTypeKakaoStory),
//                            @(SSDKPlatformTypeDropbox),
//                            @(SSDKPlatformTypeVKontakte),
//                            @(SSDKPlatformTypeMingDao),
//                            @(SSDKPlatformTypePrint),
//                            @(SSDKPlatformTypeYiXin),
//                            @(SSDKPlatformTypeInstapaper),
//                            @(SSDKPlatformTypeFacebookMessenger)
//                            ]
//                 onImport:^(SSDKPlatformType platformType) {
//                     
//                     //                     switch (platformType)
//                     //                     {
//                     //                         case SSDKPlatformTypeWechat:
//                     //                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
//                     //                             break;
//                     //                         case SSDKPlatformTypeQQ:
//                     //                             [ShareSDKConnector connectQQ:[QQApiInterface class]
//                     //                                        tencentOAuthClass:[TencentOAuth class]];
//                     //                             break;
//                     //                         case SSDKPlatformTypeSinaWeibo:
//                     //                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                     //                             break;
//                     //                         case SSDKPlatformTypeRenren:
//                     //                             [ShareSDKConnector connectRenren:[RennClient class]];
//                     //                             break;
//                     //                         case SSDKPlatformTypeKakao:
//                     //                             [ShareSDKConnector connectKaKao:[KOSession class]];
//                     //                             break;
//                     //                         case SSDKPlatformTypeAliPaySocial:
//                     //                             [ShareSDKConnector connectAliPaySocial:[APOpenAPI class]];
//                     //                             break;
//                     //                         case SSDKPlatformTypeYiXin:
//                     //                             [ShareSDKConnector connectYiXin:[YXApi class]];
//                     //                             break;
//                     //                         case SSDKPlatformTypeFacebookMessenger:
//                     //                             [ShareSDKConnector connectFacebookMessenger:[FBSDKMessengerSharer class]];
//                     //                             break;
//                     //                         default:
//                     //                             break;
//                     //                     }
//                     
//                     
//                 }
//          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//              
//              switch (platformType)
//              {
//                  case SSDKPlatformTypeSinaWeibo:
//                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                              redirectUri:@"http://www.sharesdk.cn"
//                                                 authType:SSDKAuthTypeBoth];
//                      break;
//                  case SSDKPlatformTypeTencentWeibo:
//                      //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
//                      [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
//                                                   appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
//                                                 redirectUri:@"http://www.sharesdk.cn"];
//                      break;
//                  case SSDKPlatformTypeFacebook:
//                      //设置Facebook应用信息，其中authType设置为只用SSO形式授权
//                      [appInfo SSDKSetupFacebookByApiKey:@"250721551966410"
//                                               appSecret:@"4fe025c2e27f8983afbba9281b5a14d8"
//                                                authType:SSDKAuthTypeBoth];
//                      break;
//                  case SSDKPlatformTypeTwitter:
//                      [appInfo SSDKSetupTwitterByConsumerKey:@"LRBM0H75rWrU9gNHvlEAA2aOy"
//                                              consumerSecret:@"gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G"
//                                                 redirectUri:@"http://mob.com"];
//                      break;
//                  case SSDKPlatformTypeWechat:
//                      [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
//                                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
//                      break;
//                  case SSDKPlatformTypeQQ:
//                      [appInfo SSDKSetupQQByAppId:@"100371282"
//                                           appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                         authType:SSDKAuthTypeBoth];
//                      break;
//                  case SSDKPlatformTypeDouBan:
//                      [appInfo SSDKSetupDouBanByApiKey:@"02e2cbe5ca06de5908a863b15e149b0b"
//                                                secret:@"9f1e7b4f71304f2f"
//                                           redirectUri:@"http://www.sharesdk.cn"];
//                      break;
//                  case SSDKPlatformTypeRenren:
//                      [appInfo SSDKSetupRenRenByAppId:@"226427"
//                                               appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
//                                            secretKey:@"f29df781abdd4f49beca5a2194676ca4"
//                                             authType:SSDKAuthTypeBoth];
//                      break;
//                  case SSDKPlatformTypeKaixin:
//                      [appInfo SSDKSetupKaiXinByApiKey:@"358443394194887cee81ff5890870c7c"
//                                             secretKey:@"da32179d859c016169f66d90b6db2a23"
//                                           redirectUri:@"http://www.sharesdk.cn/"];
//                      break;
//                  case SSDKPlatformTypeGooglePlus:
//                      
//                      [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
//                                                clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
//                                                 redirectUri:@"http://localhost"];
//                      break;
//                  case SSDKPlatformTypePocket:
//                      [appInfo SSDKSetupPocketByConsumerKey:@"11496-de7c8c5eb25b2c9fcdc2b627"
//                                                redirectUri:@"pocketapp1234"
//                                                   authType:SSDKAuthTypeBoth];
//                      break;
//                  case SSDKPlatformTypeInstagram:
//                      [appInfo SSDKSetupInstagramByClientID:@"ff68e3216b4f4f989121aa1c2962d058"
//                                               clientSecret:@"1b2e82f110264869b3505c3fe34e31a1"
//                                                redirectUri:@"http://sharesdk.cn"];
//                      break;
//                  case SSDKPlatformTypeLinkedIn:
//                      [appInfo SSDKSetupLinkedInByApiKey:@"ejo5ibkye3vo"
//                                               secretKey:@"cC7B2jpxITqPLZ5M"
//                                             redirectUrl:@"http://sharesdk.cn"];
//                      break;
//                  case SSDKPlatformTypeTumblr:
//                      [appInfo SSDKSetupTumblrByConsumerKey:@"2QUXqO9fcgGdtGG1FcvML6ZunIQzAEL8xY6hIaxdJnDti2DYwM"
//                                             consumerSecret:@"3Rt0sPFj7u2g39mEVB3IBpOzKnM3JnTtxX2bao2JKk4VV1gtNo"
//                                                callbackUrl:@"http://sharesdk.cn"];
//                      break;
//                  case SSDKPlatformTypeFlickr:
//                      [appInfo SSDKSetupFlickrByApiKey:@"33d833ee6b6fca49943363282dd313dd"
//                                             apiSecret:@"3a2c5b42a8fbb8bb"];
//                      break;
//                  case SSDKPlatformTypeYouDaoNote:
//                      [appInfo SSDKSetupYouDaoNoteByConsumerKey:@"dcde25dca105bcc36884ed4534dab940"
//                                                 consumerSecret:@"d98217b4020e7f1874263795f44838fe"
//                                                  oauthCallback:@"http://www.sharesdk.cn/"];
//                      break;
//                      
//                      //印象笔记分为国内版和国际版，注意区分平台
//                      //设置印象笔记（中国版）应用信息
//                  case SSDKPlatformTypeYinXiang:
//                      
//                      //设置印象笔记（国际版）应用信息
//                  case SSDKPlatformTypeEvernote:
//                      [appInfo SSDKSetupEvernoteByConsumerKey:@"sharesdk-7807"
//                                               consumerSecret:@"d05bf86993836004"
//                                                      sandbox:YES];
//                      break;
//                  case SSDKPlatformTypeKakao:
//                      [appInfo SSDKSetupKaKaoByAppKey:@"48d3f524e4a636b08d81b3ceb50f1003"
//                                           restApiKey:@"ac360fa50b5002637590d24108e6cb10"
//                                          redirectUri:@"http://www.mob.com/oauth"
//                                             authType:SSDKAuthTypeBoth];
//                      break;
//                  case SSDKPlatformTypeAliPaySocial:
//                      [appInfo SSDKSetupAliPaySocialByAppId:@"2015072400185895"];
//                      break;
//                  case SSDKPlatformTypePinterest:
//                      [appInfo SSDKSetupPinterestByClientId:@"4797078908495202393"];
//                      break;
//                  case SSDKPlatformTypeDropbox:
//                      [appInfo SSDKSetupDropboxByAppKey:@"i5vw2mex1zcgjcj"
//                                              appSecret:@"3i9xifsgb4omr0s"
//                                          oauthCallback:@"https://www.sharesdk.cn"];
//                      break;
//                  case SSDKPlatformTypeVKontakte:
//                      [appInfo SSDKSetupVKontakteByApplicationId:@"5312801"
//                                                       secretKey:@"ZHG2wGymmNUCRLG2r6CY"];
//                      break;
//                  case SSDKPlatformTypeMingDao:
//                      [appInfo SSDKSetupMingDaoByAppKey:@"EEEE9578D1D431D3215D8C21BF5357E3"
//                                              appSecret:@"5EDE59F37B3EFA8F65EEFB9976A4E933"
//                                            redirectUri:@"http://sharesdk.cn"];
//                      break;
//                  case SSDKPlatformTypeYiXin:
//                      [appInfo SSDKSetupYiXinByAppId:@"yx0d9a9f9088ea44d78680f3274da1765f"
//                                           appSecret:@"1a5bd421ae089c3"
//                                         redirectUri:@"https://open.yixin.im/resource/oauth2_callback.html"
//                                            authType:SSDKAuthTypeBoth];
//                      break;
//                  case SSDKPlatformTypeInstapaper:
//                      [appInfo SSDKSetupInstapaperByConsumerKey:@"4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA"
//                                                 consumerSecret:@"GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe"];
//                      break;
//                  default:
//                      break;
//              }
//          }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
