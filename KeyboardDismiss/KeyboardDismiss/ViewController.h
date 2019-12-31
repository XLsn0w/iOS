//
//  ViewController.h
//  KeyboardDismiss
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 XLsn0w. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

/*
 

    今天想实现一个简单的collectionView动画效果，查阅相关资料发现，实现 collectionView.performBatchUpdates()方法即可，于是掉坑里了。

     文档： public func performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) // allows multiple insert/delete/reload/move calls to be animated simultaneously. Nestable.

     根据文档的意思，我这边是做reload操作，发现刚好符合我的需求，于是撸起

 　　self.collectionView.performBatchUpdates({ () -> Void in

            self.collectionView.reloadData()

         }) { (finished) -> Void in

         }

     话说，一共就几行代码，so easy，我怎么没可能会错呢。。结果是：

  Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of items in section 0.  The number of items contained in an existing section after the update (9) must be equal to the number of items contained in that section before the update (8), plus or minus the number of items inserted or deleted from that section (0 inserted, 0 deleted) and plus or minus the number of items moved into or out of that section (0 moved in, 0 moved out)

      当时就不淡定了。。。怎么可能，哼。。。于是乎啊，我又运行几次，结果都是这么残忍。唉。。。都是泪啊，看看了文档，发现，另一个方法

       public func reloadSections(sections: NSIndexSet)  哈哈，难道在这个block中不能用reloadData()，于是我都试了试reloadSectionS()，binggo，搞定

      思索再三，发现原因可能是： 我在点击出发批量数据处理的时候，没有只能具体要操作的内容，所以报错了。。。。呜呜。。。可怜啊

    

   另外tableView也有相应的简单效果

 　　beginUpdates() / endUpdates() 在此之间写响应的代码就行了. 官方文档上写的很明白，没事还是多看看文档吧。。哈哈。。。
 
 
 
 UITableViewCell中的一个UITextField的数字键盘，效果是每次输入数字后刷新整个表视图，这里使用了reloadData，会出现每输入一个数字就收回键盘不能连续输入的问题。
 原因
 系统的reloadData和reloadRowsAtIndexPaths在执行的时候如果发现有的UITableView的子视图(例如这里的cell)有键盘已弹出正在响应(isFirstResponder)，就会收起该键盘(resignFirstResponder)。
 
 一种处理方法
 有键盘的cell自己来做控件显示更新，其他的cell刷新走reloadRowsAtIndexPaths。获取可见cell坐标数组(indexPathsForVisibleRows)剔除那个有键盘的IndexPath。

 
 */
