//
//  File.swift
//  MilkTea
//
//  Created by tiger on 2022/3/9.
//

import Cocoa
//item
class JuiceTypeSummaryViewItem:NSCollectionViewItem {
    lazy var lblName: NSTextField = NSTextField(labelWithString:"aaa" )
    lazy var juiceImage :NSImageView = NSImageView()
    override var isSelected: Bool{
        didSet{
            (self.view as! JuiceTypeCollectionItemView).selected = isSelected
        }
    }
    override var representedObject: Any? {
        didSet{
            let data = self.representedObject as? JuiceType
            if let title = (data?.juiceName) {
                self.lblName.stringValue = title
                self.juiceImage.image = NSImage(named: title)!
            }
        }
    }

    override func loadView() {
        self.view =  JuiceTypeCollectionItemView()//每个 item 创建视图
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lblName)
        view.addSubview(juiceImage)
        lblName.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        juiceImage.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(lblName.snp.top)


        }
     
        view.wantsLayer = true
       
    }

}
//identifier
extension NSUserInterfaceItemIdentifier{
    static let identifier = NSUserInterfaceItemIdentifier("juiceType")
}

