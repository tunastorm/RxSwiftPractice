//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by 유철원 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class TestViewController: UIViewController {

    private let tableView = UITableView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        configTableView()
//        testInterval()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureView() {
        tableView.backgroundColor = .gray
    }
    
    private func configTableView() {
        // Observable: 이벤트 전달
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        //Observer: Observable이 전달한 Event를 테이블 뷰에 데이터를 보여주는 형태로 처리
        items
        // subscribe
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag) // subscribe가 취소되는 부분
        
//        tableView.rx.itemSelected
//            .bind { indexPath in
//                print("\(indexPath)가 선택되었어요")
//            }
//            .disposed(by: disposeBag)
//        
//        tableView.rx.modelSelected(String.self)
//            .bind { indexPath in
//                print("\(indexPath)가 삭제되었습니다")
//            }.disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.itemSelected, 
                       tableView.rx.modelSelected(String.self))
        .bind {value in
            print(value.0, value.1)
        }
        .disposed(by: disposeBag)
        
    }
    
    private func testJust() {
        // item 전체가 방출됨
        Observable.just([1,2,3]) //Finite Observable Sequence
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print("error:")
            } onCompleted: {
                print("complete")
            } onDisposed: { // event에 해당하지 않음
                print("dispose")
            }
            .disposed(by:disposeBag)
    }
    
    private func testFrom() {
        // item이 iterator식으로 방출
        Observable.from([1,2,3]) //Finite Observable Sequence
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print("error:")
            } onCompleted: {
                print("complete")
            } onDisposed: { // event에 해당하지 않음
                print("dispose")
            }
            .disposed(by:disposeBag)
    }
    
    private func testInterval() {
        // InFinite Observable Sequence
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print("error:")
            } onCompleted: {
                print("complete")
            } onDisposed: { // event에 해당하지 않음
                print("dispose")
            }
            .disposed(by:disposeBag)
    }
}

