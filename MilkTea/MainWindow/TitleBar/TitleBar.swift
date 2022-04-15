//
//  TitleBar.swift
//  MilkTea
//
//  Created by tiger on 2022/2/21.
//

import Cocoa


class TitleBarController: NSViewController {

    // - MARK: - 控件
    private lazy var titleLabel: NSTextField = {
        #if OWNER
        var titleAttributeStr = NSMutableAttributedString(string: "奶茶店营销管理系统:商户版")
        #else
        var titleAttributeStr = NSMutableAttributedString(string: "奶茶店营销管理系统:经销商版")
        #endif
        //设定 字体颜色
        titleAttributeStr.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.green, range: NSRange(location: 0, length:titleAttributeStr.length))
        //设定 背景颜色
        //titleAttributeStr.addAttribute(NSAttributedString.Key.backgroundColor, value: NSColor.orange, range: NSRange(location: 0, length:titleAttributeStr.length))
        //设定字体大小
        titleAttributeStr.addAttribute(NSAttributedString.Key.font, value: NSFont.systemFont(ofSize: 30), range: NSRange(location: 0, length:titleAttributeStr.length))

        var lbl = NSTextField(labelWithAttributedString: titleAttributeStr)
        return lbl
    }()
    private lazy var titleImage: NSImageView = {
        let AssertImage = NSImage(named: "TitleLogo")!
        var image = NSImageView(image: AssertImage )
        return image
    }()
     lazy var userBtn: NSButton = {
        let AssertImage = NSImage(named: "TitleLogo")!
        //获取登录用户名
        var btn = NSButton(title: "userName", target: self, action: #selector(pushLoginUser))
        btn.isBordered = false
        btn.focusRingType = .none
        return btn
    }()
    private lazy  var userPopMenu :NSMenu = {
        var popMenu = NSMenu()
//        popMenu.addItem(withTitle: "个人中心", action: #selector(enterSelfCenter), keyEquivalent: "")
        popMenu.addItem(withTitle: "退出登录", action:  #selector(logOut), keyEquivalent: "")
        return popMenu
    }()
    

    
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // - MARK: - 重写代理函数
    
    // - MARK: - 重写其他函数
    
    // - MARK: - 事件函数
    //点击登录用户名按钮
    @objc private func pushLoginUser(sender :NSButton){
        self.userBtn.menu = userPopMenu
        var point = sender.frame.origin
        point.x = point.x + sender.frame.size.width
        userPopMenu.popUp(positioning: nil, at: point, in: view)
    }
    //进入个人中心按钮
//    @objc private func enterSelfCenter(sender :NSButton){
//
//    }
    //退出登录按钮
    @objc private func logOut(sender :NSButton){
        MsgHelper.judgeMsg(message: "是否退出当前用户", window: self.view.window!){
            response in
            if (response == .alertFirstButtonReturn){
                WindowManager.shared.MainWnd.close()
                WindowManager.shared.showLoginWindow()
            }else if(response == .alertSecondButtonReturn){
                print("cancel")

            }
        }
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        
        view.addSubview(titleImage)
        titleImage.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(60)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(titleImage.snp.trailing).offset(10)
            $0.top.equalTo(titleImage).offset(5)
            $0.height.equalTo(titleImage)
        }
        
        view.addSubview(userBtn)
        userBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
        
    }
    
}
