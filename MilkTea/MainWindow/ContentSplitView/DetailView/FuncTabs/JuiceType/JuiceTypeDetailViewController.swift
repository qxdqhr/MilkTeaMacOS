//
//  JuiceTypeDetailViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/3/9.
//

import Cocoa

class JuiceTypeDetailViewController: NSViewController {
    lazy var juiceSummaryViewCtrller = JuiceTypeSummaryViewController()
    //Summary 中的数据集
    lazy var datas = juiceSummaryViewCtrller.detailData()
    
    lazy var isJuiceSelected = false
    lazy var juiceSelectedIndex = -1
    lazy var selectedName = ""
    lazy var juiceNameLbl : NSTextField = {
        return NSTextField(labelWithString: "饮品名称")
    }()
    lazy var juiceImageLbl : NSTextField = {
        return NSTextField(labelWithString: "饮品图片")
    }()
    lazy var juiceTypeLbl : NSTextField = {
        return NSTextField(labelWithString: "饮品类型")
    }()
    lazy var juicePriceLbl : NSTextField = {
        return NSTextField(labelWithString: "饮品售价")
    }()
    lazy var juiceProfitLbl : NSTextField = {
        return NSTextField(labelWithString: "饮品利润")
    }()
    lazy var juiceCostLbl : NSTextField = {
        return NSTextField(labelWithString: "饮品成本")
    }()
    lazy var juiceOrderTimeLbl : NSTextField = {
        return NSTextField(labelWithString: "最近下单时间")
    }()
    lazy var juiceEvaluateLbl : NSTextField = {
        return NSTextField(labelWithString: "最近评价")
    }()
    
    lazy var juiceImage : NSImageView = {
        let imageView =  NSImageView()
        imageView.frame = .init(x: 0, y: 0, width: 0, height: 0)
        return imageView
    }()
    lazy var juiceName : NSTextField = {
        return NSTextField(labelWithString: "aaa")
    }()
    lazy var juiceType : NSTextField = {
        return NSTextField(labelWithString: "饮品类型")
    }()
    lazy var juicePrice : NSTextField = {
        return NSTextField(labelWithString: "饮品售价")
    }()
    lazy var juiceProfit : NSTextField = {
        return NSTextField(labelWithString: "饮品利润")
    }()
    lazy var juiceCost : NSTextField = {
        return NSTextField(labelWithString: "饮品成本")
    }()
    lazy var juiceOrderTime : NSTextField = {
        return NSTextField(labelWithString: "最近下单时间")
    }()
    lazy var juiceEvaluate : NSTextField = {
        return NSTextField(labelWithString: "最近评价")
    }()
    func setJuiceType(juice:JuiceType){
        juiceName.stringValue = juice.juiceName
        juiceImage.image = NSImage(named: juice.juiceName)
        juiceType.stringValue = juice.juiceType
        juicePrice.stringValue = juice.price
        juiceProfit.stringValue = juice.profit
        juiceCost.stringValue = juice.cost
        juiceOrderTime.stringValue = juice.lastOrderingTime
        juiceEvaluate.stringValue = juice.curEvaluate
    }
    func getJuiceData(name:String) -> JuiceType? {
        print(datas)
        for data in datas {
            if data.juiceName == name {
                return data
            }
        }
        return nil
    }
    @objc func pushDownJuiceTypeItemNotification(notifi:Notification){
        guard let name:String = notifi.object as! String? else{ return }
        var juiceType = getJuiceData(name: name)!
        setJuiceType(juice: juiceType)
    
        
    }
    @objc func collapseDetailVieNotification(notifi:Notification){
        guard let name:String = notifi.object as! String? else{ return }
        var juiceType = getJuiceData(name: name)!
        setJuiceType(juice: juiceType)
    
        
    }
    override func loadView() {
        view = NSView()
        //创建通知中心
        NotificationCenter.default.addObserver(self, selector: #selector(pushDownJuiceTypeItemNotification), name: pushDownJuiceTypeItem, object: nil)//监听通知
    
        addSubViewsLayout()
    }
    
}
extension JuiceTypeDetailViewController{
    func addSubViewsLayout(){
        addSubviews(targetView: view, views: [
            juiceNameLbl,      juiceName,
            juiceImageLbl,     juiceImage,
            juiceTypeLbl,      juiceType,
            juicePriceLbl,     juicePrice,
            juiceProfitLbl,    juiceProfit,
            juiceCostLbl,      juiceCost,
            juiceOrderTimeLbl, juiceOrderTime,
            juiceEvaluateLbl,  juiceEvaluate,
        ])
   
        juiceImage.snp.makeConstraints{
            $0.trailing.lessThanOrEqualToSuperview()
            $0.top.lessThanOrEqualToSuperview()

        }
        juiceImageLbl.snp.makeConstraints{
            $0.trailing.lessThanOrEqualTo(juiceImage.snp.leading).offset(-10)
            $0.centerY.lessThanOrEqualTo(juiceImage)
        }
        juiceNameLbl.snp.makeConstraints{
            $0.centerX.lessThanOrEqualTo(juiceImageLbl)
            $0.top.lessThanOrEqualTo(juiceImage.snp.bottom)

        }
        juiceName.snp.makeConstraints{
            $0.centerX.equalTo(juiceImage)
            $0.centerY.equalTo(juiceNameLbl)

        }
        juiceTypeLbl.snp.makeConstraints{
            $0.centerX.equalTo(juiceImageLbl)
            $0.top.equalTo(juiceNameLbl.snp.bottom).offset(50)

        }
        juiceType.snp.makeConstraints{
            $0.centerX.equalTo(juiceImage)
            $0.centerY.equalTo(juiceTypeLbl)
        }
        juicePriceLbl.snp.makeConstraints{
            $0.centerX.equalTo(juiceImageLbl)
            $0.top.equalTo(juiceTypeLbl.snp.bottom).offset(50)
        }
        juicePrice.snp.makeConstraints{
            $0.centerX.equalTo(juiceImage)
            $0.centerY.equalTo(juicePriceLbl)

        }
        juiceProfitLbl.snp.makeConstraints{
            $0.centerX.equalTo(juiceImageLbl)
            $0.top.equalTo(juicePriceLbl.snp.bottom).offset(50)

        }
        juiceProfit.snp.makeConstraints{
            $0.centerX.equalTo(juiceImage)
            $0.centerY.equalTo(juiceProfitLbl)

        }
        juiceCostLbl.snp.makeConstraints{
            $0.centerX.equalTo(juiceImageLbl)
            $0.top.equalTo(juiceProfitLbl.snp.bottom).offset(50)

        }
        juiceCost.snp.makeConstraints{
            $0.centerX.equalTo(juiceImage)
            $0.centerY.equalTo(juiceCostLbl)

        }
        juiceOrderTimeLbl.snp.makeConstraints{
            $0.centerX.equalTo(juiceImageLbl)
            $0.top.equalTo(juiceCostLbl.snp.bottom).offset(50)

        }
        juiceOrderTime.snp.makeConstraints{
            $0.centerX.equalTo(juiceImage)
            $0.centerY.equalTo(juiceOrderTimeLbl)

        }
        juiceEvaluateLbl.snp.makeConstraints{
            $0.centerX.equalTo(juiceImageLbl)
            $0.top.equalTo(juiceOrderTimeLbl.snp.bottom).offset(50)

        }
        juiceEvaluate.snp.makeConstraints{
            $0.centerX.equalTo(juiceImage)
            $0.centerY.equalTo(juiceEvaluateLbl)

        }
    }
}
