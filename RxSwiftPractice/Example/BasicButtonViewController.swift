//
//  BasicButtonViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


final class BasicButtonViewController: UIViewController {
    
    private let button = UIButton()
    private let label = UILabel()
    
    private let textField = UITextField()
    private let secondLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
//        firstExample()
        secondExample()
        
        present(OperatorViewController(), animated: false)
        // 10. Quiz
//        label.rx.text.subscribe -> 안 되는 이유
        
    }
    
    private func configureView() {
        view.addSubview(button)
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(secondLabel)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(100)
        }
        
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(label.snp.bottom).offset(20)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(textField.snp.bottom).offset(20)
        }
        textField.backgroundColor = .magenta
        secondLabel.backgroundColor = .lightGray
        
        view.backgroundColor = .white
        button.backgroundColor = .blue
        label.backgroundColor = .lightGray
        "test".description

    }
    
    private func secondExample() {
        button.rx.tap
            .map { "버튼을 다시 클릭했어요: \(Int.random(in: 1...100))" }
            .bind(to: secondLabel.rx.text, textField.rx.text )
            .disposed(by: disposeBag)
        
    }
    
    private func firstExample() {
        // 1. 원본
        // infinite observable stream
//        let example = button // UIButton
//            .rx              // reactive
//            .tap             // ControlEvent<Void>
//            .subscribe { _ in
//                self.label.text = "버튼을 클릭했어요"
//                print("next")
//            } onError: { error in
//                print("error")
//            } onCompleted: {
//                print("completed")
//            } onDisposed: {
//                print("disposed")
//            }
//            .disposed(by: disposeBag)
//        // 2.
//        // 에러 이벤트가 발생할 일이 없는 케이스
//        button.rx.tap
//            .subscribe { _ in
//                self.label.text = "버튼을 클릭했어요"
//                print("next")
//            } onDisposed: {
//                print("disposed")
//            }
//            .disposed(by: disposeBag)
//        // 3. memory leak 발생 가능 케이스 처리 기본형
//        button.rx.tap
//            .subscribe { [weak self] _ in
//                self?.label.text = "버튼을 클릭했어요"
//                print("next")
//            } onDisposed: {
//                print("disposed")
//            }
//            .disposed(by: disposeBag)
//        // 4. RxSwift의 memory leak 처리 연산자 사용
//        button.rx.tap
//            .withUnretained(self)
//            .subscribe { [weak self] _ in
//                self?.label.text = "버튼을 클릭했어요"
//                print("next")
//            } onDisposed: {
//                print("disposed")
//            }
//            .disposed(by: disposeBag)
//        // 5. with 매개변수 사용한 memory leak 처리
//        button.rx.tap
//            .subscribe(with: self, onNext: { owner, _ in
//                // 누수발생중 self.label.text = "버튼을 클릭했어요"
//                owner.label.text = "버튼을 클릭했어요"
//                print("next")
//            }, onDisposed: { owner in
//                print("disposed")
//            })
//            .disposed(by: disposeBag)
//        
//        //6. UIKit의 특성
//        // subscribe: Thread Unsafe, 백그라운드에서도 동작됨,
//        // 보라색 오류 뜰 수 있음
//        button.rx.tap
//            .subscribe(with: self, onNext: { owner, _ in
//                DispatchQueue.main.async {
//                    owner.label.text = "버튼을 클릭했어요"
//                }
//            }, onDisposed: { owner in
//                print("disposed")
//            })
//            .disposed(by: disposeBag)
//        // 7. 스레드 할당 메서드
//        button.rx.tap
//            .observe(on: MainScheduler.instance) // 이후의 동작을 MainQueue에 할당
//            .subscribe(with: self, onNext: { owner, _ in
//                owner.label.text = "버튼을 클릭했어요"
//            }, onDisposed: { owner in
//                print("disposed")
//            })
//            .disposed(by: disposeBag)
//        // 8. 설정없이도 메인쓰레드로 동작시켜주는 메서드는 왜  안만드냐 + 애초에 error를 안받는 메서드는 없냐
//        button.rx.tap
//            .bind(with: self, onNext: { owner, _ in
//                owner.label.text = "버튼을 클릭했어요"
//            })
//            .disposed(by: disposeBag)
        // ========== 오늘은 여기까지만 이해해도 됨 ======= /
        // 9.
        button.rx.tap
            .map { "버튼을 클릭했어요" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}


