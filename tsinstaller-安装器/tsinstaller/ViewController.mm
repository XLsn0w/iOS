//
//  ViewController.m
//  tsinstaller
//
//  Created by Zheng on 12/20/15.
//  Copyright © 2015 Zheng. All rights reserved.
//

#import <spawn.h>
#import <stdio.h>
#import <sys/stat.h>
#import "ViewController.h"

#define currentVersion @"2.2.6"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define sshpassExecPath SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") ? [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/sshpass"] : @"/tmp/sshpass"

@interface ViewController ()
@property (strong, nonatomic) NSMutableData *fileData;
@property (strong, nonatomic) NSFileHandle *writeHandle;
@property (nonatomic, assign) long long currentLength;
@property (nonatomic, assign) long long sumLength;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *grayActivityIndicator_1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *grayActivityIndicator_2;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *grayActivityIndicator_3;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *grayActivityIndicator_4;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *grayActivityIndicator_5;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *grayActivityIndicator_6;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel_1; // 检查安装环境
@property (weak, nonatomic) IBOutlet UILabel *activityLabel_2; // 检查所需依赖
@property (weak, nonatomic) IBOutlet UILabel *activityLabel_3; // 检查网络环境
@property (weak, nonatomic) IBOutlet UILabel *activityLabel_4; // 获取资源文件
@property (weak, nonatomic) IBOutlet UILabel *activityLabel_5; // 执行安装进程
@property (weak, nonatomic) IBOutlet UILabel *activityLabel_6; // 执行清理
@property (weak, nonatomic) IBOutlet UIButton *installButton;
@property (weak, nonatomic) IBOutlet UITextView *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkUpdateButton;
@property (strong, nonatomic) UIAlertView *reportAlertView;
@property (strong, nonatomic) NSString *verifyStr;
@property (strong, nonatomic) NSString *downloadUrl;
@property (strong, nonatomic) NSString *installedVersion;
@property (strong, nonatomic) NSString *remoteVersion;
@property BOOL hasRootPrivilege;
@property BOOL appInstalled;
@property BOOL iconNotDisplayed;
@property BOOL shouldUseCydia;
@property BOOL downloading;
@property BOOL downloadResult;
@property BOOL installSucceed;
@property BOOL shouldUpdate;

@end

@implementation ViewController

const char* password = "alpine";
const char* envp[] = {"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin", "HOME=/var/mobile", "USER=mobile", "LOGNAME=mobile", NULL};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init {
    if (self = [super init]) {
        _appInstalled = NO;
        _shouldUseCydia = NO;
        _verifyStr = nil;
        _downloadUrl = nil;
        _downloadResult = NO;
        _downloading = NO;
        _installSucceed = NO;
        _iconNotDisplayed = NO;
        _installedVersion = nil;
        _shouldUpdate = NO;
        _hasRootPrivilege = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _hasRootPrivilege = [self checkPrivileges];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:@"/Applications/TouchSprite.app/Info.plist"]) {
        _appInstalled = YES;
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"touchsprite://"]]) {
            _iconNotDisplayed = NO;
            _installButton.enabled = YES;
            _checkUpdateButton.hidden = NO;
            [_installButton setTitle:@"立即启动" forState:UIControlStateNormal];
            if ([self checkVersion]) {
                if (_installedVersion != nil) {
                    [_tipsLabel setText:[NSString stringWithFormat:@"已安装触动精灵 v%@，轻按以启动。", _installedVersion]];
                }
            }
        } else {
            _iconNotDisplayed = YES;
            if (_hasRootPrivilege) {
                _installButton.enabled = YES;
                [_installButton setTitle:@"修复图标" forState:UIControlStateNormal];
                [_tipsLabel setText:@"检测到问题，轻按以尝试修复丢失的触动精灵图标。"];
            } else {
                _installButton.enabled = NO;
                [_installButton setTitle:@"无法修复图标" forState:UIControlStateDisabled];
                [_tipsLabel setText:@"检测到问题，但无法完成一键修复，请联系客服反馈问题。"];
                [self reportProblems];
            }
        }
    } else {
        if (!_hasRootPrivilege) {
            _shouldUseCydia = YES;
            [_installButton setTitle:@"跳转到 Cydia 安装" forState:UIControlStateNormal];
        } else {
            [_installButton setTitle:@"一键安装" forState:UIControlStateNormal];
        }
        _installButton.enabled = YES;
        _tipsLabel.text = [@"触动精灵安装器 v" stringByAppendingString:currentVersion];
    }
}

- (void)reportProblems {
    _reportAlertView = [[UIAlertView alloc] initWithTitle:@"反馈问题"
                                                    message:@"如果在安装过程中出现任何问题，欢迎联系我们进行问题反馈。"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"反馈",nil];
    [_reportAlertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _reportAlertView && buttonIndex == alertView.firstOtherButtonIndex) {
        NSURL *url = [NSURL URLWithString:@"http://kf.touchsprite.com/hc/"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (IBAction)checkUpdateButtonTapped:(id)sender {
    _checkUpdateButton.enabled = NO;
    [_checkUpdateButton setTitle:@"检查更新中……" forState:UIControlStateNormal];
    if (![self checkVersion] || !_installedVersion) {
        _checkUpdateButton.enabled = YES;
        [_checkUpdateButton setTitle:@"重试" forState:UIControlStateNormal];
        [_tipsLabel setText:@"获取本地版本信息失败，轻按以重试。"];
        return;
    }
    if (![self checkNetwork] || !_remoteVersion) {
        _checkUpdateButton.enabled = YES;
        [_checkUpdateButton setTitle:@"重试" forState:UIControlStateNormal];
        [_tipsLabel setText:@"连接服务器失败，轻按以重试。"];
        return;
    }
    if ([_installedVersion isEqualToString:_remoteVersion]) {
        [_checkUpdateButton setTitle:@"已安装最新版本" forState:UIControlStateNormal];
        [_tipsLabel setText:[NSString stringWithFormat:@"您已经安装了最新版本触动精灵 v%@，无需更新。", _installedVersion]];
        return;
    }
    if (!_hasRootPrivilege) {
        _shouldUseCydia = YES;
        [_installButton setTitle:@"跳转到 Cydia 升级" forState:UIControlStateNormal];
    } else {
        _shouldUseCydia = NO;
        [_checkUpdateButton setTitle:@"发现新版本" forState:UIControlStateNormal];
        [_installButton setTitle:@"一键升级" forState:UIControlStateNormal];
        [_tipsLabel setText:[NSString stringWithFormat:@"发现新版本 v%@，轻按以一键升级。", _remoteVersion]];
    }
    _shouldUpdate = YES;
    _installButton.enabled = YES;
}

- (IBAction)installButtonTapped:(id)sender {
    if (_installSucceed) {
        _installButton.enabled = NO;
        [_installButton setTitle:@"正在重启……" forState:UIControlStateDisabled];
        pid_t pid; int status = 0;
        const char* args[] = {"killall", "-9", "SpringBoard", "backboardd", NULL};
        posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, (char* const*)envp);
        waitpid(pid, &status, 0);
        return;
    } else if (_appInstalled && !_shouldUpdate) {
        if (_iconNotDisplayed) {
            _installButton.enabled = NO;
            if ([self doCleaning]) {
                _installSucceed = YES;
                _installButton.enabled = YES;
                [_installButton setTitle:@"立即重启" forState:UIControlStateNormal];
                [_tipsLabel setText:@"图标修复成功，轻按以重启设备。"];
            } else {
                [_installButton setTitle:@"修复失败" forState:UIControlStateDisabled];
                [_tipsLabel setText:@"图标修复失败，请联系客服反馈问题"];
                [self reportProblems];
            }
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"touchsprite://"]];
        }
    } else {
        _installButton.enabled = NO;
        [_installButton setTitle:@"安装中……" forState:UIControlStateNormal];
        [self stepAnimate:1];
        if (![self checkEnvironment]) {
            [self fatalError:1];
            return;
        }
        if (_shouldUseCydia) {
            [self stepAnimate:8];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"cydia://url/file://%@/%@", [[NSBundle mainBundle] resourcePath], @"install.html"]]];
            [self reportProblems];
            return;
        }
        [self stepAnimate:2];
        if (![self checkDependencies]) {
            if (![self installDependencies]) {
                [self fatalError:2];
                return;
            }
        }
        [self stepAnimate:3];
        if (![self checkNetwork]) {
            [_activityLabel_3 setText:@"无法连接到服务器"];
            _activityLabel_3.textColor = [UIColor grayColor];
        }
        [self stepAnimate:4];
        if (![self downloadResources]) {
            if (!_downloadUrl) {
                [_activityLabel_4 setText:@"无需获取更新资源"];
            } else {
                [_activityLabel_4 setText:@"更新资源获取失败"];
            }
            _activityLabel_4.textColor = [UIColor grayColor];
        }
        [self stepAnimate:5];
        if (![self doInstalling]) {
            [self fatalError:5];
            return;
        }
        [self stepAnimate:6];
        if (![self doCleaning]) {
            _activityLabel_6.textColor = [UIColor grayColor];
        }
        [self stepAnimate:7];
    }
}

- (void)stepAnimate:(int)step {
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    if (step == 1) {
        [UIView animateWithDuration:1.0 animations:^{
            _introLabel.alpha = 0;
            _grayActivityIndicator_1.alpha =
            _activityLabel_1.alpha =
            _activityLabel_2.alpha =
            _activityLabel_3.alpha =
            _activityLabel_4.alpha =
            _activityLabel_5.alpha =
            _activityLabel_6.alpha =
            1;
            _installButton.enabled = NO;
        }];
    } else if (step == 2) {
        [UIView animateWithDuration:1.0 animations:^{
            _grayActivityIndicator_1.alpha = 0;
            _grayActivityIndicator_2.alpha = 1;
        }];
    } else if (step == 3) {
        [UIView animateWithDuration:1.0 animations:^{
            _grayActivityIndicator_2.alpha = 0;
            _grayActivityIndicator_3.alpha = 1;
        }];
    } else if (step == 4) {
        [UIView animateWithDuration:1.0 animations:^{
            _grayActivityIndicator_3.alpha = 0;
            _grayActivityIndicator_4.alpha = 1;
        }];
    } else if (step == 5) {
        [UIView animateWithDuration:1.0 animations:^{
            _grayActivityIndicator_4.alpha = 0;
            _grayActivityIndicator_5.alpha = 1;
        }];
    } else if (step == 6) {
        [UIView animateWithDuration:1.0 animations:^{
            _grayActivityIndicator_5.alpha = 0;
            _grayActivityIndicator_6.alpha = 1;
        }];
    } else if (step == 7) {
        [UIView animateWithDuration:3.0 animations:^{
            _grayActivityIndicator_6.alpha = 0;
        } completion:^(BOOL finished) {
            _appInstalled = YES;
            _installButton.enabled = YES;
            _installSucceed = YES;
            [_installButton setTitle:@"立即重启" forState:UIControlStateNormal];
            [_tipsLabel setText:@"安装完成，需要重启设备，轻按以重启设备。"];
        }];
    } else if (step == 8) {
        [UIView animateWithDuration:1.0 animations:^{
            _grayActivityIndicator_1.alpha = 0;
        } completion:^(BOOL finished) {
            _installButton.enabled = YES;
            [_installButton setTitle:@"打开 Cydia" forState:UIControlStateNormal];
            [_tipsLabel setText:@"请在 Cydia 中继续安装。"];
        }];
    }
}

- (void)fatalError:(int)step {
    if (step == 1) {
        _activityLabel_1.textColor = [UIColor redColor];
    } else if (step == 2) {
        _activityLabel_2.textColor = [UIColor redColor];
    } else if (step == 3) {
        _activityLabel_3.textColor = [UIColor redColor];
    } else if (step == 4) {
        _activityLabel_4.textColor = [UIColor redColor];
    } else if (step == 5) {
        _activityLabel_5.textColor = [UIColor redColor];
    } else if (step == 6) {
        _activityLabel_6.textColor = [UIColor redColor];
    }
    [UIView animateWithDuration:1.0 animations:^{
        _grayActivityIndicator_1.alpha = 0;
        _grayActivityIndicator_2.alpha = 0;
        _grayActivityIndicator_3.alpha = 0;
        _grayActivityIndicator_4.alpha = 0;
        _grayActivityIndicator_5.alpha = 0;
        _grayActivityIndicator_6.alpha = 0;
    } completion:^(BOOL finished) {
        if (step != 1) {
            _shouldUseCydia = YES;
            _installButton.enabled = YES;
            [_installButton setTitle:@"打开 Cydia" forState:UIControlStateNormal];
            [_tipsLabel setText:@"一键安装失败，请尝试在 Cydia 中继续安装。"];
        } else {
            [_installButton setTitle:@"安装失败" forState:UIControlStateDisabled];
            [_tipsLabel setText:@"安装失败，请检查安装环境。"];
            [self reportProblems];
        }
    }];
}

- (BOOL)checkVersion {
    NSMutableDictionary *infoPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/Applications/TouchSprite.app/Info.plist"];
    if (!infoPlist) {
        return NO;
    }
    id version = [infoPlist objectForKey:@"CFBundleVersion"];
    if (!version || ![version isKindOfClass:[NSString class]]) {
        return NO;
    }
    _installedVersion = version;
    return YES;
}

- (BOOL)checkPrivileges {
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (!fileManager) {
        return NO;
    }
    if ([fileManager fileExistsAtPath:sshpassExecPath]) {
        [fileManager removeItemAtPath:sshpassExecPath error:&error];
    }
    if (error != nil) {
        return NO;
    }
    [fileManager copyItemAtPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"bin/sshpass"] toPath:sshpassExecPath error:&error];
    if (error != nil) {
        return NO;
    }
    if (chmod([sshpassExecPath UTF8String], 0755)) {
        return NO;
    }
    pid_t pid; int status = 0;
    const char* args[] = {"sshpass", "-p", password, "/bin/su", "-c", "echo -n", NULL};
    posix_spawn(&pid, [sshpassExecPath UTF8String], NULL, NULL, (char* const*)args, (char* const*)envp);
    waitpid(pid, &status, 0);
    if (status == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)checkEnvironment {
    if (SYSTEM_VERSION_LESS_THAN(@"7.0") || SYSTEM_VERSION_GREATER_THAN(@"9.0.2")) {
        [_activityLabel_1 setText:[NSString stringWithFormat:@"不支持的 iOS 版本：%@", [[UIDevice currentDevice] systemVersion]]];
        return NO;
    } else {
        [_activityLabel_1 setText:[NSString stringWithFormat:@"支持的 iOS 版本：%@", [[UIDevice currentDevice] systemVersion]]];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]) {
        [_activityLabel_1 setText:@"请先越狱并安装 Cydia"];
        return NO;
    } else {
        [_activityLabel_1 setText:@"已越狱并安装 Cydia"];
    }
    return YES;
}

- (BOOL)checkDependencies {
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
        [_activityLabel_2 setText:@"未安装 Cydia Substrate"];
        return NO;
    } else {
        [_activityLabel_2 setText:@"已安装 Cydia Substrate"];
    }
    return YES;
}

- (BOOL)installDependencies {
    __block BOOL running = YES;
    __block int status = 0;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        pid_t pid;
        NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"packages/dependencies/*.deb"];
        const char* args[] = {"sshpass", "-p", password, "/bin/su", "-c", [[NSString stringWithFormat:@"dpkg -i %@", path] UTF8String], NULL};
        posix_spawn(&pid, [sshpassExecPath UTF8String], NULL, NULL, (char* const*)args, (char* const*)envp);
        waitpid(pid, &status, 0);
        dispatch_async(dispatch_get_main_queue(), ^{
            running = NO;
        });
    });
    while (running) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    if (status == 0) {
        [_activityLabel_2 setText:@"Cydia Substrate 安装成功"];
        return YES;
    } else {
        [_activityLabel_2 setText:@"Cydia Substrate 安装失败"];
        return NO;
    }
}

- (BOOL)checkNetwork {
    __block BOOL running = YES;
    __block BOOL result = NO;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.touchsprite.net/ajax/web?type=home"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f];
        [request setHTTPMethod:@"GET"];
        NSHTTPURLResponse *response = nil;
        NSError	*error = nil;
        NSData *data	 = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:&response
                                                          error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            running = NO;
            if ( !error && data ) {
                NSError	*error = nil;
                NSDictionary *retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:&error];
                if ( !error && retDict ) {
                    id errorCode = [retDict objectForKey:@"success"];
                    if (errorCode) {
                        if ([errorCode boolValue] == YES) {
                            id softVersions = [retDict objectForKey:@"softVersions"];
                            if (softVersions && [softVersions respondsToSelector:@selector(count)]) {
                                for (int i = 0; i < [softVersions count]; i++) {
                                    id softVersion = [softVersions objectAtIndex:i];
                                    if (softVersion && [softVersion isKindOfClass:[NSDictionary class]] && [[softVersion objectForKey:@"os"] isEqualToString:@"ios"]) {
                                        id version = [softVersion objectForKey:@"version"];
                                        if (version && [version isKindOfClass:[NSString class]]) {
                                            _remoteVersion = version;
                                            if ([version isEqualToString:currentVersion]) {
                                                _downloadUrl = nil;
                                                [_activityLabel_3 setText:@"内置资源已经是最新版本"];
                                            } else {
                                                _downloadUrl = [softVersion objectForKey:@"url"];
                                                [_activityLabel_3 setText:[NSString stringWithFormat:@"发现新版本：%@", version]];
                                            }
                                            result = YES;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        });
    });
    while (running) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    return result;
}

- (BOOL)downloadResources {
    if (_downloadUrl != nil) {
        _downloading = YES;
        NSURL *url = [NSURL URLWithString:_downloadUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection connectionWithRequest:request delegate:self];
        while (_downloading) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
    return _downloadResult;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSError *error = nil;
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [caches stringByAppendingPathComponent:@"cache.deb"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachePath]) {
        [fileManager removeItemAtPath:cachePath error:&error];
    }
    [fileManager createFileAtPath:cachePath contents:nil attributes:nil];
    _writeHandle = [NSFileHandle fileHandleForWritingAtPath:cachePath];
    _sumLength = response.expectedContentLength;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    _currentLength += data.length;
    double progress = (double)_currentLength / _sumLength;
    [_activityLabel_4 setText:[NSString stringWithFormat:@"获取资源文件……%.2f%%", progress * 100]];
    [_writeHandle seekToEndOfFile];
    [_writeHandle writeData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_writeHandle closeFile];
    _writeHandle = nil;
    _currentLength = 0;
    _sumLength = 0;
    _downloadResult = YES;
    _downloading = NO;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _downloadResult = NO;
    _downloading = NO;
}

- (BOOL)doInstalling {
    __block int status = 0;
    __block BOOL running = YES;
    [_activityLabel_5 setText:@"正在安装触动精灵"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *cachePath = nil;
        if (_downloadUrl != nil && _downloadResult) {
            cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"cache.deb"];
        } else {
            cachePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"packages/*.deb"];
        }
        NSString *command = [NSString stringWithFormat:@"dpkg -i %@", cachePath];
        pid_t pid;
        const char* args[] = {"sshpass", "-p", password, "/bin/su", "-c", [command UTF8String], NULL};
        posix_spawn(&pid, [sshpassExecPath UTF8String], NULL, NULL, (char* const*)args, (char* const*)envp);
        waitpid(pid, &status, 0);
        dispatch_async(dispatch_get_main_queue(), ^{
            running = NO;
        });
    });
    while (running) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    if (status == 0) {
        [_activityLabel_5 setText:@"触动精灵安装成功"];
        return YES;
    } else {
        [_activityLabel_5 setText:@"触动精灵安装失败"];
        return NO;
    }
}

- (BOOL)doCleaning {
    __block int status = -1;
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/uicached.dylib"]) {
        status = 0;
        [_activityLabel_6 setText:@"图标缓存重建成功"];
        return YES;
    } else {
        __block BOOL running = YES;
        [_activityLabel_6 setText:@"正在重建图标缓存"];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString *cachePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"packages/uicached/*.deb"];
            NSString *command = [NSString stringWithFormat:@"dpkg -i %@", cachePath];
            pid_t pid;
            const char* args[] = {"sshpass", "-p", password, "/bin/su", "-c", [command UTF8String], NULL};
            posix_spawn(&pid, [sshpassExecPath UTF8String], NULL, NULL, (char* const*)args, (char* const*)envp);
            waitpid(pid, &status, 0);
            dispatch_async(dispatch_get_main_queue(), ^{
                running = NO;
            });
        });
        while (running) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
    if (status == 0) {
        [_activityLabel_6 setText:@"图标缓存重建成功"];
        return YES;
    } else {
        [_activityLabel_6 setText:@"图标缓存重建失败"];
        return NO;
    }
}

@end
