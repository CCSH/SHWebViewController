//
//  SHPopMenu.m
//  SHPopMenuDemo
//
//  Created by hh on 15/12/22.
//  Copyright © 2015年 陈胜辉. All rights reserved.
//

#import "SHPopMenu.h"

/**
 *  下拉菜单
 **/
@interface SHPopMenu()<UITableViewDataSource,UITableViewDelegate>

/**
 内容展示
 */
@property (nonatomic, strong) UITableView *contentView;
/**
 最底部的遮盖 ：屏蔽除菜单以外控件的事件
 */
@property (nonatomic, weak) UIButton *cover;
/**
 容器 ：容纳具体要显示的内容contentView
 */
@property (nonatomic, weak) UIView *container;
/**
 箭头
 **/
@property (nonatomic, weak) UIImageView *imageArrow;

@property (nonatomic, assign) void(^block)(SHPopMenu *menu,NSInteger index);

@end

@implementation SHPopMenu

static NSString *reuseIdentifier = @"cell";

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cover.frame = self.bounds;
}

#pragma mark - 懒加载
- (UITableView *)contentView{
    //创建tabview
    if (!_contentView) {
        _contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        _contentView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.scrollEnabled = NO;
        _contentView.bounces = YES;
        _contentView.showsVerticalScrollIndicator = NO;
        //内容
        [self.container addSubview:_contentView];
    }
    return _contentView;
}

- (UIButton *)cover{
    if (!_cover) {
        // 添加一个遮盖按钮
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        _cover = cover;
    }
    return _cover;
}

- (UIView *)container{
    if (!_container) {
        // 添加背景
        UIView *container = [[UIView alloc] init];
        container.backgroundColor = [UIColor whiteColor];
        container.layer.cornerRadius = 5;
        container.layer.borderWidth = 1;
        container.layer.borderColor = [UIColor clearColor].CGColor;
        container.userInteractionEnabled = YES;
        [self addSubview:container];
        _container = container;
    }
    return _container;
}

- (UIImageView *)imageArrow{
    if (!_imageArrow) {
        //箭头
        UIImageView *imageArrow = [[UIImageView alloc]init];
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        NSString *file = [bundle pathForResource:@"popu_arrow" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        imageArrow.image = image;
        [self addSubview:imageArrow];
        _imageArrow = imageArrow;
    }
    return _imageArrow;
}

- (void)setMList:(NSArray *)mList{
    _mList = mList;
    
    //计算宽度
    self.menuW = 0.0;
    for (id obj in mList) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {//文字 + 图片
            
            NSDictionary *dic = (NSDictionary *)obj;
            CGSize size = [dic.allValues[0] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)  options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            //宽度(文字 + 图片 + 左右的间距)
            self.menuW = MAX(size.width + 75, self.menuW);
            
        }else if ([obj isKindOfClass:[NSString class]]){//文字
            
            CGSize size = [obj boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            //宽度(文字 + 左右的间距)
            self.menuW = MAX(size.width + 40, self.menuW);
            
        }else if ([obj isKindOfClass:[NSAttributedString class]]){//富文本
            NSAttributedString *att = (NSAttributedString *)obj;
            CGSize size = [att boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            //宽度(文字 + 左右的间距)
            self.menuW = MAX(size.width + 40, self.menuW);
        }
    }
}

#pragma mark - 内部方法
- (void)coverClick
{
    [self dismiss];
}

#pragma mark - 公共方法
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    } else {
        self.cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
}

- (void)showInRectX:(int)x rectY:(int)y block:(void (^)(SHPopMenu *, NSInteger))block;
{
    //赋值
    self.block = block;
    
    // 添加菜单整体到窗口身上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    // 设置容器的frame
    long count = self.mList.count;
    long height = self.contentH*count;
    
    CGFloat max_h = self.superview.frame.size.height - y - 7 - 50;
    
    if (height > max_h) {
        height = max_h;
        self.contentView.scrollEnabled = YES;
    }

    self.container.frame = CGRectMake(x , y + 6.5, self.menuW, height);
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 2;
    CGFloat leftMargin = 2;
    CGFloat rightMargin = 2;
    CGFloat bottomMargin = 2;
    CGRect frame;
    frame.origin.y = topMargin;
    frame.origin.x = leftMargin;
    frame.size.width = self.container.frame.size.width - leftMargin - rightMargin;
    frame.size.height = self.container.frame.size.height - topMargin - bottomMargin;
    self.contentView.frame = frame;
    
    //设置箭头frame
    switch (_arrowPosition) {
        case SHPopMenuArrowPositionLeft://左
            self.imageArrow.frame = CGRectMake(x + 10, y, self.contentH, 7);
            break;
        case SHPopMenuArrowPositionCenter://中
            self.imageArrow.frame = CGRectMake(x + self.menuW/2 - 15, y, self.contentH, 7);
            break;
        case SHPopMenuArrowPositionRight://右
            self.imageArrow.frame = CGRectMake(x + self.menuW - 35,y, self.contentH, 7);
            break;
        default://左
            self.imageArrow.frame = CGRectMake(x + 10, y, self.contentH, 7);
            break;
    }
    
    //刷新
    [self.contentView reloadData];
}

#pragma mark 消失
- (void)dismiss
{
    [self removeFromSuperview];
}

#pragma mark - Table view data source
#pragma mark 返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.backgroundColor = [UIColor lightGrayColor];
    }
    
    //取出内容
    id obj = self.mList[indexPath.row];
    
    if ([obj isKindOfClass:[NSDictionary class]]) {//字典：图片为key、内容为obj
        
        NSDictionary *dic = obj;
        cell.textLabel.text = dic.allValues[0];
        cell.imageView.image = [self imageWithImage:[UIImage imageNamed:dic.allKeys[0]] size:CGSizeMake(self.contentH/2, self.contentH/2)];
    }else if ([obj isKindOfClass:[NSString class]]){//字符串：只有内容
        
        NSString *str = obj;
        cell.textLabel.text = str;
    }else if ([obj isKindOfClass:[NSAttributedString class]]){//富文本
        
        NSAttributedString *att = obj;
        cell.textLabel.attributedText = att;
    }
    
    return cell;
}

//单元格点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.block) {
        self.block(self,indexPath.row);
    }
}

//设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.contentH;
}

#pragma mark - 获取指定大小的Image
- (UIImage *)imageWithImage:(UIImage *)image size:(CGSize)size{
    
    UIImage *sourceImage = image;
    
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = size.width;
    
    CGFloat targetHeight = size.height;
    
    CGFloat scaleFactor = 0.0;
    
    CGFloat scaledWidth = targetWidth;
    
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            
            scaleFactor = widthFactor;
        
        else
            
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            
            
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        } else if (widthFactor > heightFactor) {
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            
        }
        
    }
    
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = thumbnailPoint;
    
    thumbnailRect.size.width  = scaledWidth;
    
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    if(newImage == nil) {
        return image;
    }
    
    return newImage ;
}

@end

