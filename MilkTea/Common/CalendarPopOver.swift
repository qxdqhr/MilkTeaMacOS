//
//  CalendarPopOver.swift
//  MilkTea
//
//  Created by tiger on 2022/3/21.
//

import Cocoa
class CalendarPopOver:NSPopover{
    init(viewController:NSViewController) {
        super.init()
        self.behavior = .transient
        self.animates = true
        self.contentViewController = viewController
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
class CalendarPopOverViewController:NSViewController{
    
    var dateTime = ""
    var delegateOrder = ((((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
        .contentViewControllerItem.viewController as! ContentSplitViewController)
        .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController)
        .popoverAddOrder.contentViewController as! AddOrderViewController)
    var delegateMaterial = ((((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                                        .detailViewController.tabViewItems[4].viewController as! JuiceMaterialViewController)
                                        .popoverAddMaterial.contentViewController as!AddMaterialViewController)
#if OWNER
    #endif
    lazy var orderingTimeField : NSDatePicker = {
        var ctrl = NSDatePicker(frame: NSMakeRect(0, 0, 300, 300))
        ctrl.datePickerStyle = .clockAndCalendar
        ctrl.dateValue = .now
        ctrl.target = self
        ctrl.action = #selector(updateDate)
        return ctrl
    }()
    @objc func updateDate(_ sender:NSDatePicker){
        var date = sender.dateValue
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        delegateMaterial.sendTimeStringToBtn(timeString: formatter.string(from: date))
        delegateOrder.sendTimeStringToBtn(timeString: formatter.string(from: date))
    }
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 300, height: 300))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(orderingTimeField)
        orderingTimeField.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalToSuperview()
        }
    }

}
