/*
* This header is generated by classdump-dyld 1.0
* on Thursday, January 25, 2018 at 11:20:40 PM Eastern European Standard Time
* Operating System: Version 11.1.2 (Build 15B202)
* Image Source: /System/Library/Frameworks/Foundation.framework/Foundation
* classdump-dyld is licensed under GPLv3, Copyright © 2013-2016 by Elias Limneos.
*/


@protocol NSISRowBody <NSObject>
@required
-(unsigned long long)variableCount;
-(void)removeVariable:(id)arg1;
-(void)replaceVariable:(id)arg1 withVariablePlusDelta:(double)arg2 timesVariable:(id)arg3 processVariableNewToReceiver:(/*^block*/id)arg4 processVariableDroppedFromReceiver:(/*^block*/id)arg5;
-(void)enumerateVariables:(/*^block*/id)arg1;
-(void)replaceVariable:(id)arg1 withVariablePlusDelta:(double)arg2;
-(void)replaceVariable:(id)arg1 withExpression:(id)arg2 processVariableNewToReceiver:(/*^block*/id)arg3 processVariableDroppedFromReceiver:(/*^block*/id)arg4;

@end

