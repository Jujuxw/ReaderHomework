//
//  DBAccess.h
//  Reader
//
//  Created by juju on 2017/2/28.
//  Copyright © 2017年 juju. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@interface DBAccess : NSObject

- (NSString *)getContentById: (NSInteger)Id;

- (NSMutableArray *)getTitle;

- (NSString *)getLevelByWords: (NSString *)word;

- (NSMutableArray *)getWordByLesson: (NSInteger)lesson;

- (NSMutableArray *)getWordByLevel: (NSInteger)level;

- (NSMutableArray *)getWordByLevelDown: (NSInteger)level;

- (void)closeDatabase;

- (void)initializeDatabase;

@end
