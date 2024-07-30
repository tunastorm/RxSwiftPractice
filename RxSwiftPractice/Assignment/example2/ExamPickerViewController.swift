//
//  ExamPickerViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ExamPickerViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let label = UILabel()

    private let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    
    private func configureHierarchy() {
        view.addSubview(label)
        view.addSubview(pickerView)
    }
    
    private func configureLayout() {
        
        label.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        pickerView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

    }
    
    private func configureView() {
        view.backgroundColor = .white
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        setPickerView()
    }
    
    private func setPickerView() {
        
        let items = Observable.just([
            "영화", "애니메이션", "드라마", "기타"
        ])
        
        items
        .bind(to: pickerView.rx.itemTitles) { (row, element) in
            return element
        }
        .disposed(by: disposeBag)
        
        
        pickerView.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
    }
    
}
