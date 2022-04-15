//
//  RegisterViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/16.
//

import Cocoa

class RegisterViewController: NSViewController {

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

    
    private lazy var lblName : NSTextField =  {
        var titleAttributeStr = NSMutableAttributedString(string: "姓名")
        //设定字体大小
        titleAttributeStr.addAttribute(NSAttributedString.Key.font, value: NSFont.systemFont(ofSize: 20), range: NSRange(location: 0, length:titleAttributeStr.length))
        var ctrl = NSTextField(labelWithAttributedString: titleAttributeStr)
        return ctrl
    }()
    private lazy var lblTele : NSTextField =  {
        var titleAttributeStr = NSMutableAttributedString(string: "电话号码")
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
    #if OWNER
    private lazy var lblExOwnerID : NSTextField =  {
        var titleAttributeStr = NSMutableAttributedString(string: "经销商工号")
        //设定字体大小
        titleAttributeStr.addAttribute(NSAttributedString.Key.font, value: NSFont.systemFont(ofSize: 20), range: NSRange(location: 0, length:titleAttributeStr.length))
        var ctrl = NSTextField(labelWithAttributedString: titleAttributeStr)
        return ctrl
    }()
    #endif
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
        ctrl.placeholderString = "请输入姓名"
        return ctrl
    }()
    private lazy var teleField : NSTextField = {
        var ctrl = NSTextField()
        ctrl.placeholderString = "请输入电话"
        return ctrl
    }()
    private lazy var passField : NSTextField = {
        var ctrl = NSTextField()
        ctrl.placeholderString = "请输入密码"
        return ctrl
    }()
#if OWNER
    private lazy var exOwnerIDField : NSTextField = {
        var ctrl = NSTextField()
        ctrl.placeholderString = "请输入经销商工号"
        return ctrl
    }()
#endif

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
        var ctrl = NSButton(title: "注册", target: self, action: #selector(registerRequest))
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
    
    // - MARK: - 重写其他函数
    var delegate :RegisterViewControllerDelegate? //存一个实现本协议的其他类对象
    
    // - MARK: - 事件函数
    @objc func registerRequest(_sender:NSButton){
        let name = nameField.stringValue
        let telephone = teleField.stringValue
        let password = passField.stringValue
        #if OWNER
        let exownerid = exOwnerIDField.stringValue
        #endif
        var validateString = ""

        if (name.isEmpty){
            validateString = "姓名不能为空"
            nameField.backgroundColor = .systemRed
            nameField.placeholderString = validateString
        }
        if(telephone.count != 11 ){
            validateString += "电话号非法格式"
            teleField.backgroundColor = .systemRed
            teleField.placeholderString = validateString
        }
        if(password.isEmpty||password.count<6||password.count>16){
            validateString += "密码非法格式"
            passField.backgroundColor = .systemRed
            passField.placeholderString = validateString
        }
        if(!validateString.isEmpty){
            MsgHelper.showMsg(message:"注册失败:内容不合法")
            validateString = ""
        }else{
            nameField.backgroundColor = .clear
            teleField.backgroundColor = .clear
            passField.backgroundColor = .clear
            #if OWNER
            exOwnerIDField.backgroundColor = .clear
            var user = UserModel(name: name,userid: "", telephone: telephone, Password: password, role: "Owner",exOwnerID: exownerid)
            #else
            var user = UserModel(name: name,userid: "", telephone: telephone, Password: password, role: "ExOwner")
            #endif
            BaseNetWork.sendModelDataRequest(url: "http://localhost:8086/admin/register",
                                    method: .post,
                                    parameters: user){ code,data,msg in
               
                var message = msg
                let userid = data.object(forKey: "userid") as! String
                if(userid != ""){
                    message.append(userid)
                }
                if(code == 200){
                    MsgHelper.showMsg(message:"注册成功,您的工号为:\(userid)")
                }
                else {
                    MsgHelper.showMsg(message:"注册失败: \(message)")
                }
                
                self.delegate?.sendUserIddelegate(userid: userid, password: user.Password)
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
        view.addSubview(lblTele)
        lblTele.snp.makeConstraints{
            $0.top.equalTo(lblName.snp.bottom).offset(25)
            $0.leading.equalTo(lblTitle)
            $0.height.equalTo(lblName)
        }
        view.addSubview(lblPass)
        lblPass.snp.makeConstraints{
            $0.top.equalTo(lblTele.snp.bottom).offset(25)
            $0.leading.equalTo(lblTitle)
            $0.height.equalTo(lblName)

        }
        
#if OWNER
        view.addSubview(lblExOwnerID)
        lblExOwnerID.snp.makeConstraints{
            $0.top.equalTo(lblPass.snp.bottom).offset(25)
            $0.leading.equalTo(lblTitle)
            $0.height.equalTo(lblName)

        }
#endif

        
        view.addSubview(nameField)
        nameField.snp.makeConstraints{
            $0.top.equalTo(lblName)
            $0.height.equalTo(lblName)
            $0.leading.equalTo(lblName.snp.trailing).offset(50)
            $0.trailing.equalTo(lblTitle)
        }
        view.addSubview(teleField)
        teleField.snp.makeConstraints{
            $0.top.equalTo(lblTele)
            $0.height.equalTo(lblTele)
            $0.leading.equalTo(lblTele.snp.trailing).offset(10)
            $0.trailing.equalTo(lblTitle)
        }
        view.addSubview(passField)
        passField.snp.makeConstraints{
            $0.top.equalTo(lblPass)
            $0.height.equalTo(lblPass)
            $0.leading.equalTo(lblPass.snp.trailing).offset(50)
            $0.trailing.equalTo(lblTitle)
        }
#if OWNER
        view.addSubview(exOwnerIDField)
        exOwnerIDField.snp.makeConstraints{
            $0.top.equalTo(lblExOwnerID)
            $0.bottom.equalTo(lblExOwnerID)
            $0.leading.equalTo(lblExOwnerID.snp.trailing).offset(7)
            $0.trailing.equalTo(lblTitle)

        }
        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints{
            $0.top.equalTo(exOwnerIDField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }

#else

        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints{
            $0.top.equalTo(passField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
#endif
//        view.addSubview(radioExOwner)
//        radioExOwner.snp.makeConstraints{
//            $0.top.equalTo(lblRole)
//            $0.bottom.equalTo(lblRole)
//            $0.leading.equalTo(radioOwner.snp.trailing)
//        }

        
    }
    
}
