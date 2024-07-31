//
//  ExamTableViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ExampleTableViewController: ViewController, UITableViewDelegate {
    
    private let tableView = UITableView()
    
    private let items = Observable.just(
        (0..<20).map { String($0) }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        configureHierarchy()
        configureLayout()
        configureView()
        configureObservable()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func configureObservable() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
        .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { value in
                DefaultWireframe.presentAlert("\(value) 누름")
            })
        .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("\(indexPath.section), \(indexPath.row) 누름")
            })
        .disposed(by: disposeBag)
        
    }

}
