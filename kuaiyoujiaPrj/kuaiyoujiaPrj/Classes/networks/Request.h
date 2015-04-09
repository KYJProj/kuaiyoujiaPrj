//
//  Request.h
//  kyjlandlord
//
//  Created by TTc on 15-3-9.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//


#import "GCDAsyncSocket.h"
typedef void(^rsqBlock)(id rspObject);

@interface Request : NSObject<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *asyncSocket;
}
@property (nonatomic, strong) rsqBlock callBack;
@property(strong,nonatomic)NSString *flag;
@property(assign,nonatomic)UInt8 version;
@property(assign,nonatomic)short command;
@property(assign,nonatomic)short  statusCode;
@property(assign,nonatomic)int  contentLength;
@property(strong,nonatomic)NSData *content;
-(instancetype)init;
-(void)asyncExecute:(NSDictionary*)parm callBack:(rsqBlock)callBack;
-(void)disConnectSocket;
-(void)connectSocket;
-(NSData*)packagingSocketMessage;
short getStatusCode(NSData* data);
int getContentLength(NSData* data);
-(void)fromJson:(id)jsonDict;
-(void)asyncExecute:(rsqBlock)callBack;
@end
