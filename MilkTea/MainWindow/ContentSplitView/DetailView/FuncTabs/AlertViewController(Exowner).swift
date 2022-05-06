//
//  AlertViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/24.
//

import Cocoa
#if EXOWNER
class AlertViewController: NSViewController {

    // - MARK: - 控件
    private var alertReasonLabel = NSTextField(labelWithString: "告警原因")
    private var alertMethodLabel = NSTextField(labelWithString: "告警措施")
    private var alertOwnerLabel  = NSTextField(labelWithString:"告警商户账号")
    private var alertBtn         = NSButton(title: "发送告警", target: self, action: #selector(sendAlert))

     var alertOwner : NSTextField = {
        var textField = NSTextField()
        textField.maximumNumberOfLines = 0
        return textField
    }()
     var alertReasonTextField : NSTextField = {
        var textField = NSTextField()
        textField.maximumNumberOfLines = 0
        return textField
    }()
     var alertMethodTextField : NSTextField = {
        var textField = NSTextField()
        textField.maximumNumberOfLines = 0
        return textField
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
    @objc func sendAlert(_ sender:NSButton){
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM"
        
        AlertNetwork.add(para: Alert(
            Id:"EXALERT_\(LoginUserInfo.getLoginUser().userId)_\(df.string(from: Date()))",
            alertReason: alertReasonTextField.stringValue,
            alertMethod: alertMethodTextField.stringValue,
            alertOwner: alertOwner.stringValue,
            alertExOwner: LoginUserInfo.getLoginUser().userId,
            alertTime: df.string(from: Date()),
            alertReceived: "未接受"
        )
    )
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        addSubviews(targetView: self.view, views: [
            alertReasonLabel,
            alertMethodLabel,
            alertOwnerLabel ,
            alertBtn        ,
            alertOwner  ,
            alertReasonTextField,
            alertMethodTextField
        ])
        alertOwnerLabel .snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(60)
            $0.width.equalTo(150)
            
        }
        alertOwner.snp.makeConstraints{
            $0.centerY.equalTo(alertOwnerLabel)
            $0.leading.equalTo(alertOwnerLabel.snp.trailing)
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(100)

        }
        alertReasonLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalTo(alertOwnerLabel.snp.bottom).offset(100)
            $0.width.equalTo(150)
        }
        
        alertReasonTextField.snp.makeConstraints{
            $0.centerY.equalTo(alertReasonLabel)
            $0.leading.equalTo(alertReasonLabel.snp.trailing)
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(100)

        }
        
        alertMethodLabel.snp.makeConstraints{
          
            $0.leading.equalToSuperview()
            $0.top.equalTo(alertReasonLabel.snp.bottom).offset(100)
            $0.width.equalTo(150)

        }
        alertMethodTextField.snp.makeConstraints{
            $0.centerY.equalTo(alertMethodLabel)
            $0.leading.equalTo(alertMethodLabel.snp.trailing)
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(100)

        }
        
        alertBtn        .snp.makeConstraints{
            $0.leading.equalToSuperview()
            
        }
    }
    
}
#endif
