//
//  NewsViewController.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable
import Kingfisher

class NewsViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel = NewsStore()
    private let disposeBag = DisposeBag()
    
    // MARK: UI
    private let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(cellType: ArticleTableViewCell.self)
        return tableView
    }()
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = newsTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        viewModel.observeDatabase()
        viewModel.updateNews()
    }
    
    // MARK: Setting Methods
    private func setupNavigation() {
        navigationItem.title = "Exam"
    }
    
    private func setupTableView() {
        viewModel.articleSubject.bind(to: newsTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0),
                                                        cellType: ArticleTableViewCell.self)
            let vm = ArticleViewModel(article: element)
            cell.configure(with: vm)
            return cell
        }.disposed(by: disposeBag)
    }
}
