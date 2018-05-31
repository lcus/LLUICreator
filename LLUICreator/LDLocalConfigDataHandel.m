
#import "LDLocalConfigDataHandel.h"

@implementation LDLocalConfigDataHandel


+(NSArray*)LD_getLocalDataWithFiele:(NSString *)file fileKey:(NSString *)fileKey valueKey:(NSString *)valueKey{
    
    
    NSArray *datArray =[self LD_getLocalDataWithFile:file key:fileKey];
    
    return [self LD_instertToMutialValue:datArray key:valueKey];
    
}

+(NSArray*)LD_instertToMutialValue:(NSArray *)data keys:(NSArray<NSString *> *)keys{
    
    if (!(data.count>0)||keys==nil||!(keys.count>0)) return nil;
    
    NSMutableArray *result =@[].mutableCopy;
    
    
    if ([[data[0] class] isKindOfClass:[NSArray class]]||[[data[0] class] isSubclassOfClass:[NSArray class]]) {
        
        for (NSArray *temparray in data) {
            
            NSArray *data =[self _inserKeysWithData:temparray keys:keys];
            
            [result addObject:data];
        }
        return result;
    }
    
    result =[self _inserKeysWithData:data keys:keys];

    return result;
}




+(NSArray*)LD_instertToMutialValue:(NSArray *)data key:(NSString *)keyPath{
    
    if (!(data.count>0)||keyPath==nil) return nil;
    
    NSMutableArray *result =@[].mutableCopy;
    
    
    if ([[data[0] class] isKindOfClass:[NSArray class]]||[[data[0] class] isSubclassOfClass:[NSArray class]]) {
        
        for (NSArray *temparray in data) {

            NSArray *data =[self _sinleInsertWithData:temparray keyPath:keyPath];
            
            [result addObject:data];
        }
        return result;
    }
    
    result =[self _sinleInsertWithData:data keyPath:keyPath];
    
    return result;
}

+(NSArray*)LD_enumItemToMutial:(NSArray *)data{
    
    return [self _singleCopyWithData:data];
}

+(NSArray*)LD_getLocalDataWithFile:(NSString*)file key:(NSString*)key{
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:@"json"]];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    return dict[key];
};

+(NSArray*)LD_handelData:(NSArray<NSArray*>*)data jsonData:(NSDictionary*)json keyPath:(NSString*)keyPath{
    

    
    NSMutableArray *mutdata =[self _mutiCopyWithData:data];
    
    [self _modData:mutdata json:json keyPath:keyPath];
    
    return mutdata;
}

+(void)_modData:(NSArray*)data json:(NSDictionary*)json keyPath:(NSString*)keyPath{
    
    //    if (!data.count||!json.count) return;
        [data enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
            [obj enumerateObjectsUsingBlock:^(NSMutableDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
    
    
                NSString *keyPathValue = dict[keyPath];
    
                NSString *safeValue = json[keyPathValue]?json[keyPathValue]:[NSNull null];
    
                [dict setValue:safeValue forKey:keyPath];
    
            }];
    
        }];
}

+(NSMutableArray*)_mutiCopyWithData:(NSArray<NSArray*>*)data{

    NSMutableArray *sectiondataArray =@[].mutableCopy;


    
    for (NSArray *tempArry in data) {
        NSMutableArray *itemsDataArray =@[].mutableCopy;
        for (NSDictionary *item in tempArry) {

            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:item];

            [itemsDataArray addObject:dict];

        }
        [sectiondataArray addObject:itemsDataArray];
    }

    return sectiondataArray;
}

+(NSMutableArray*)_singleCopyWithData:(NSArray*)data{
    
    NSMutableArray *itemsDataArray =@[].mutableCopy;
    for (NSDictionary *dict in data) {
        
        [itemsDataArray addObject:[NSMutableDictionary dictionaryWithDictionary:dict]];
        
    }
    return itemsDataArray;
}

+(NSMutableArray*)_sinleInsertWithData:(NSArray*)data keyPath:(NSString*)keyPath{
    
    return [self _inserKeysWithData:data keys:@[keyPath]];
}
//根据key插入值为NSMutableString
+(NSMutableArray*)_inserKeysWithData:(NSArray*)data keys:(NSArray<NSString*>*)keys{
    
    NSMutableArray *items =@[].mutableCopy;
    
    for (NSDictionary *dict in data) {
        
        NSMutableDictionary *temp = dict.mutableCopy;
        
        for (NSString *tempKey in keys) {
            
            [temp setObject:[NSMutableString string] forKey:tempKey];
        }
        
        [items addObject:temp];
    }
    
    return items;
}


@end
