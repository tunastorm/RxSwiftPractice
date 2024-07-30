//
//  ExamJustViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


final class ExamObservableViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
    private let itemsB = [2.3, 2.0, 1.3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        examJust()
        examOf()
        examFrom()
        examTake()
    }
    
    private func examJust() {
        
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just completed")
            } onDisposed: {
                print("just disposed")
            }
            .disposed(by:disposeBag)
    }
    
    private func examOf() {
        
        Observable.of(itemsA, itemsB).subscribe { value in
            print("of - \(value)")
        } onError: { error in
            print("of - \(error)")
        } onCompleted: {
            print("of completed")
        } onDisposed: {
            print("of disposed")
        }
        .disposed(by: disposeBag)
    }
    
    private func examFrom() {
        
        Observable.from(itemsA)
        .subscribe { value in
            print("from - \(value)")
        } onError: { error in
            print("from - \(error)")
        } onCompleted: {
            print("from completed")
        } onDisposed: {
            print("from disposed")
        }
        .disposed(by: disposeBag)

    }
    
    private func examTake() {
        Observable.repeatElement("Infinite Sequence")
            .take(10)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat completed")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)

    }
    
}
