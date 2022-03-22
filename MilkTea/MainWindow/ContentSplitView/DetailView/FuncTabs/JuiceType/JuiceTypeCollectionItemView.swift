//
//  JuiceTypeCollectionItemView.swift
//  MilkTeaOwner
//
//  Created by tiger on 2022/3/10.
//

import Cocoa

class JuiceTypeCollectionItemView :NSView {

    var selected:Bool = false { //赋值时重绘
        didSet{
            needsDisplay = true
        }
    }
    
    var hightlightState:NSCollectionViewItem.HighlightState = .none { //值发生变化时重绘
        didSet{
            if hightlightState != oldValue {
                needsDisplay = true
            }
        }
    }
    
    override var wantsUpdateLayer: Bool {
        return true
    }
    
    override func updateLayer() {
        if selected {
            layer?.borderColor = NSColor.blue.cgColor
            layer?.borderWidth = 2
        }else{
            layer?.borderColor = NSColor.white.cgColor
            layer?.borderWidth = 0
       
        
        }
    }
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.masksToBounds = true //子 layer 是否会依照父 layer 的 bound 进行裁剪
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.masksToBounds = true //子 layer 是否会依照父 layer 的 bound 进行裁剪
    }

}
