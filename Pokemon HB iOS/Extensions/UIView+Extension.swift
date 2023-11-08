//
//  UIView+Extension.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import UIKit

extension UIView {
    static func animateAlongside(keyboardNotification: Notification, animations: @escaping (_ keyboardEndFrame: CGRect) -> Void) {
        guard let userInfo = keyboardNotification.userInfo else {
            animations(.zero)
            return
        }
        
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let rawAnimationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIView.AnimationOptions.init(rawValue: UInt(rawAnimationCurve))
                
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: animationCurve) {
            animations(keyboardEndFrame)
        }
    }
    
    func enableTapToDismissKeyboard(cancelsTouchesInView: Bool = false, delegate: UIGestureRecognizerDelegate? = nil) {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(UIView.endEditing(_:)))
        tapGesture.cancelsTouchesInView = cancelsTouchesInView
        tapGesture.delegate = delegate
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
}
