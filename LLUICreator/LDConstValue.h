//
//  LDConstValue.h
//  SingleTest
//
//  Created by lcus on 2018/4/2.
//  Copyright © 2018年 lcus. All rights reserved.
//

#ifndef LDConstValue_h
#define LDConstValue_h


#ifdef DEBUG
#define LDLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LDLog(...)
#endif

#define LDWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LDStrongSelf(type)  __strong typeof(type) type = weak##type;

#define LDLOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#define LDUNLOCK(lock) dispatch_semaphore_signal(lock);

#define LDDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LDRadianToDegrees(radian) (radian*180.0)/(M_PI)

#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

#define LDSCREENWIDTH    [UIScreen mainScreen].bounds.size.width
#define LDSCREENHEIGHT   [UIScreen mainScreen].bounds.size.height

#define d_size(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)

#define CellMarginSpace d_size(15)
#define SepLineHeight d_size(0.5)
#define SepLineColor [UIColor colorWithRed:0.82 green:0.81 blue:0.83 alpha:1.00]

#endif /* LDConstValue_h */
