//
//  PostListPageView.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

final class PostListPageView: UIView {
    
    // MARK: - Properties
    
    lazy var dataSource: UITableViewDiffableDataSource<Int, UUID>! = nil

    // MARK: - UI Components
    
    private lazy var postListTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        self.setLayout()
        self.setDelegate()
        self.registerCells()
        self.setDataSource()
        self.applySnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Methods

extension PostListPageView {
    
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        addSubviews(postListTableView)
        postListTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        self.postListTableView.delegate = self
    }
    
    private func registerCells() {
        self.postListTableView.register(PostListTableViewCell.self, forCellReuseIdentifier: PostListTableViewCell.className)
    }
}

// MARK: - DiffableDataSource

extension PostListPageView {
    private func setDataSource() {
        self.dataSource = UITableViewDiffableDataSource(tableView: postListTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.className, for: indexPath)
            cell.selectionStyle = .none
            return cell
        })
        
        self.postListTableView.dataSource = self.dataSource
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UUID>()
        snapshot.appendSections([0])
        snapshot.appendItems([UUID(), UUID(), UUID(), UUID()])
        self.dataSource.apply(snapshot)
    }
}

// MARK: - UITableViewDelegate

extension PostListPageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
