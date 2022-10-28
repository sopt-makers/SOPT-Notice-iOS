//
//  PostListPageView.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Domain

final class PostListPageView: UIView {
    
    // MARK: - Properties
    
    lazy var diffableDataSource: UITableViewDiffableDataSource<Int, PostListModel>! = nil
    private var postList: [PostListModel] = []

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
        self.diffableDataSource = UITableViewDiffableDataSource<Int, PostListModel>(tableView: postListTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.className, for: indexPath)
                    as? PostListTableViewCell else { return UITableViewCell() }
            let data = self.postList[indexPath.row]
            cell.selectionStyle = .none
            cell.initCell(isNew: data.isNew, title: data.title, writer: data.writer, date: data.date)
            return cell
        })
        
        self.postListTableView.dataSource = self.diffableDataSource
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PostListModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(postList)
        self.diffableDataSource.apply(snapshot)
    }
    
    func setData(data: [PostListModel]) {
        self.postList = data
        applySnapshot()
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
