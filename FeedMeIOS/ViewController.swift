//
//  ViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 3/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
//    var baby = ["宝宝0","宝宝1","宝宝2","宝宝3","宝宝4","宝宝5","宝宝6","宝宝7","宝宝8","宝宝9","宝宝10","宝宝11"]
    
    var baby = [String]()
    
    var babyImage = ["宝宝0.jpg","宝宝1.jpg","宝宝2.jpg","宝宝3.jpg","宝宝4.jpg","宝宝5.jpg","宝宝6.jpg","宝宝7.jpg","宝宝8.jpg","宝宝9.jpg","宝宝10.jpg","宝宝11.jpg"]
    
    var tableView = UITableView()
    //标记图片是否已经被选中
    var isFlag = [Bool](count : 12, repeatedValue: false)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve the list of all online shops' IDs:
        var shopIDs = [String]()
        shopIDs.append("1")
        shopIDs.append("17")
        shopIDs.append("18")
        
        for shopID in shopIDs {
            getShopData("http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/restaurants/query/?id=" + shopID)
        }
        
        
        print(baby)
        
        //之前这个地方定义的是var tableView局部变量，导致点了delete没反应
        tableView = UITableView(frame: CGRectMake(20, 50, 320, 600), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //每一块有多少行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baby.count
    }
    //绘制cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: initIdentifier)
        //下面两个属性对应subtitle
        cell.textLabel?.text = baby[indexPath.row]
//        cell.detailTextLabel?.text = "baby\(indexPath.row)"
        
        //添加照片
        cell.imageView?.image = UIImage(named: babyImage[indexPath.row])
        cell.imageView!.layer.cornerRadius = 40
        cell.imageView!.layer.masksToBounds = true
        
        //添加附件
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        if isFlag[indexPath.row] {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        //使用闭包，和嵌套函数或者JAVA中的匿名类类似
//        let locationActionHandler = {(action: UIAlertAction!) -> Void in
//            let locationAlertController = UIAlertController(title: nil, message: "我是宝宝\(indexPath.row)", preferredStyle: UIAlertControllerStyle.Alert)
//            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//            
//            locationAlertController.addAction(okAction)
//            self.presentViewController(locationAlertController, animated: true, completion: nil)
//            
//        }
//        let alertController = UIAlertController(title: "Baby\(indexPath.row)", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//        let cancleAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Cancel, handler: nil)
//        alertController.addAction(cancleAction)
//        
//        let locationAction = UIAlertAction(title: "宝宝是几号", style: UIAlertActionStyle.Default, handler: locationActionHandler)
//        alertController.addAction(locationAction)
//        
//        let markAction = UIAlertAction(title: "标记宝宝我一下", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction) -> Void in
//            let cell = tableView.cellForRowAtIndexPath(indexPath)
//            //此时可以将图片标记为勾，但是当往下拖动图片之前被标记的勾消失，是因为每次只加载出现在屏幕上的，其它都放在缓存池
//            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
//            self.isFlag[indexPath.row] = true//然后每次加载时候在cellForRowAtIndexPath方法进行判断
//        })
//        alertController.addAction(markAction)
//        presentViewController(alertController, animated: true, completion: nil)
//    }
    //和下一个方法中实现deleteAction效果是一样的
    //  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //        if editingStyle == UITableViewCellEditingStyle.Delete{
    //        self.baby.removeAtIndex(indexPath.row)
    //        self.babyImage.removeAtIndex(indexPath.row)
    //        self.isFlag.removeAtIndex(indexPath.row)
    //        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
    //       }
    //    }
    
    //分享和删除功能的实现
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: {
            (action: UITableViewRowAction,indexPath: NSIndexPath) -> Void in
            let menu = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Cancel, handler: nil)
            let facebookAction = UIAlertAction(title: "facebook", style: UIAlertActionStyle.Default, handler: nil)
            
            let twitterAction = UIAlertAction(title: "twitter", style: UIAlertActionStyle.Default, handler: nil)
            menu.addAction(facebookAction)
            menu.addAction(twitterAction)
            menu.addAction(cancelAction)
            self.presentViewController(menu, animated: true, completion: nil)
        })
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {
            (action: UITableViewRowAction,indexPath: NSIndexPath) -> Void in
            
            self.baby.removeAtIndex(indexPath.row)
            self.babyImage.removeAtIndex(indexPath.row)
            self.isFlag.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        })
        
        
        return [shareAction,deleteAction]
    }
    
    //每个cell的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    //隐藏bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveOnlineShops() {
        // TODO!
        // retrieve data from databases:
        
    }
    
    func getShopData(urlString: String) {
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (myData, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.setLabels(myData!)
            })
        }
        
        task.resume()
    }
    
    func setLabels(weatherData: NSData) {
        let json: NSDictionary
        do {
            json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: .AllowFragments) as! NSDictionary
            if let name = json["name"] as? String {
                baby.append(name)
                do_table_refresh()
            }
        } catch _ {
            
        }
    }
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
}