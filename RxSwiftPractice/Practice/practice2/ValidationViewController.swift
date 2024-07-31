//
//  ValidationViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ValidationViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    private var usernameTextField = UITextField()
    private var usernameValidLabel = UILabel()
    
    private var passwordTextField = UITextField()
    private var passwordValidLabel = UILabel()
    
    private var doSomethingButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        configureObservable()
    }
    
    private func configureHierarchy() {
        view.addSubview(usernameTextField)
        view.addSubview(usernameValidLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidLabel)
        view.addSubview(doSomethingButton)
    }
    
    private func configureLayout() {
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        usernameValidLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(usernameValidLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        passwordValidLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        doSomethingButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        doSomethingButton.backgroundColor = .lightGray
        doSomethingButton.setTitle("검사", for: .normal)
        
        usernameValidLabel.text = "닉네임은 최소 \(minimalUsernameLength)글자 이상이어야 합니다."
        passwordValidLabel.text = "비밀번호는 최소 \(minimalPasswordLength)글자 이상이어야 합니다."
       
    }
    
    private func configureObservable() {
        
        UILabel().rx.text.mapObserver(<#T##transform: (Result) throws -> String?##(Result) throws -> String?#>)
        
        
        let usernameValid = usernameTextField.rx.text.orEmpty
                            .map { $0.count >= self.minimalUsernameLength }
                            .share(replay: 1)
        let passwordValid = passwordTextField.rx.text.orEmpty
                            .map { $0.count >= self.minimalPasswordLength }
                            .share(replay: 1)
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
                            .share(replay: 1)
        usernameValid
            .bind(to: passwordValidLabel.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingButton.rx.tap
            .subscribe(with: self) { owner, _ in
                self.showAlert(style: .alert, title: "Rx 예시", message: "이건 굉장해!", completionHandler: nil)
            }
            .disposed(by: disposeBag)
    }
}
