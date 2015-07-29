//
//  UIScrollView+EmptyDataSet.h
//  DZNEmptyDataSet
//  https://github.com/dzenbot/DZNEmptyDataSet
//
//  Created by Ignacio Romero Zurbuchen on 6/20/14.
//  Copyright (c) 2014 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//

#import <UIKit/UIKit.h>

@protocol DZNEmptyDataSetSource;
@protocol DZNEmptyDataSetDelegate;

/**
 A drop-in UITableView/UICollectionView superclass category for showing empty datasets whenever the view has no content to display.
 @discussion It will work automatically, by just conforming to DZNEmptyDataSetSource, and returning the data you want to show.
 
 超类类别显示空数据集每当视图中没有要显示的内容。
 它会自动工作,只要符合DZNEmptyDataSetSource,并返回你想要显示的数据。
 */
@interface UIScrollView (EmptyDataSet)

/** The empty datasets data source. */
@property (nonatomic, weak) IBOutlet id <DZNEmptyDataSetSource> emptyDataSetSource;
/** The empty datasets delegate. */
@property (nonatomic, weak) IBOutlet id <DZNEmptyDataSetDelegate> emptyDataSetDelegate;
/** YES if any empty dataset is visible. */
@property (nonatomic, readonly, getter = isEmptyDataSetVisible) BOOL emptyDataSetVisible;

/**
 Reloads the empty dataset content receiver.
 @discussion Call this method to force all the data to refresh. Calling -reloadData is similar, but this forces only the empty dataset to reload, not the entire table view or collection view.
 刷新数据
 */
- (void)reloadEmptyDataSet;

@end


/**
 The object that acts as the data source of the empty datasets.
 @discussion The data source must adopt the DZNEmptyDataSetSource protocol. The data source is not retained. All data source methods are optional.
 
 数据源必须采用DZNEmptyDataSetSource协议。数据源不保留。所有数据源方法是可选的。
 */
@protocol DZNEmptyDataSetSource <NSObject>
@optional

/**
 Asks the data source for the title of the dataset.
 The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
 
 @param scrollView A scrollView subclass informing the data source.
 @return An attributed string for the dataset title, combining font, text color, text pararaph style, etc.
 
 数据集使用一个固定的字体样式在默认情况下,如果没有属性设置。如果你想要一个不同的字体样式,返回一个字符串。
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView;

/**
 Asks the data source for the description of the dataset.
 The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
 
 @param scrollView A scrollView subclass informing the data source.
 @return An attributed string for the dataset description text, combining font, text color, text pararaph style, etc.
 数据集使用一个固定的字体样式在默认情况下,如果没有属性设置。如果你想要一个不同的字体样式,返回一个字符串。
 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView;

/**
 Asks the data source for the image of the dataset.
 
 @param scrollView A scrollView subclass informing the data source.
 @return An image for the dataset.
 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView;

/**
 Asks the data source for a tint color of the image dataset. Default is nil.
 
 @param scrollView A scrollView subclass object informing the data source.
 @return A color to tint the image of the dataset.
 */
- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView;

/**
 Asks the data source for the title to be used for the specified button state.
 The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
 
 @param scrollView A scrollView subclass object informing the data source.
 @param state The state that uses the specified title. The possible values are described in UIControlState.
 @return An attributed string for the dataset button title, combining font, text color, text pararaph style, etc.
 */
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

/**
 Asks the data source for the image to be used for the specified button state.
 This method will override buttonTitleForEmptyDataSet:forState: and present the image only without any text.
 
 @param scrollView A scrollView subclass object informing the data source.
 @param state The state that uses the specified title. The possible values are described in UIControlState.
 @return An image for the dataset button imageview.
 */
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

/**
 Asks the data source for a background image to be used for the specified button state.
 There is no default style for this call.
 
 @param scrollView A scrollView subclass informing the data source.
 @param state The state that uses the specified image. The values are described in UIControlState.
 @return An attributed string for the dataset button title, combining font, text color, text pararaph style, etc.
 */
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

/**
 Asks the data source for the background color of the dataset. Default is clear color.
 
 @param scrollView A scrollView subclass object informing the data source.
 @return A color to be applied to the dataset background view.
 */
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView;

/**
 Asks the data source for a custom view to be displayed instead of the default views such as labels, imageview and button. Default is nil.
 Use this method to show an activity view indicator for loading feedback, or for complete custom empty data set.
 Returning a custom view will ignore -offsetForEmptyDataSet and -spaceHeightForEmptyDataSet configurations.
 
 @param scrollView A scrollView subclass object informing the delegate.
 @return The custom view.
 */
    //自定义的
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView;

/**
 Asks the data source for a offset for vertical and horizontal alignment of the content. Default is CGPointZero.
 
 @param scrollView A scrollView subclass object informing the delegate.
 @return The offset for vertical and horizontal alignment.
 */
//图片文字的坐标
- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView;

/**
 Asks the data source for a vertical space between elements. Default is 11 pts.
 
 @param scrollView A scrollView subclass object informing the delegate.
 @return The space height between elements.
 */
//图片距离文字的距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView;

@end


/**
 The object that acts as the delegate of the empty datasets.
 @discussion The delegate can adopt the DZNEmptyDataSetDelegate protocol. The delegate is not retained. All delegate methods are optional.
 
 @discussion All delegate methods are optional. Use this delegate for receiving action callbacks.
 */
@protocol DZNEmptyDataSetDelegate <NSObject>
@optional

/**
 Asks the delegate to know if the empty dataset should be rendered and displayed. Default is YES.
 
 @param scrollView A scrollView subclass object informing the delegate.
 @return YES if the empty dataset should show.
 
 要求代表知道空的数据集应该渲染和显示。默认是肯定的
 */
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView;

/**
 Asks the delegate for touch permission. Default is YES.
 
 @param scrollView A scrollView subclass object informing the delegate.
 @return YES if the empty dataset receives touch gestures.
 
 问权限的委托联系。默认是肯定的。
 */
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView;

/**
 Asks the delegate for scroll permission. Default is NO.
 
 @param scrollView A scrollView subclass object informing the delegate.
 @return YES if the empty dataset is allowed to be scrollable.
 
 滚动的委托权限问道。默认是否定的。
 */
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView;

/**
 Tells the delegate that the empty dataset view was tapped.
 Use this method either to resignFirstResponder of a textfield or searchBar.
 
 @param scrollView A scrollView subclass informing the delegate.
 
 告诉空的代表数据集的观点了。
 
 使用这种方法resignFirstResponder的文本框或searchBar。

 */
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView;

/**
 Tells the delegate that the action button was tapped.
 
 @param scrollView A scrollView subclass informing the delegate.
 
 讲述了委托,操作按钮了。
 */
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView;

/**
 Tells the delegate that the empty data set will appear.

 @param scrollView A scrollView subclass informing the delegate.
 
 告诉委托,空的数据集将会出现。
 */
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView;

/**
 Tells the delegate that the empty data set did appear.

 @param scrollView A scrollView subclass informing the delegate.
 
 告诉的代表出现了空的数据集。
 */
- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView;

/**
 Tells the delegate that the empty data set will disappear.

 @param scrollView A scrollView subclass informing the delegate.
 
 告诉委托,空的数据集将会消失。
 */
- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView;

/**
 Tells the delegate that the empty data set did disappear.

 @param scrollView A scrollView subclass informing the delegate.
 
 告诉空的代表数据集也消失了。
 */
- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView;

@end
