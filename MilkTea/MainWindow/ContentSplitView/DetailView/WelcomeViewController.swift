//
//  CommonViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/24.
//

import Cocoa

class WelcomeViewController: NSViewController,LoginViewControllerDelegate {
    func sendUserIdtoWelcomeWndDelegate(username: String, userId: String) {
        setWelcomeString(username: username, userId: userId)
    }

    func setWelcomeString(username:String,userId:String){
        let str =  "\(username),您的工号是:\(userId),工作还没有完成,现在还不能休息哦"
        var attributeStr = NSMutableAttributedString(string:str)
        let attributes = [
            NSAttributedString.Key.foregroundColor : NSColor.yellow,
            NSAttributedString.Key.backgroundColor : NSColor.blue ,
            NSAttributedString.Key.font : NSFont.systemFont(ofSize: 20),
        ]
        attributeStr.addAttributes(attributes, range: NSRange.init(location: 0, length: str.count))
        welcomeLabel.attributedStringValue = attributeStr
    }
  
    // - MARK: - 控件
    lazy private var welcomeLabel : NSTextField = {
        var welcomeLabel = NSTextField(labelWithString: "")
        welcomeLabel.maximumNumberOfLines = 0
        welcomeLabel.lineBreakMode = .byCharWrapping
        return welcomeLabel
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.lessThanOrEqualToSuperview()
        }
        
        
    }
    
}
