//
//  LoginViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/16.
//

import Cocoa
import SnapKit
class LoginViewController: NSViewController,RegisterViewControllerDelegate {
    func sendUserIddelegate(userid: String,password:String) {
        nameField.stringValue = userid
        passField.stringValue = password
    }
    
   static var userId = ""
    // - MARK: - 控件
    private lazy var lblTitle : NSTextField = {
        #if OWNER
        var titleAttributeStr = NSMutableAttributedString(string: "奶茶店营销管理系统-加盟商版")
        #else
        var titleAttributeStr = NSMutableAttributedString(string: "奶茶店营销管理系统-经销商版")
        #endif
        //设定 字体颜色
        titleAttributeStr.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.blue, range: NSRange(location: 0, length:titleAttributeStr.length))
        //设定 背景颜色
        titleAttributeStr.addAttribute(NSAttributedString.Key.backgroundColor, value: NSColor.orange, range: NSRange(location: 0, length:titleAttributeStr.length))
        //设定字体大小
        titleAttributeStr.addAttribute(NSAttributedString.Key.font, value: NSFont.systemFont(ofSize: 30), range: NSRange(location: 0, length:titleAttributeStr.length))

        var ctrl = NSTextField(labelWithAttributedString: titleAttributeStr)
        return ctrl
    }()

    
    lazy var lblName : NSTextField =  {
        var titleAttributeStr = NSMutableAttributedString(string: "工号")
        //设定字体大小
        titleAttributeStr.addAttribute(NSAttributedString.Key.font, value: NSFont.systemFont(ofSize: 20), range: NSRange(location: 0, length:titleAttributeStr.length))
        var ctrl = NSTextField(labelWithAttributedString: titleAttributeStr)
        return ctrl
    }()
    
    private lazy var lblPass : NSTextField =  {
        var titleAttributeStr = NSMutableAttributedString(string: "密码")
        //设定字体大小
        titleAttributeStr.addAttribute(NSAttributedString.Key.font, value: NSFont.systemFont(ofSize: 20), range: NSRange(location: 0, length:titleAttributeStr.length))
        var ctrl = NSTextField(labelWithAttributedString: titleAttributeStr)
        return ctrl
    }()
//    private lazy var lblRole : NSTextField =  {
//        var titleAttributeStr = NSMutableAttributedString(string: "角色")
//        //设定字体大小
//        titleAttributeStr.addAttribute(NSAttributedString.Key.font, value: NSFont.systemFont(ofSize: 20), range: NSRange(location: 0, length:titleAttributeStr.length))
//        var ctrl = NSTextField(labelWithAttributedString: titleAttributeStr)
//        return ctrl
//    }()

    private lazy var nameField : NSTextField = {
        var ctrl = NSTextField()
        ctrl.isEditable = true
        ctrl.isBordered = true
        ctrl.placeholderString = "请输入工号"
        return ctrl
    }()

    private lazy var passField : NSTextField = {
        var ctrl = NSTextField()
        ctrl.placeholderString = "请输入密码"
        return ctrl
    }()
//    private lazy var  radioOwner : NSButton = {
//        var ctrl = NSButton(radioButtonWithTitle: "加盟商", target: self , action: nil)
//        ctrl.tag = 1
//        return ctrl
//    }()
//    private lazy var  radioExOwner : NSButton = {
//        var ctrl = NSButton(radioButtonWithTitle: "区域经销商", target: self , action: nil)
//        ctrl.tag = 1
//        return ctrl
//    }()

    private lazy var registerBtn : NSButton = {
        var ctrl = NSButton(title: "登录", target: self, action: #selector(loginRequest))
        return ctrl
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
    
    // - MARK: - 代理
    var delegate :LoginViewControllerDelegate?
    // - MARK: - 事件函数

    @objc func loginRequest(_sender:NSButton){
        let workNum = nameField.stringValue
        let password = passField.stringValue
        
        var validateString = ""

        if (workNum.isEmpty || workNum.count != 11){
            validateString = "工号非法格式"
            nameField.backgroundColor = .systemRed
            nameField.placeholderString = validateString
        }
        if(password.isEmpty||password.count<6||password.count>16){
            validateString += "密码非法格式"
            passField.backgroundColor = .systemRed
            passField.placeholderString = validateString
        }
        if(!validateString.isEmpty){
            MsgHelper.showMsg(message:"登录失败:内容不合法")
            validateString = ""
        }else{
            nameField.backgroundColor = .clear
            passField.backgroundColor = .clear
            #if OWNER
            var user = UserModel(name: "", userid:workNum, telephone: "", Password: password, role: "Owner")
            #else
            var user = UserModel(name: "", userid:workNum, telephone: "", Password: password, role: "ExOwner")
            #endif
            print(user)
            BaseNetWork.sendModelDataRequest(url: "http://localhost:8086/admin/login",
                                    method: .post,
                                    parameters: user){ code,data,msg in
               print(data)
                if(code == 200){
                    MsgHelper.showMsg(message:"登录成功")
                    //获取 name
                    let username = data.object(forKey: "name") as! String
                    //获取 ID
                    let userId = data.object(forKey: "userId") as! String
                    //设置用户信息
                    LoginUserInfo.setLoginUser(userName: username, userId: userId)
                    //协议写 name
                    self.delegate?.sendUserIdtoTitleBarDelegate?(username: username)
                    self.delegate =
                    ((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController).contentViewControllerItem.viewController as! ContentSplitViewController).detailViewController.tabViewItems[0].viewController as! WelcomeViewController
                    self.delegate?.sendUserIdtoWelcomeWndDelegate?(username: username, userId: userId)
                    self.view.window?.close()
                    WindowManager.shared.showMainMenu()
                }
                else {
                    MsgHelper.showMsg(message:"登录失败: \(msg)")
                }
               

            }
        }
    }
    // - MARK: - 加入视图以及布局
    func setupView(){

        view.addSubview(lblTitle)
        lblTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
        }

        view.addSubview(lblName)
        lblName.snp.makeConstraints{
            $0.top.equalTo(lblTitle.snp.bottom).offset(25)
            $0.leading.equalTo(lblTitle)
            $0.height.equalTo(23)

        }

        view.addSubview(lblPass)
        lblPass.snp.makeConstraints{
            $0.top.equalTo(lblName.snp.bottom).offset(25)
            $0.leading.equalTo(lblTitle)
            $0.height.equalTo(lblName)

        }
        
//        view.addSubview(lblRole)
//        lblRole.snp.makeConstraints{
//            $0.top.equalTo(lblPass.snp.bottom).offset(25)
//            $0.leading.equalTo(lblTitle)
//            $0.height.equalTo(lblName)
//
//        }
        
        view.addSubview(nameField)
        nameField.snp.makeConstraints{
            $0.top.equalTo(lblName)
            $0.height.equalTo(lblName)
            $0.leading.equalTo(lblName.snp.trailing).offset(50)
            $0.trailing.equalTo(lblTitle)
        }

        view.addSubview(passField)
        passField.snp.makeConstraints{
            $0.top.equalTo(lblPass)
            $0.height.equalTo(lblPass)
            $0.leading.equalTo(lblPass.snp.trailing).offset(50)
            $0.trailing.equalTo(lblTitle)
        }
//        view.addSubview(radioOwner)
//        radioOwner.snp.makeConstraints{
//            $0.top.equalTo(lblRole)
//            $0.bottom.equalTo(lblRole)
//            $0.leading.equalTo(lblPass.snp.trailing).offset(50)
//        }
//        view.addSubview(radioExOwner)
//        radioExOwner.snp.makeConstraints{
//            $0.top.equalTo(lblRole)
//            $0.bottom.equalTo(lblRole)
//            $0.leading.equalTo(radioOwner.snp.trailing)
//        }
        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints{
            $0.top.equalTo(passField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
    }
    
}
