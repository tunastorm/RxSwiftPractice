//
//  WireFrame.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/31/24.
//

import RxSwift

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import RxCocoa
#endif

enum RetryResult {
    case retry
    case cancel
}

protocol WireFrame {
    func open(url: URL)
    func promptFor<Action: CustomStringConvertible>(message: String, cancelAction: Action, actions: [Action]) -> Observable<Action>
}

class DefaultWireframe: WireFrame {
    
    static let shared = DefaultWireframe()
    
    func open(url: URL) {
            UIApplication.shared.open(url)
    }
    
    private static func rootViewController() -> UIViewController {
        // cheating, I know
        return UIApplication.shared.keyWindow!.rootViewController!
    }

    static func presentAlert(_ message: String) {
        let alertView = UIAlertController(title: "Rx예제", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "확인", style: .cancel) { _ in })
        rootViewController().present(alertView, animated: true, completion: nil)
    }
    
    func promptFor<Action: CustomStringConvertible>(message: String, cancelAction: Action, actions: [Action]) -> Observable<Action> {
        return Observable.create { observer in
            let alertView = UIAlertController(title: "Rx예제", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: cancelAction.description, style: .cancel) { _ in
                observer.on(.next(cancelAction))
            })
            
            for action in actions {
                alertView.addAction(UIAlertAction(title: action.description, style: .default){ _ in
                    observer.on(.next(action))
                })
            }
            
            DefaultWireframe.rootViewController().present(alertView, animated: true, completion: nil)
            
            return Disposables.create {
                alertView.dismiss(animated: false, completion: nil)
            }
        }
    }
}

extension RetryResult : CustomStringConvertible {
    
    var description: String {
        return switch self {
        case .retry: "재시도"
        case .cancel: "취소"
        }
    }

}
