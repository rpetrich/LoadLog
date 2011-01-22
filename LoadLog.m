#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>

@interface NSThread (OS40)
+ (NSArray *)callStackSymbols;
@end

static void add_image_callback(const struct mach_header* mh, intptr_t vmaddr_slide)
{
	uint32_t count = _dyld_image_count();
	for (uint32_t i = 0; i < count; i++) {
		if (mh == _dyld_get_image_header(i)) {
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			NSLog(@"LoadLog: %s at %p loaded via %@", _dyld_get_image_name(i), mh, [NSThread callStackSymbols]);	
			[pool drain];
			return;
		}
	}
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"LoadLog: (unknown) at %p loaded via %@", mh, [NSThread callStackSymbols]);	
	[pool drain];
}

__attribute__((constructor))
static void constructor()
{
	_dyld_register_func_for_add_image(add_image_callback);
}
