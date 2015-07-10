

extern NSString* const soundKlick;
extern NSString* const soundFlag;
extern NSString* const soundSelect;
extern NSString* const soundWin;
extern NSString* const soundLoose;

extern NSString* const kLeaderBoard;








#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )




#define iPad    UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define HEIGHT_CROSS         (iPad ? 30.0f : 20.0f)

#define HEIGHT_BANNER        (iPad ? 90.0f : 50.0f)

#define HEIGHT_BANNERiAD        (iPad ? 66.0f : 50.0f)

#define HEIGHT_CROSS_AND_BANNER        (iPad ? 120.0f : 70.0f)
