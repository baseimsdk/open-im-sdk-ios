//
//  OIMManager+Connection.m
//  OpenIMSDK
//
//  Created by x on 2022/2/15.
//

#import "OIMManager+Connection.h"

@implementation OIMManager (Connection)

- (BOOL)initSDK:(OIMPlatform)platform
        apiAdrr:(NSString *)apiAddr
         wsAddr:(NSString *)wsAddr
        dataDir:(NSString *)dataDir
       logLevel:(NSInteger)logLevel
  objectStorage:(NSString *)os
   onConnecting:(OIMVoidCallback)onConnecting
onConnectFailure:(OIMFailureCallback)onConnectFailure
onConnectSuccess:(OIMVoidCallback)onConnectSuccess
onKickedOffline:(OIMVoidCallback)onKickedOffline
onUserTokenExpired:(OIMVoidCallback)onUserTokenExpired {
    
    [self class].callbacker.onConnecting = onConnecting;
    [self class].callbacker.onConnectFailure = onConnectFailure;
    [self class].callbacker.onConnectSuccess = onConnectSuccess;
    [self class].callbacker.onKickedOffline = onKickedOffline;
    [self class].callbacker.onUserTokenExpired = onUserTokenExpired;
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    
    param[@"platform"] = @(platform);
    
    param[@"api_addr"] = apiAddr ?: @"";
    param[@"ws_addr"]  = wsAddr ?: @"";
    param[@"data_dir"] = dataDir ?: @"";
    param[@"log_level"] = logLevel == 0 ? @6 : @(logLevel);
    param[@"object_storage"] = os.length == 0 ? @"cos" : @"";
    
    return Open_im_sdkInitSDK(self, [self operationId], param.mj_JSONString);
}

- (void)onConnectFailed:(int32_t)errCode errMsg:(NSString * _Nullable)errMsg {
    if ([self class].callbacker.onConnectFailure) {
        [self class].callbacker.onConnectFailure(errCode, errMsg);
    }
}

- (void)onConnectSuccess {
    if ([[self class] class].callbacker.onConnectSuccess) {
        [[self class] class].callbacker.onConnectSuccess();
    }
}

- (void)onConnecting {
    if ([self class].callbacker.onConnecting) {
        [self class].callbacker.onConnecting();
    }}

- (void)onKickedOffline {
    if ([self class].callbacker.onKickedOffline) {
        [self class].callbacker.onKickedOffline();
    }}

- (void)onUserTokenExpired {
    if ([self class].callbacker.onUserTokenExpired) {
        [self class].callbacker.onUserTokenExpired();
    }
}

@end
