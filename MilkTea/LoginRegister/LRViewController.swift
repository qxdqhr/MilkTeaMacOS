//
//  LoginViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/16.
//

import Cocoa

class LRViewController: NSTabViewController {

    // - MARK: - 控件
    lazy var loginViewController: LoginViewController = {
        var ctrl = LoginViewController()
        ctrl.delegate = WindowManager.shared.MainWnd.contentViewController  as! LoginViewControllerDelegate
        return ctrl
    }()
    lazy var registerViewController: RegisterViewController = {
        var ctrl = RegisterViewController()
        ctrl.delegate = loginViewController
        return ctrl
    }()
    private lazy var showRegister: NSButton = {
        var ctrl = NSButton(title: "注册/登录", target: self, action: #selector(registerController))
        ctrl.isBordered = false
        ctrl.focusRingType  = .none
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
    
    // - MARK: - 事件函数
    @objc func registerController(_sender:NSButton){
        
        if self.children[0] === loginViewController {
            self.removeChild(at: 0)
            self.addChild(registerViewController)
            self.tabView.window?.title = "员工注册"
        }
        else{
            self.removeChild(at: 0)
            self.addChild(loginViewController)
            self.tabView.window?.title = "员工登录"
        }
        
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        
        self.addChild(loginViewController)
        
        view.addSubview(tabView)
        tabView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        view.addSubview(showRegister)
        showRegister.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalTo(tabView.snp.bottom)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview()
        }
        
    }
    
}
