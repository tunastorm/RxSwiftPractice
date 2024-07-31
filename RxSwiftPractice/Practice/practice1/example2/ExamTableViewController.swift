//
//  ExamTableViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


final class ExamTableViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let label = UILabel()
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        setTableView()
    }
    
    private func configureHierarchy() {
        view.addSubview(label)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        
        label.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private func configureView() {
        view.backgroundColor = .white
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExamCell")
        
        let items = Observable.just([
            "1st Item",
            "2nd Item",
            "3rd Item"
        ])
        
        items
        .bind(to: tableView.rx.items) {(tableView, row, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExamCell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = "\(element) @row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map { data in  "\(data)를 클릭했습니다" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
}
