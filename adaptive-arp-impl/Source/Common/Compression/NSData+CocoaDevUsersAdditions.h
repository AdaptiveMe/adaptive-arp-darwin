//
// From http://www.cocoadev.com/index.pl?NSDataCategory
//

#import <Foundation/Foundation.h>

@interface NSData (NSDataExtension)

- (NSData *) gzipInflate;
- (NSData *) gzipDeflate;

@end
