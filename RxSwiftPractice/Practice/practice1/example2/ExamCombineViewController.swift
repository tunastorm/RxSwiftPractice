//
//  ExamCombineViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ExamCombineViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let signNameTextField = UITextField()
    
    private let signEmailTextField = UITextField()
    
    private let label = UILabel()
    
    private let signButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
        setSign()
    }
    
    private func configHierarchy() {
        view.addSubview(signNameTextField)
        view.addSubview(signEmailTextField)
        view.addSubview(label)
        view.addSubview(signButton)
    }
    
    private func configLayout() {
        signNameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        signEmailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(signNameTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(signEmailTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        signButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func configView() {
        view.backgroundColor = .white
        signNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        signNameTextField.layer.borderWidth = 1
        signEmailTextField.layer.borderColor = UIColor.lightGray.cgColor
        signEmailTextField.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        signButton.backgroundColor = .gray
    }
    
    private func setSign() {
        Observable.combineLatest(signNameTextField.rx.text.orEmpty, signEmailTextField.rx.text.orEmpty) { value1, value2 in
            return "name은 \(value1)이고, 이메일은 \(value2)입니다"
        }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        signNameTextField.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: signEmailTextField.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmailTextField.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap.subscribe { _ in
            self.showAlert(style: .alert, title: "테스트", message: "테스트 얼럿이에요", completionHandler: { _ in  print("가입됨") })
        }
        .disposed(by: disposeBag)
    }
    
}
