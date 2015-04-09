//
//  Request.m
//  kyjlandlord
//
//  Created by TTc on 15-3-9.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//



#import "Request.h"
@implementation Request
- (instancetype)init
{
    if(!(self = [super init]))
        return nil;
    self.flag = SYS_FLAG;
    self.version = VERSION;
    self.statusCode = STATUS_CODE_OK;
    self.command = -1;
    self.contentLength = -1;
    self.content = nil;
    dispatch_queue_t  queue=  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    asyncSocket= [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:queue];
    return self;
}
-(void)asyncExecute:(NSDictionary*)parm callBack:(rsqBlock)callBack
{
    self.callBack = callBack;
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    [tempDict setObject:@"com.kaiyoujia.rent" forKey:PAGEAGE_ID];
    [tempDict setObject:@"1" forKey:VERSION_CODE];
    [tempDict setObject:@"V1.0" forKey:VERSION_NAME];
    [tempDict setObject:@"2" forKey:PLATFORM];
    NSMutableDictionary *extraDict = [NSMutableDictionary dictionary];
    [extraDict setObject:tempDict forKey:@"extra"];
    [extraDict addEntriesFromDictionary:parm];
    self.content = [extraDict JSONData];
    self.contentLength = (int)[[extraDict JSONData] length];
    [self connectSocket];
}
-(NSString *)getFlag:(NSData*)data
{
    NSData *msgFlagData = [data subdataWithRange:NSMakeRange(0, 5)];
    NSString *flagStr = [[NSString alloc]initWithData:msgFlagData encoding:NSUTF8StringEncoding] ;
    return flagStr;
}
-(UInt8)getVersion:(NSData*)data
{
    UInt8 msgVersion  = -1;
    NSData *msgVersionData = [data subdataWithRange:NSMakeRange(5,1)];
    [msgVersionData getBytes:&msgVersion length:sizeof(UInt8)];
    return msgVersion;
}
short getCommandType(NSData* data){
    // 2 byte
    NSData *msgTypeData = [data subdataWithRange:NSMakeRange(6,2)];
    short msgType  = -1;
    [msgTypeData getBytes:&msgType length:sizeof(short)];
    msgType = ntohs(msgType);
    return msgType;
}
short getStatusCode(NSData* data){
    //2byte
    NSData *statusCodeData = [data subdataWithRange:NSMakeRange(8,2)];
    short statusCode  = -1;
    [statusCodeData getBytes:&statusCode length:sizeof(short)];
    statusCode = ntohs(statusCode);
    return statusCode;
}
int getContentLength(NSData* data){
    //4 byte
    NSData *contentLengthData = [data subdataWithRange:NSMakeRange(10,4)];
    int contentLength = -1;
    [contentLengthData getBytes: &contentLength length: sizeof(int)];
    contentLength =ntohl(contentLength);
    return contentLength;
}
NSString* getContent(NSData* data){
    NSData *msgContentData = [data subdataWithRange:NSMakeRange(14,[data length]-14)];
    NSString *jsonStr = [[NSString alloc]initWithData:msgContentData encoding:NSUTF8StringEncoding];
    return jsonStr;
}
-(NSData*)packagingSocketMessage
{
    NSData *msgFlagData = [_flag dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 msgVersion = _version;
    NSData *msgVersionData = [NSData dataWithBytes: &msgVersion length: sizeof(msgVersion)];
    short msgType = htons(_command);
    NSData *msgTypeData  = [NSData dataWithBytes: &msgType length: sizeof(msgType)];
    short msgReturnCode =htons(_statusCode);
    NSData *msgReturnCodeData  = [NSData dataWithBytes: &msgReturnCode length: sizeof(msgReturnCode)];
    
    int msgLength = htonl(_contentLength);
    NSData *msgLengthData  = [NSData dataWithBytes: &msgLength length: sizeof(msgLength)];
    NSMutableData *data = [NSMutableData data];
    [data appendData:msgFlagData];
    [data appendData:msgVersionData];
    [data appendData:msgTypeData];
    [data appendData:msgReturnCodeData];
    [data appendData:msgLengthData];
    [data appendData:_content];
    NSData *sendData = [[NSData alloc]initWithData:data];
    return sendData;
}
-(id)paserSocketMessage:(NSData*)data{
    short statusCode = getStatusCode(data);
    if(0 != statusCode){
        //error  update UI
        return [NSNumber numberWithShort:statusCode];
    }else {
        NSString *jsonStr = getContent(data);
        id json = [jsonStr objectFromJSONString];
        return json;
    }
}
-(void)fromJson:(id)jsonDict{
    
}
-(void)asyncExecute:(rsqBlock)callBack
{
    
}
- (void)disConnectSocket
{
    if ([asyncSocket isConnected])
    {
        [asyncSocket disconnect];
    }
}
-(void)connectSocket
{
    NSError *error = nil;
    if (![asyncSocket connectToHost:HOST onPort:PORT error:&error]) {
    }
    else {
    }
}
#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSData *sendData = [self packagingSocketMessage];
    NSAssert(sendData != nil, @"sendData = nil!");
    [asyncSocket writeData:[sendData mutableCopy]withTimeout:SOCKET_ALL_TIMEOUT tag:SOCKET_TOPIC_MSG];
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [sock readDataToLength:14 withTimeout:SOCKET_ALL_TIMEOUT tag:SOCKET_HEAD];
}
- (void)socketDidCloseReadStream:(GCDAsyncSocket *)sock
{
    if(self.callBack){
        self.callBack([NSNumber numberWithInt:SOCKET_ERROR_CLOSE]);
    }
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)error
{
    if(self.callBack && !IsNilOrNull(error)){
        self.callBack([NSNumber numberWithInt:SOCKET_ERROR]);
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSAssert(data != nil, @"Data = nil");
    if(tag == SOCKET_HEAD)
    {
        short statusCode = getStatusCode(data);
        if(0 != statusCode){
            if(self.callBack){
                self.callBack([NSNumber numberWithShort:statusCode]);
            }
            [self disConnectSocket];
            return;
        }
        int length = getContentLength(data);
        [sock readDataToLength:length withTimeout:SOCKET_ALL_TIMEOUT tag:SOCKET_BODY];
    }
    else if(tag == SOCKET_BODY)
    {
        NSData *msgContentData = [data subdataWithRange:NSMakeRange(0,[data length])];
        NSString *jsonStr = [[NSString alloc]initWithData:msgContentData encoding:NSUTF8StringEncoding];
        id jsonObj = [jsonStr objectFromJSONString];
        if([jsonObj isKindOfClass:[NSDictionary class]]){
            id result = [jsonObj objectForKey:@"result"];
            [self fromJson:result];
        }
        [self disConnectSocket];
    }
    else
    {
        //other
    }
}
@end
