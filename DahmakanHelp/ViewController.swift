//
//  ViewController.swift
//  DahmakanHelp
//
//  Created by Jeelakarra Swathi on 06/04/2018.
//  Copyright © 2018 Jeelakarra Swathi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let orderView = UIScrollView()
    
    let orderLabel = UILabel()
    let orderValueLabel = UILabel()
    let arrivesLabel = UILabel()
    let arrivesValueLabel = UILabel()
    let paidLabel = UILabel()
    let paidValueLabel = UILabel()
    
    let pageControl = UIPageControl()
    
    var orderID: Int = 0
    var arrivedTime: String = ""
    var orderPaidBy: String = ""

    var activityTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callOrderDetails()
        setupViews()
    }
    
    func setupViews() {
        orderView.frame = CGRect(x: 20, y: 80, width: self.view.frame.width-40 , height: 150)
        orderView.backgroundColor = UIColor.white
        orderView.layer.borderWidth = 0.1
        orderView.layer.borderColor = UIColor.black.cgColor
        orderView.layer.cornerRadius = 3
        orderView.showsHorizontalScrollIndicator = false
        orderView.maximumZoomScale = 1.0
        orderView.minimumZoomScale = 1.0
        orderView.isPagingEnabled = true
        self.view.addSubview(orderView)
        
        pageControl.frame = CGRect(x: (self.view.frame.size.width/2)-30, y: 240, width: 60 , height: 15)
        pageControl.numberOfPages = 4
        pageControl.currentPage = 1
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        self.view.addSubview(pageControl)
        
        orderLabel.frame = CGRect(x: 15, y: 15, width: 140, height: 15)
        orderLabel.backgroundColor = UIColor.clear
        orderLabel.textAlignment = .left
        orderLabel.text = "Order"
        orderLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        orderLabel.textColor = UIColor.black
        orderView.addSubview(orderLabel)
        
        orderValueLabel.frame = CGRect(x: 15, y: 40, width: 140, height: 15)
        orderValueLabel.backgroundColor = UIColor.clear
        orderValueLabel.textAlignment = .left
        orderValueLabel.text = "\(getOrderID())"
        orderValueLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        orderValueLabel.textColor = UIColor.green
        orderView.addSubview(orderValueLabel)
        
        arrivesLabel.frame = CGRect(x: 15, y: 75, width: 140, height: 15)
        arrivesLabel.backgroundColor = UIColor.clear
        arrivesLabel.textAlignment = .left
        arrivesLabel.text = "Arrives at"
        arrivesLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        arrivesLabel.textColor = UIColor.black
        orderView.addSubview(arrivesLabel)
        
        arrivesValueLabel.frame = CGRect(x: 155, y: 75, width: 140, height: 15)
        arrivesValueLabel.backgroundColor = UIColor.clear
        arrivesValueLabel.textAlignment = .left
        arrivesValueLabel.text = getArrivedTime()
        arrivesValueLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        arrivesValueLabel.textColor = UIColor.gray
        orderView.addSubview(arrivesValueLabel)
        
        paidLabel.frame = CGRect(x: 15, y: 110, width: 140, height: 15)
        paidLabel.backgroundColor = UIColor.clear
        paidLabel.textAlignment = .left
        paidLabel.text = "Paid with"
        paidLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        paidLabel.textColor = UIColor.black
        orderView.addSubview(paidLabel)
        
        paidValueLabel.frame = CGRect(x: 155, y: 110, width: 140, height: 16)
        paidValueLabel.backgroundColor = UIColor.clear
        paidValueLabel.textAlignment = .left
        paidValueLabel.text = getOrderPaidBy()
        paidValueLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        paidValueLabel.textColor = UIColor.gray
        orderView.addSubview(paidValueLabel)
        
        let customView = UIView(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width-40, height: 200))
        customView.backgroundColor = UIColor.clear
        
        activityTableView.frame = CGRect (x:0 ,y:280 ,width:self.view.frame.size.width, height: 200)
        activityTableView = UITableView.init(frame: activityTableView.frame, style: .grouped)
        activityTableView.backgroundColor = UIColor.clear
        activityTableView.dataSource = self
        activityTableView.delegate = self
        activityTableView.layer.borderWidth = 0
        activityTableView.separatorStyle = .none
        activityTableView.isScrollEnabled = false
        self.activityTableView.contentInset = UIEdgeInsetsMake(-34, 0, 0, 0)
        //        ActivityTableView.tableFooterView = customView
        self.view.addSubview(activityTableView)
    }
    
    func callOrderDetails() {
        let path = Bundle.main.path(forResource: "Orders", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let jsonResult = try JSONDecoder().decode(orders.self, from: data)
            
            setOrderID(orderID: jsonResult.orders[0].order_id!) // setting order_id
            
            let orderTime: Int = jsonResult.orders[0].arrives_at_utc!
            let date = NSDate(timeIntervalSince1970: TimeInterval(orderTime))  //Convert to Date
            //Date formatting
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm a"
            dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
            let dateString = dateFormatter.string(from: date as Date)
            setArrivedTime(arrivedTime: dateString)
            
            setOrderPaidBy(orderPaidBy: jsonResult.orders[0].paid_with!)
            
        } catch (let error) {
            // handle error
            print("Error in calling API: \(error.localizedDescription)")
        }
    }
    
    func getOrderID() -> Int{
        return orderID
    }
    func setOrderID(orderID: Int) {
        self.orderID = orderID
    }
    
    func getArrivedTime() -> String{
        return arrivedTime
    }
    func setArrivedTime(arrivedTime: String) {
        self.arrivedTime = arrivedTime
    }
    
    func getOrderPaidBy() -> String{
        return orderPaidBy
    }
    func setOrderPaidBy(orderPaidBy: String) {
        self.orderPaidBy = orderPaidBy
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CustomTableViewCell", owner: self, options: nil)?.first as! CustomTableViewCell
        cell.selectionStyle = .none
        cell.layer.borderWidth = 0
        cell.backgroundColor = UIColor.clear
        if indexPath.row == 0{
            cell.mainHeadingLabel.text = "Help Center"
            cell.mainHeadingLabel.textColor = UIColor.orange
            cell.subHeadingLabel.text = "Quickly find answers to your questions"
            let disclosureImageName1 = UIImage(named: "yellowMore") as UIImage?
            cell.disclosureImg.image = disclosureImageName1
        }
        if indexPath.row == 1{
            cell.mainHeadingLabel.text = "Contact Us"
            cell.mainHeadingLabel.textColor = UIColor.purple
            cell.subHeadingLabel.text = "Chat with customer service or leave a message"
            let disclosureImageName2 = UIImage(named: "BlueMore") as UIImage?
            cell.disclosureImg.image = disclosureImageName2
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Alert", message: "Oh no! What happened?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)    }
}

