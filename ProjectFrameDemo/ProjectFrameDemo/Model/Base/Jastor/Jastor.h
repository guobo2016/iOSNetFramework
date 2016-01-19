//
//  Jastor.h
//  Jastor
//
//  Created by Elad Ossadon on 12/14/11.
//  http://devign.me | http://elad.ossadon.com | http://twitter.com/elado
//

@interface Jastor : NSObject <NSCoding>

@property (nonatomic, copy) NSString *objectId;
/**
 *  解析字典
 */
+ (id)objectFromDictionary:(NSDictionary*)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;
/**
 *  解析数组
 */
+ (id)objectFromArray:(NSArray*)array;
- (id)initWithArray:(NSArray *)array;

- (NSMutableDictionary *)toDictionary;
/**
 *  model与json的映射
 *
 *  @return key:model的属性  value:json的节点名
 */
-(NSDictionary*)attrMapDict;

@end
