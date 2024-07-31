//
//  AddingNumbersViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class AddingNumbersViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    private var number1 = UITextField()
    private var number2 = UITextField()
    private var number3 = UITextField()
    
    private var result = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        configAddingNumbersObservable()
    }
    
    private func configureHierarchy() {
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(result)
    }
    
    private func configureLayout() {
        number1.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        number2.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(number1.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        number3.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(number2.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        result.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(number3.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        number1.layer.borderWidth = 1
        number1.layer.borderColor = UIColor.lightGray.cgColor
        number2.layer.borderWidth = 1
        number2.layer.borderColor = UIColor.lightGray.cgColor
        number3.layer.borderWidth = 1
        number3.layer.borderColor = UIColor.lightGray.cgColor
        result.layer.borderWidth = 1
        result.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func configAddingNumbersObservable() {
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) {
            textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) +  (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map{ "= \($0.description)" }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }
    
}
