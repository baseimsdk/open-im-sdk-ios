//
//  OIMManager+Message.m
//  OpenIMSDK
//
//  Created by x on 2022/2/16.
//

#import "OIMManager+Message.h"
#import "SendMessageCallbackProxy.h"

@implementation OIMMessageInfo (init)

+ (OIMMessageInfo *)createTextMessage:(NSString *)text {
    NSString *json = Open_im_sdkCreateTextMessage([OIMManager.manager operationId], text);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createTextAtMessage:(NSString *)text
                              atUidList:(NSArray<NSString *> *)atUidList {
    NSString *json = Open_im_sdkCreateTextAtMessage([OIMManager.manager operationId], text, atUidList.mj_JSONString);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createImageMessage:(NSString *)imagePath {
    NSString *json = Open_im_sdkCreateImageMessage([OIMManager.manager operationId], imagePath);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createImageMessageFromFullPath:(NSString *)imagePath {
    NSString *json = Open_im_sdkCreateImageMessageFromFullPath([OIMManager.manager operationId], imagePath);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createSoundMessage:(NSString *)soundPath
                              duration:(NSInteger)duration {
    NSString *json = Open_im_sdkCreateSoundMessage([OIMManager.manager operationId], soundPath, duration);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createSoundMessageFromFullPath:(NSString *)soundPath
                                          duration:(NSInteger)duration {
    NSString *json = Open_im_sdkCreateSoundMessageFromFullPath([OIMManager.manager operationId], soundPath, duration);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createVideoMessage:(NSString *)videoPath
                             videoType:(NSString *)videoType
                              duration:(NSInteger)duration
                          snapshotPath:(NSString *)snapshotPath {
    NSString *json = Open_im_sdkCreateVideoMessage([OIMManager.manager operationId], videoPath, videoType, duration, snapshotPath);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createVideoMessageFromFullPath:(NSString *)videoPath
                                         videoType:(NSString *)videoType
                                          duration:(NSInteger)duration
                                      snapshotPath:(NSString *)snapshotPath {
    NSString *json = Open_im_sdkCreateVideoMessageFromFullPath([OIMManager.manager operationId], videoPath, videoType, duration, snapshotPath);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createFileMessage:(NSString *)filePath
                             fileName:(NSString *)fileName {
    NSString *json = Open_im_sdkCreateFileMessage([OIMManager.manager operationId], filePath, fileName);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createFileMessageFromFullPath:(NSString *)filePath
                                         fileName:(NSString *)fileName {
    NSString *json = Open_im_sdkCreateFileMessageFromFullPath([OIMManager.manager operationId], filePath, fileName);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createMergerMessage:(NSArray<NSString *> *)messages
                                  title:(NSString *)title
                            summaryList:(NSArray<NSString *> *)summarys {
    NSString *json = Open_im_sdkCreateMergerMessage([OIMManager.manager operationId], messages.mj_JSONString, title, summarys.mj_JSONString);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createForwardMessage:(NSArray<NSString *> *)messages {
    NSString *json = Open_im_sdkCreateForwardMessage([OIMManager.manager operationId], messages.mj_JSONString);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createLocationMessage:(NSString *)description
                                 latitude:(double)latitude
                                longitude:(double)longitude {
    NSString *json = Open_im_sdkCreateLocationMessage([OIMManager.manager operationId], description, longitude, latitude);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createQuoteMessage:(NSString *)text
                               message:(OIMMessageInfo *)message {
    NSString *json = Open_im_sdkCreateQuoteMessage([OIMManager.manager operationId], text, message.mj_JSONString);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createCardMessage:(NSString *)content {
    NSString *json = Open_im_sdkCreateCardMessage([OIMManager.manager operationId], content);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

+ (OIMMessageInfo *)createCustomMessage:(NSString *)data
                              extension:(NSString *)extension
                            description:(NSString *)description {
    NSString *json = Open_im_sdkCreateCustomMessage([OIMManager.manager operationId], data, extension, description);
    return [OIMMessageInfo mj_objectWithKeyValues:json];
}

@end

@implementation OIMManager (Message)

- (void)sendMessage:(OIMMessageInfo *)message
             recvID:(NSString *)recvID
            groupID:(NSString *)groupID
    offlinePushInfo:(OIMOfflinePushInfo *)offlinePushInfo
          onSuccess:(OIMSuccessCallback)onSuccess
         onProgress:(OIMNumberCallback)onProgress
          onFailure:(OIMFailureCallback)onFailure {
    SendMessageCallbackProxy *callback = [[SendMessageCallbackProxy alloc]initWithOnSuccess:onSuccess onProgress:onProgress onFailure:onFailure];
    
    Open_im_sdkSendMessage(callback, [self operationId], message.mj_JSONString, recvID ?: @"", groupID ?: @"", offlinePushInfo ? offlinePushInfo.mj_JSONString : @"{}");
}

- (void)sendMessageNotOss:(OIMMessageInfo *)message
                   recvID:(NSString *)recvID
                  groupID:(NSString *)groupID
          offlinePushInfo:(OIMOfflinePushInfo *)offlinePushInfo
                onSuccess:(OIMSuccessCallback)onSuccess
               onProgress:(OIMNumberCallback)onProgress
                onFailure:(OIMFailureCallback)onFailure {
    SendMessageCallbackProxy *callback = [[SendMessageCallbackProxy alloc]initWithOnSuccess:onSuccess onProgress:onProgress onFailure:onFailure];
    
    Open_im_sdkSendMessageNotOss(callback, [self operationId], message.mj_JSONString, recvID, groupID, offlinePushInfo.mj_JSONString);
}

- (void)getHistoryMessageListWithUserId:(NSString *)userID
                                groupID:(NSString *)groupID
                       startClientMsgID:(NSString *)startClientMsgID
                                  count:(NSInteger)count
                              onSuccess:(OIMMessagesInfoCallback)onSuccess
                              onFailure:(OIMFailureCallback)onFailure {
    
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:^(NSString * _Nullable data) {
        if (onSuccess) {
            onSuccess([OIMMessageInfo mj_objectArrayWithKeyValuesArray:data]);
        }
    } onFailure:onFailure];
    
    NSDictionary *param = @{@"userID": userID ?: @"",
                            @"groupID": groupID ?: @"",
                            @"startClientMsgID": startClientMsgID ?: @"",
                            @"count": @(count)};
    Open_im_sdkGetHistoryMessageList(callback, [self operationId], param.mj_JSONString);
}

- (void)revokeMessage:(OIMMessageInfo *)message
            onSuccess:(OIMSuccessCallback)onSuccess
            onFailure:(OIMFailureCallback)onFailure {
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:onSuccess onFailure:onFailure];
    
    Open_im_sdkRevokeMessage(callback, [self operationId], message.mj_JSONString);
}

- (void)typingStatusUpdate:(NSString *)recvID
                    msgTip:(NSString *)msgTip
                 onSuccess:(OIMSuccessCallback)onSuccess
                 onFailure:(OIMFailureCallback)onFailure {
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:onSuccess onFailure:onFailure];
    
    Open_im_sdkTypingStatusUpdate(callback, [self operationId], recvID, msgTip);
}

- (void)markC2CMessageAsRead:(NSString *)userID
                   msgIDList:(NSArray<NSString *> *)msgIDList
                   onSuccess:(OIMSuccessCallback)onSuccess
                   onFailure:(OIMFailureCallback)onFailure {
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:onSuccess onFailure:onFailure];
    
    Open_im_sdkMarkC2CMessageAsRead(callback, [self operationId], userID, msgIDList.mj_JSONString);
}

- (void)deleteMessageFromLocalStorage:(OIMMessageInfo *)message
                            onSuccess:(OIMSuccessCallback)onSuccess
                            onFailure:(OIMFailureCallback)onFailure {
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:onSuccess onFailure:onFailure];
    
    Open_im_sdkDeleteMessageFromLocalStorage(callback, [self operationId], message.mj_JSONString);
}

- (void)clearC2CHistoryMessage:(NSString *)userID
                     onSuccess:(OIMSuccessCallback)onSuccess
                     onFailure:(OIMFailureCallback)onFailure {
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:onSuccess onFailure:onFailure];
    
    Open_im_sdkClearC2CHistoryMessage(callback, [self operationId], userID);
}

- (void)clearGroupHistoryMessage:(NSString *)groupID
                       onSuccess:(OIMSuccessCallback)onSuccess
                       onFailure:(OIMFailureCallback)onFailure {
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:onSuccess onFailure:onFailure];
    
    Open_im_sdkClearGroupHistoryMessage(callback, [self operationId], groupID);
}

- (void)insertSingleMessageToLocalStorage:(OIMMessageInfo *)message
                                   recvID:(NSString *)recvID
                                   sendID:(NSString *)sendID
                                onSuccess:(OIMSuccessCallback)onSuccess
                                onFailure:(OIMFailureCallback)onFailure {
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:onSuccess onFailure:onFailure];
    
    Open_im_sdkInsertSingleMessageToLocalStorage(callback, [self operationId], message.mj_JSONString, recvID, sendID);
}

- (void)insertGroupMessageToLocalStorage:(OIMMessageInfo *)message
                                 groupID:(NSString *)groupID
                                  sendID:(NSString *)sendID
                               onSuccess:(OIMSuccessCallback)onSuccess
                               onFailure:(OIMFailureCallback)onFailure {
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:onSuccess onFailure:onFailure];
    
    Open_im_sdkInsertGroupMessageToLocalStorage(callback, [self operationId], message.mj_JSONString, groupID, sendID);
}

- (void)searchLocalMessages:(OIMSearchParam *)param
                  onSuccess:(OIMMessageSearchCallback)onSuccess
                  onFailure:(OIMFailureCallback)onFailure {
    CallbackProxy *callback = [[CallbackProxy alloc]initWithOnSuccess:^(NSString * _Nullable data) {
        if (onSuccess) {
            onSuccess([OIMSearchResultInfo mj_objectWithKeyValues:data]);
        }
    } onFailure:onFailure];
    
    Open_im_sdkSearchLocalMessages(callback, [self operationId], param.mj_JSONString);
}
@end
