//
//  OIMUserInfo.h
//  OpenIMSDK
//
//  Created by x on 2022/2/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///个人信息，所有信息都包括
///
@interface OIMUserInfo : NSObject

@property(nonatomic, nullable, copy) NSString *userID;
@property(nonatomic, nullable, copy) NSString *nickname;
@property(nonatomic, nullable, copy) NSString *faceURL;
@property(nonatomic, nullable, strong) NSNumber *gender;
@property(nonatomic, nullable, copy) NSString *phoneNumber;
@property(nonatomic, nullable, strong) NSNumber *birth;
@property(nonatomic, nullable, copy) NSString *email;
@property(nonatomic, assign) NSInteger createTime;
@property(nonatomic, nullable, copy) NSString *ex;

@end

NS_ASSUME_NONNULL_END
