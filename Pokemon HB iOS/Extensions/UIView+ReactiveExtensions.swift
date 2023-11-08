//
//  UIView+ReactiveExtensions.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    func viewDidLoad() -> ControlEvent<Void> {
        let event = methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: event)
    }
    
    func viewWillAppear() -> ControlEvent<Bool> {
        let event = methodInvoked(#selector(Base.viewWillAppear)).map{ $0.first as? Bool ?? false }
        return ControlEvent(events: event)
    }
    
    func viewDidAppear() -> ControlEvent<Bool> {
        let event = methodInvoked(#selector(Base.viewDidAppear)).map{ $0.first as? Bool ?? false }
        return ControlEvent(events: event)
    }
    
    func viewWillDisappear() -> ControlEvent<Bool> {
        let event = methodInvoked(#selector(Base.viewWillDisappear)).map{ $0.first as? Bool ?? false }
        return ControlEvent(events: event)
    }
    
    func viewDidDisappear() -> ControlEvent<Bool> {
        let event = methodInvoked(#selector(Base.viewDidDisappear)).map{ $0.first as? Bool ?? false }
        return ControlEvent(events: event)
    }
}
