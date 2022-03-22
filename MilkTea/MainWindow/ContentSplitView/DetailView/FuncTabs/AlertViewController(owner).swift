//
//  a.swift
//  MilkTea
//
//  Created by tiger on 2022/3/13.
//

import Cocoa
#if OWNER
class AlertViewController: NSViewController {

    
    // - MARK: - 控件
    private var titleLabel : NSTextField = {
        let alertString = "最新告警:"
        let attributeString = NSMutableAttributedString(string:alertString)
        attributeString.addAttributes([.foregroundColor:NSColor.red.cgColor,
                                       .font           :NSFont.labelFont(ofSize: 30)
                                      ],
                                      range: NSRange(location: 0, length: alertString.count))
        var textField = NSTextField(labelWithAttributedString: attributeString)
        textField.maximumNumberOfLines = 0
        return textField
    }()
    private var alertReasonLabel = NSTextField(labelWithString: "告警原因")
    private var alertMethodLabel = NSTextField(labelWithString: "告警措施")
    private var alertOwnerLabel  = NSTextField(labelWithString:"告警商户名")
    private var alertOwnerName : NSTextField = {
        var textField = NSTextField(labelWithString: "目前未收到告警")
        textField.maximumNumberOfLines = 0
        return textField
    }()
    private var alertReasonTextField : NSTextField = {
        var textField = NSTextField(labelWithString: "目前未收到告警")
        textField.maximumNumberOfLines = 0
        return textField
    }()
    private var alertMethodTextField : NSTextField = {
        var textField = NSTextField(labelWithString: "目前未收到告警")
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

    // - MARK: - 加入视图以及布局
    func setupView(){
        addSubviews(targetView: self.view, views: [
            titleLabel,
            alertReasonLabel,
            alertMethodLabel,
            alertOwnerLabel ,
            alertOwnerName  ,
            alertReasonTextField,
            alertMethodTextField
        ])
        titleLabel .snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(50)

        }
        
        alertOwnerLabel .snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(60)
            $0.width.equalTo(150)
            
        }
        alertOwnerName  .snp.makeConstraints{
            $0.top.equalTo(alertOwnerLabel)
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
            $0.top.equalTo(alertReasonLabel)
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
            $0.top.equalTo(alertMethodLabel)
            $0.leading.equalTo(alertMethodLabel.snp.trailing)
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(100)

        }
        
    
    }
    
}
#endif
