//
//  DBAccess.m
//  Reader
//
//  Created by juju on 2017/2/28.
//  Copyright © 2017年 juju. All rights reserved.
//

#import "DBAccess.h"
sqlite3 *database;

@implementation DBAccess

- (id)init {
    
    if (self = [super init]) {
        
        [self initializeDatabase];
    }
    
    return self;
}

- (void)initializeDatabase {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Database" ofType:@"db"];
    
    if (sqlite3_open(path.UTF8String, &database) == SQLITE_OK) {
        
        NSLog(@"数据库打开了");
    } else {
        
        sqlite3_close(database);
        
        NSAssert1(0, @"打开失败：'%s'", sqlite3_errmsg(database));
    }
}

- (void)closeDatabase {
    
    if (sqlite3_close(database) == SQLITE_OK) {
        
        NSAssert1(0, @"打开数据库失败：'%s'", sqlite3_errmsg(database));
    }
}

- (NSString *)getContentById:(NSInteger)Id {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM PASSAGE WHERE ID = %ld",(long)Id];
    
    sqlite3_stmt *stmt;
    
    NSString *content = @"";
    
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            char *passage = (char *)sqlite3_column_text(stmt, 1);
            
            content = [[NSString alloc] initWithUTF8String:passage];
        }
    }
    
    return content;
    
}

- (NSMutableArray *)getTitle {
    
    NSString *sql = @"SELECT * FROM PASSAGE";
    
    sqlite3_stmt *stmt;
    
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            char *title = (char *)sqlite3_column_text(stmt, 2);
            
            NSString *titleString = [[NSString alloc] initWithUTF8String:title];
            
            [titleArray addObject:titleString];
        }
    }
    
    return titleArray;
}

- (NSString *)getLevelByWords:(NSString *)word {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM WORDS WHERE WORD = %@", word];;
    
    sqlite3_stmt *stmt;
    
    NSString *level = @"";
    
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            char *levelWord = (char *)sqlite3_column_text(stmt, 3);
            
            level = [[NSString alloc] initWithUTF8String:levelWord];
        }
    }
    
    return level;
    
}

- (NSMutableArray *)getWordByLesson:(NSInteger)lesson {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM WORDS WHERE LESSON = %ld",(long)lesson];
    
    sqlite3_stmt *stmt;
    
    NSMutableArray *wordArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            char *word = (char *)sqlite3_column_text(stmt, 1);
            
            NSString *wordString = [[NSString alloc] initWithUTF8String:word];
            
            [wordArray addObject:wordString];
        }
    }
    
    return wordArray;
    
}

- (NSMutableArray *)getWordByLevel:(NSInteger)level {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM WORDS WHERE LEVEL = %ld", (long)level];
    
    sqlite3_stmt *stmt;
    
    NSMutableArray *wordArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            char *word = (char *)sqlite3_column_text(stmt, 1);
            
            NSString *wordString = [[NSString alloc] initWithUTF8String:word];
            
            [wordArray addObject:wordString];
        }
    }
    
    return wordArray;
}

- (NSMutableArray *)getWordByLevelDown:(NSInteger)level {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM WORDS WHERE LEVEL <= %ld", (long)level];
    
    sqlite3_stmt *stmt;
    
    NSMutableArray *wordArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            char *word = (char *)sqlite3_column_text(stmt, 1);
            
            NSString *wordString = [[NSString alloc] initWithUTF8String:word];
            
            [wordArray addObject:wordString];
        }
    }
    
    return wordArray;
}
@end
