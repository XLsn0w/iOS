//
//  ViewController.m
//  XLsn0wCAAnimation
//
//  Created by XLsn0w on 2017/6/27.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import "ViewController.h"

#import "XLsn0wAnimationKit.h"
#import "Define.h"
#import "BQDragCardView.h"




@interface ViewController ()

@property (nonatomic ,strong) NSArray * arr;

@property (nonatomic ,strong) DWAnimation * animation;

@property (nonatomic ,strong) DWAnimationGroup * g;


//背景
@property(nonatomic,strong) CALayer *layer;
//花瓣
@property(nonatomic,strong) CALayer *petalLayer;

@end

@implementation ViewController

#define XLsn0wAnimationBegin  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start:) name:DWAnimationPlayFinishNotification object:nil]
#define XLsn0wAnimationFinish [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finish:) name:DWAnimationPlayFinishNotification object:nil]

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view.layer addSublayer:self.layer];
    //    [self.view.layer addSublayer:self.petalLayer];
    
    //BQDragCardView *cardView = [[BQDragCardView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //[self.view addSubview:cardView];
    
    
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setFrame:CGRectMake(100, 100, 60, 30)];
    [button setTitle:@"点我啊" forState:(UIControlStateNormal)];
    [button setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(bu) forControlEvents:(UIControlEventTouchUpInside)];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    redView.center = CGPointMake(self.view.center.x + 50, self.view.center.y);
    
    
    
    XLsn0wAnimationBegin;
    XLsn0wAnimationFinish;
    
    
    
    //
    //    DWAnimation * springAnimation1 = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"springAnimationMove" springingType:(DWAnimationSpringTypeMove) beginTime:0 fromValue:[NSValue valueWithCGPoint:CGPointMake(redView.center.x, - redView.frame.size.height * 0.5)] toValue:[NSValue valueWithCGPoint:self.view.center] mass:1 stiffness:100 damping:10 initialVelocity:0];
    //    springAnimation1.repeatCount = 2;
    //        springAnimation1.beginTime = 2;
    //    self.a = springAnimation1;
    //            [springAnimation1 start];
    //
    //
    //
    //    DWAnimation * springAnimation2 = [redView dw_CreateAnimationWithAnimationKey:@"springAnimationScale" springingType:(DWAnimationSpringTypeScale) beginTime:0 fromValue:@0 toValue:@1 mass:2 stiffness:100 damping:10 initialVelocity:0];
    //    //
    //    DWAnimation * springAnimation = [springAnimation1 combineWithAnimation:springAnimation2 animationKey:nil];
    //    //
    //    DWAnimation * moveAnimation = [redView dw_CreateAnimationWithKey:@"moveAnimation" animationCreater:^(DWAnimationMaker *maker) {
    //        maker.moveTo(CGPointMake(self.view.center.x, self.view.center.y + 100)).duration(2).install();
    //    }];
    //        [moveAnimation start];
    //    DWAnimation * arcAnimation = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"arcAnimation" beginTime:0 duration:1 arcCenter:CGPointMake(self.view.center.x, self.view.center.y - 300) radius:400 startAngle:180 endAngle:200 clockwise:YES autoRotate:YES];
    //    arcAnimation.repeatCount = 2;
    
    
    
    DWAnimation * bezierAnimation = [redView dw_CreateAnimationWithAnimationKey:@"bezierAnimation" beginTime:0 duration:2 bezierPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y - 300) radius:400 startAngle:RadianFromDegree(110) endAngle:RadianFromDegree(70) clockwise:NO] autoRotate:NO];
    bezierAnimation.repeatCount = 2;
    
    
    DWAnimation * rotateAnimation = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"rotate" animationCreater:^(DWAnimationMaker *maker) {
        maker.rotateFrom(20).rotateTo(-20).duration(2).install();
    }];
    //
    //
    //    rotateAnimation.beginTime = 2;
    //    DWAnimation * combineAnimation = [bezierAnimation combineWithAnimation:rotateAnimation animationKey:nil];
    //    self.a = combineAnimation;
    //    //    [combineAnimation start];
    //    //
    //    DWAnimation * resetAnimation = [redView dw_CreateResetAnimationWithAnimationKey:nil beginTime:0 duration:2];
    //    //
    //    DWAnimation * addAnimation = [combineAnimation addAnimation:resetAnimation animationKey:nil];
    //
    //    //    [addAnimation start];
    //
    //    DWAnimation * multiAnimation = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationType:(DWAnimationTypeMove) animationKey:@"multiAnimation" beginTime:0 values:@[[NSValue valueWithCGPoint:self.view.center],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y - 100)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x - 100, self.view.center.y + 100)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x + 100, self.view.center.y)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x - 100, self.view.center.y)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x + 100, self.view.center.y + 100)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y - 100)]] timeIntervals:@[@1,@2,@2,@2,@2,@2] transition:NO];
    //    //    [multiAnimation start];
    //    //
    //    CABasicAnimation * basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    //    basicAnimation1.removedOnCompletion = NO;
    //    basicAnimation1.fillMode = kCAFillModeForwards;
    //    basicAnimation1.duration = 2;
    //    basicAnimation1.toValue = @(RadianFromDegree(180));
    //    //
    //    CABasicAnimation * basicAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //    basicAnimation2.removedOnCompletion = NO;
    //    basicAnimation2.fillMode = kCAFillModeForwards;
    //    basicAnimation2.duration = 2;
    //    basicAnimation2.toValue = @(RadianFromDegree(180));
    //    DWAnimation * arrAnimation = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"arrAnimation" beginTime:2 duration:2 animations:@[basicAnimation1,basicAnimation2]];
    //    //    [arrAnimation start];
    //    //
    //    DWAnimation * longSentence = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"longSentence" animationCreater:^(DWAnimationMaker *maker) {
    //        maker.moveTo(self.view.center).cornerRadiusTo(50).scaleTo(2).alphaTo(0).duration(2).install();
    //    }];
    //    //    [longSentence start];
    //
    //    DWAnimation * shortSentence = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"shortSentence" animationCreater:^(DWAnimationMaker *maker) {
    //        maker.reset.duration(2).install();
    //        maker.alphaFrom(0.5).alphaTo(1).beginTime(2).duration(2).install();
    //        maker.rotateTo(90).axis(Y).beginTime(2).duration(2).install();
    //        maker.reset.moveTo(CGPointMake(100, 100)).beginTime(4).duration(2).install();
    //        maker.moveTo(CGPointMake(self.view.center.x + 200, self.view.center.y)).alphaTo(0).beginTime(6).duration(2).install();
    //    }];
    //
    //    DWAnimation * reset = [redView.layer dw_CreateResetAnimationWithAnimationKey:nil beginTime:0 duration:2];
    //    reset.completion = ^(DWAnimation * ani){
    //        NSLog(@"%@ over",ani.animationKey);
    //    };
    //    self.arr = @[springAnimation,moveAnimation,arcAnimation,addAnimation,multiAnimation,arrAnimation,longSentence,shortSentence,reset];
    
    
    //    UIView * blueView = [[UIView alloc] initWithFrame:redView.frame];
    //    blueView.backgroundColor = [UIColor blueColor];
    //    [self.view addSubview:blueView];
    //
    //    UIView * greenView = [[UIView alloc] initWithFrame:redView.frame];
    //    greenView.backgroundColor = [UIColor greenColor];
    //    [self.view addSubview:greenView];
    //
    //    DWAnimation * rA = [redView dw_CreateAnimationWithKey:@"re" animationCreater:^(DWAnimationMaker *maker) {
    //        maker.moveTo(CGPointMake(100, 100)).duration(2).install();
    //    }];
    //
    //    DWAnimation * bA = [blueView dw_CreateAnimationWithKey:@"bl" animationCreater:^(DWAnimationMaker *maker) {
    //        maker.moveTo(CGPointMake(200, 200)).duration(2).install();
    //    }];
    //
    //    DWAnimation * gA = [greenView dw_CreateAnimationWithKey:@"gr" animationCreater:^(DWAnimationMaker *maker) {
    //        maker.moveTo(CGPointMake(300, 300)).scaleTo(2).rotateTo(360).axis(X).beginTime(2).duration(2).install();
    //    }];
    //
    //    bA.beginTime = 2;
    //    DWAnimationGroup * group = [[DWAnimationGroup alloc] initWithAnimations:@[rA,bA,gA]];
    //
    //    group.beginTime = 2;
    //
    //    self.g = group;
    //    DWAnimation * ani = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"ro" beginTime:0 duration:2 rotateStartAngle:0 rotateEndAngle:180 rotateAxis:X deep:300];
    //    DWAnimation * ani = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:nil beginTime:0 duration:1 bezierPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x - 50, self.view.center.y - 50) radius:sqrt(5000) startAngle:M_PI_4 endAngle:M_PI_4 * 3 clockwise:YES] autoRotate:NO];
    //    DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:nil animationCreater:^(DWAnimationMaker *maker) {
    //        maker.rotateTo(90).duration(1).install();
    //    }];
    
    
    //判断CGRect是否包含一个点可以用CGRectContainsPoint函数
    //CGRectContainsPoint 看参数说明，一个点是否包含在矩形中，所以参数为一个点一个矩形
    //BOOL contains = CGRectContainsPoint(CGRect rect, CGPoint point);
    
    //判断一个CGRect是否包含在另一个CGRect里面,常用与测试给定的对象之间是否又重叠
    //BOOL contains = CGRectContainsRect(CGRect rect1, CGRect rect2);
    
    //判断两个结构体是否有交错.可以用CGRectIntersectsRect
    //BOOL contains = CGRectIntersectsRect(CGRect rect1, CGRect rect2);
    
    
    
    
    
    //    DWAnimation * ani = [[DWAnimation alloc] initAnimationWithLayer:redView.layer
    //                                                       animationKey:@"xxx"
    //                                                          beginTime:0
    //                                                           duration:2
    //                                                   rotateStartAngle:0
    //                                                     rotateEndAngle:360
    //                                               simulateChangeAnchor:CGPointMake(0.25, 0.5)];
    //    ani.repeatCount = 3;
    //    self.a = ani;
}

-(void)finish:(NSNotification *)notice
{
    NSDictionary * dic = notice.object;
    DWAnimation * animaiton = dic[@"animation"];
    NSLog(@"finish:%@",animaiton.animationKey);
}

-(void)start:(NSNotification *)notice
{
    NSDictionary * dic = notice.object;
    DWAnimation * animaiton = dic[@"animation"];
    NSLog(@"start:%@",animaiton.animationKey);
}

-(void)bu
{
    //    [UIView dw_StartAnimations:self.arr playMode:(DWAnimationPlayModeSingle)];
    //    [self.g start];
    [self.animation begin];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CALayer *)layer{
    
    if (_layer) {
        return _layer;
    }
    _layer = [CALayer layer];
    _layer.position= CGPointMake(self.view.center.x, self.view.center.y+100);
    UIImage *image = [UIImage imageNamed:@"4"];
    _layer.bounds = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
    _layer.contents = (id)image.CGImage;
    return _layer;
}
-(CALayer *)petalLayer{
    
    if (_petalLayer) {
        return _petalLayer;
    }
    _petalLayer = [CALayer layer];
    _petalLayer.position= CGPointMake(self.view.center.x, 50);
    UIImage *image = [UIImage imageNamed:@"2"];
    _petalLayer.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    _petalLayer.contents = (id)image.CGImage;
    return _petalLayer;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //    [self demo1:[[touches anyObject] locationInView:self.view]];
    [self demo2];
}

//移动中心点
-(void)demo1:(CGPoint)toValue{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    //CGPoint -> 转id类型
    //CGPoint -> NSValue
    animation.fromValue = [NSValue valueWithCGPoint:self.petalLayer.position];
    //动画的持续时间
    animation.duration = 3;
    //动画执行的总时间 受动画速度的影响
    //    animation.speed = 2;
    //设置动画完成的时候  固定在完成的状态
    //这个属性必须把removedOnCompletion 设置为NO 这个属性 才可以有效果
    animation.removedOnCompletion = NO;
    animation.toValue = [NSValue valueWithCGPoint:toValue];
    animation.fillMode = kCAFillModeBoth;
    //timingFunction可以控制动画的速度
    //快进慢出
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //layer上添加动画效果 addAnimation: forKey:
    //forKey 表示动画的字符串 可以通过key 来找到这个动画
    [self.petalLayer addAnimation:animation forKey:@"可以通过这个key,找到此动画"];
    //查找某个key对应的动画
    //    CABasicAnimation *an = (CABasicAnimation *)[self.petalLayer animationForKey:@"可以通过这个key,找到此动画"];
    
}
//心跳
-(void)demo2{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"心跳"];
    self.layer.contents = (id)image.CGImage;//为了方便，直接更换self.layer内容
    self.layer.bounds = CGRectMake(0, 0, image.size.width/10, image.size.height/10);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    /*
     目标
     1.放大后还原到原来的位置 以动画的方法
     2.先慢后快
     3.一直循环
     */
    animation.fromValue = [NSValue valueWithCGRect:self.layer.bounds];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, image.size.width/5, image.size.height/5)];
    animation.repeatCount = HUGE;//无限循环
    animation.duration = 0.5;
    animation.autoreverses = YES;//以动画的效果返回到开始的状态
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"heartJamp"];
}

@end
