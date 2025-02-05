//
//  SheetActionCollectionViewCell.swift
//  ImagePickerSheetController
//
//  Created by Laurin Brandner on 26/08/15.
//  Copyright © 2015 Laurin Brandner. All rights reserved.
//

import UIKit

// TODO: check if this is correct
let KVOContext = UnsafeMutableRawPointer.init(bitPattern: 0)//UnsafeMutableRawPointer.init(bitPattern: 0)

class SheetActionCollectionViewCell: SheetCollectionViewCell {

    lazy private(set) var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.075, green:0.631, blue:0.945, alpha:1.0)
        label.textAlignment = .center

        self.addSubview(label)

        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        textLabel.addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(rawValue: 0), context: KVOContext)
    }

    deinit {
        textLabel.removeObserver(self, forKeyPath: "text")
    }

    // MARK: - Accessibility
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == KVOContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        accessibilityLabel = textLabel.text
    }

    // MARK: -

    override func tintColorDidChange() {
        super.tintColorDidChange()

        textLabel.textColor = tintColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel.frame = bounds.inset(by: backgroundInsets)
    }

}
