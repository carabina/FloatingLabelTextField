//
//  FloatingTextField+Utils.swift
//  FloatingTextField
//
//  Created by Dmitriy Zhyzhko
//

import Foundation

public typealias EventListener = (Event) -> Void

public enum Event {
    case didStartEditing(_ floatingTextField: FloatingLabelTextField)
    case didEndEditing(_ floatingTextField: FloatingLabelTextField)
    case didTextChanged(_ floatingTextField: FloatingLabelTextField)
    case didExtraButtonPressed(floatingTextField: FloatingLabelTextField, index: Int, button: UIButton)
}

public enum InputTextState: CGFloat {
    case idle = 0
    case invalid = 0.1
    case unreliable = 0.2
    case medium = 0.5
    case reliable = 0.8
    case max = 1
}

public protocol FloatingLabelTextFieldDelegate: class {
    func state(for floatingTextField: FloatingLabelTextField) -> (state: InputTextState, description: String?, color: UIColor)
}

extension FloatingLabelTextField {
    
    func constraints(for view: UIView?) {
        guard let view = view else { return }
        
        var constraints: [NSLayoutConstraint]?
        if view == headerLabel {
            headerLabelConstraintTop = NSLayoutConstraint(item: headerLabel!, attribute: .top, relatedBy: .equal,
                                                          toItem: self, attribute: .top, multiplier: 1, constant: 0)
            constraints = [headerLabelConstraintTop!,
                           NSLayoutConstraint(item: headerLabel!, attribute: .left, relatedBy: .equal,
                                              toItem: self, attribute: .left, multiplier: 1, constant: 0)]
        } else if view == descriptionLabel {
            constraints = [NSLayoutConstraint(item: descriptionLabel!, attribute: .top, relatedBy: .equal,
                                              toItem: separatorView!, attribute: .bottom, multiplier: 1, constant: 6),
                           NSLayoutConstraint(item: descriptionLabel!, attribute: .left, relatedBy: .equal,
                                              toItem: self, attribute: .left, multiplier: 1, constant: 0),
                           NSLayoutConstraint(item: descriptionLabel!, attribute: .right, relatedBy: .equal,
                                              toItem: self, attribute: .right, multiplier: 1, constant: 0)]
        } else if view == textField {
            constraints = [NSLayoutConstraint(item: textField!, attribute: .top, relatedBy: .equal,
                                              toItem: self, attribute: .top, multiplier: 1, constant: headerLabel!.frame.height + 7),
                           NSLayoutConstraint(item: textField!, attribute: .left, relatedBy: .equal,
                                              toItem: self, attribute: .left, multiplier: 1, constant: 0),
                           NSLayoutConstraint(item: textField!, attribute: .right, relatedBy: .equal,
                                              toItem: self, attribute: .right, multiplier: 1, constant: 0)]
        } else if view == separatorView {
            constraints = [NSLayoutConstraint(item: separatorView!, attribute: .top, relatedBy: .equal,
                                              toItem: textField!, attribute: .bottom, multiplier: 1, constant: 6),
                           NSLayoutConstraint(item: separatorView!, attribute: .left, relatedBy: .equal,
                                              toItem: self, attribute: .left, multiplier: 1, constant: 0),
                           NSLayoutConstraint(item: separatorView!, attribute: .right, relatedBy: .equal,
                                              toItem: self, attribute: .right, multiplier: 1, constant: 0),
                           NSLayoutConstraint(item: separatorView!, attribute: .height, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)]
        } else if view == stateView {
            stateViewConstraintWidth = NSLayoutConstraint(item: stateView!, attribute: .width, relatedBy: .equal,
                                                          toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            stateViewWidth = frame.width
            constraints = [NSLayoutConstraint(item: stateView!, attribute: .top, relatedBy: .equal,
                                              toItem: textField!, attribute: .bottom, multiplier: 1, constant: 6),
                           NSLayoutConstraint(item: stateView!, attribute: .left, relatedBy: .equal,
                                              toItem: self, attribute: .left, multiplier: 1, constant: 0),
                           NSLayoutConstraint(item: stateView!, attribute: .height, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1),
                               stateViewConstraintWidth!]
        }
        NSLayoutConstraint.activate(constraints ?? [])
    }
}
