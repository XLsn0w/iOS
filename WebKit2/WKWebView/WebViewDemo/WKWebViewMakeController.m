//
//  WKWebViewMakeController.m
//  WebViewDemo
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 优客工场. All rights reserved.
//

#import "WKWebViewMakeController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewMakeController () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView* wkWebView;

@end

@implementation WKWebViewMakeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    configuration.userContentController = userContentController;
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.wkWebView.allowsBackForwardNavigationGestures = YES;    //允许右滑返回上个链接，左滑前进
    self.wkWebView.allowsLinkPreview = YES; //允许链接3D Touch
    self.wkWebView.customUserAgent = @"WebViewDemo/1.0.0"; //自定义UA，UIWebView就没有此功能，后面会讲到通过其他方式实现
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    //注入一个Cookie
    WKUserScript *newCookieScript = [[WKUserScript alloc] initWithSource:@"document.cookie = 'DarkAngelCookie=DarkAngel;'" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:newCookieScript];
    
    //创建脚本
    WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:@"alert(document.cookie);" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    //添加脚本
    [userContentController addUserScript:cookieScript];
}

/*
-initWithFrame: to initialize an instance with the default configuration. 如果使用initWithFrame方法将使用默认的configuration
The initializer copies the specified configuration, so mutating the configuration after invoking the initializer has no effect on the web view. 我们需要先设置configuration，再调用init，在init之后修改configuration则无效

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;
 
 @interface WKUserContentController : NSObject <NSCoding>
 //读取添加过的脚本
 @property (nonatomic, readonly, copy) NSArray<WKUserScript *> *userScripts;
 //添加脚本
 - (void)addUserScript:(WKUserScript *)userScript;
 //删除所有添加的脚本
 - (void)removeAllUserScripts;
 //通过window.webkit.messageHandlers.<name>.postMessage(<messageBody>) 来实现js->oc传递消息，并添加handler
 - (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name;
 //删除handler
 - (void)removeScriptMessageHandlerForName:(NSString *)name;
 @end
 
 
 
 
 
 
 
 
*/

@end
