//
//  ExamSwitchViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ExamSwitchViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let examSwitch = UISwitch()
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
        setSwitch()
    }
    
    private func configHierarchy() {
        view.addSubview(examSwitch)
    }
    
    private func configLayout() {
        examSwitch.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(60)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configView() {
        view.backgroundColor = .white
    }
    
    private func setSwitch() {
        Observable.of(false)
            .bind(to: examSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
}
