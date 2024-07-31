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

// 1. disposed:

// 2. dispose: 실제 Observer


final class OperatorViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    private let list = [1,2,3,4,5,6,7,8,9,10]
    
    deinit {
        print("deinit: ", self.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        testJustObservable()
        testFromObservable()
        testRepeatObservable()
        testIntervalObservable()
        testIntervalObservable2()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.disposeBag = DisposeBag()
        }
    }
    
    private func testJustObservable() {
        
        Observable.just(list)
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed-2")
            }
            .disposed(by: disposeBag)

    }
    
    private func testFromObservable () {
        
        Observable.from(list)
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)

    }
    
    private func testRepeatObservable() {
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
    
    // 관리해야할 Observer가 늘어날 수록 dispose를 사용한 메모리 관리는 어려워진다
    // disposeBag은 사용된 모든 Observer를 일괄관리할 수 있는 방법이다.
    
    private func testIntervalObservable() {
        
        let incrementValue = Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("next: ", value)
            } onError: { error in
                print("error: ", error)
            } onCompleted: {
                print("completed") // =>  disposed
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func testIntervalObservable2() {
        
        let incrementValue = Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
         
        incrementValue.subscribe { value in
            print("next-2: ", value)
        } onError: { error in
            print("error-2: ", error)
        } onCompleted: {
            print("completed") // =>  disposed
        } onDisposed: {
            print("disposed")
        }
        .disposed(by: disposeBag)
    }
    
    
   
    
}

