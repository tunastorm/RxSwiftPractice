//
//  OperatorViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class OperatorViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        // 빌드하면 터짐!!
        Observable
            .repeatElement("text")
            .take(10)
            .subscribe { value in
                print("next: ", value)
            } onError: { error in
                print("error")
            } onCompleted: {
                print("completed") // =>  disposed
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag) // vs dispose()
        
    }
    
}

