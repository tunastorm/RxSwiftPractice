//
//  UserViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class UserViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    private let nicknameTextField = UITextField()
    private let checkButton = UIButton()
    
    private var sampleNickname = BehaviorSubject(value: "고래밥")
    
    private var behavior = BehaviorSubject(value: 3) // 반드시 초기화가 되어야 함
    private var publish = PublishSubject<Int>() // 값을 초기화 하지 않음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        testBehaviorSubject()
        testPublishSubject()
        
        // 권장
        sampleNickname
            .bind(with: self) { owner, value in
                owner.nicknameTextField.text = value
            }
            .disposed(by: disposeBag)
        
//        sampleNickname
//            .bind(to: nicknameTextField.rx.text)
//            .disposed(by: disposeBag)
        
        checkButton.rx.tap
            .bind(with: self) { owner, _ in
                self.sampleNickname.onNext("칙촉 \(Int.random(in: 1...100))") // 새로운 값 전달 (Observer)
            }
            .disposed(by: disposeBag)
    
    }
    
    private func configureView() {
        view.addSubview(nicknameTextField)
        view.addSubview(checkButton)
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
        
        checkButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        view.backgroundColor = .white
        nicknameTextField.backgroundColor = .systemYellow
        checkButton.backgroundColor = .systemBlue
        
    }
    
    private func testBehaviorSubject() {
        
//        behavior.onNext(1) // Observer
//        behavior.onNext(2) // Observer
//        behavior.onNext(3) // Observer
        
        behavior  // Observable -subscribe-> Observer
            .subscribe { value in
                print("behavior next - ", value)
            } onError: { error in
                print("behavior error - ", error)
            } onCompleted: {
                print("behavior completed")
            } onDisposed: {
                print("behavior disposed")
            }
            .disposed(by: disposeBag)
        
        behavior.onNext(4) // Observer / Observable -> Observer
        behavior.onNext(5) // Observer
        behavior.onNext(6) // Observer

    }
    
    private func testPublishSubject() {
        
        publish.onNext(1) // Observer
        publish.onNext(2) // Observer
        publish.onNext(3) // Observer
        
        publish  // Observable -subscribe-> Observer
            .subscribe { value in
                print("publish next - ", value)
            } onError: { error in
                print("publish error - ", error)
            } onCompleted: {
                print("publish completed")
            } onDisposed: {
                print("publish disposed")
            }
            .disposed(by: disposeBag)
        
        publish.onNext(4) // Observer / Observable -> Observer
        publish.onNext(5) // Observer
        publish.onNext(6) // Observer
        
    }
    
}

