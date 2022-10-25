//
//  PostDetailVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import Combine

import Core

import ImageSlideShow
import SnapKit
import Then

public class PostDetailVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: PostDetailViewModel!
    private var cancelBag = CancelBag()
    
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>! = nil
    
    var sampleImages:[Image] = []
  
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .leftTitleWithLeftButton)
        .setTitle("전체")
    
    private lazy var postDetailCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        cv.showsVerticalScrollIndicator = true
        cv.backgroundColor = .white
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return cv
    }()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
        self.setDelegate()
        self.registerCells()
        self.bindViewModels()
        self.setDataSource()
        self.generateImages()
    }
}

// MARK: - UI & Layout

extension PostDetailVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(naviBar, postDetailCollectionView)
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        postDetailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension PostDetailVC {
    private func setDelegate() {
        postDetailCollectionView.delegate = self
    }
    
    private func registerCells() {
        PostDetailTitleCVC.register(target: postDetailCollectionView)
        PostDetailImagesCVC.register(target: postDetailCollectionView)
        PostDetailContentCVC.register(target: postDetailCollectionView)
    }
}

// MARK: - Bind

extension PostDetailVC {
  
    private func bindViewModels() {
        let input = PostDetailViewModel.Input()
        let input = PostDetailViewModel.Input(viewDidLoad: Driver.just(()),
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
        output.$postDetailModel
            .compactMap { $0 }
            .sink { model in
                self.applySnapshot(item: model)
            }.store(in: self.cancelBag)
    }

    private func presentImageSlide() {
        ImageSlideShowViewController.presentByCustomTransitionFrom(self){ [weak self] controller in
            controller.dismissOnPanGesture = false
            controller.slides = self?.sampleImages
            controller.enableZoom = true
            controller.controllerDidDismiss = {
                debugPrint("Controller Dismissed")

                debugPrint("last index viewed: \(controller.currentIndex)")
            }
            controller.slideShowViewDidLoad = {
                debugPrint("Did Load")
            }
            controller.slideShowViewWillAppear = { animated in
                debugPrint("Will Appear Animated: \(animated)")
            }
            controller.slideShowViewDidAppear = { animated in
                debugPrint("Did Appear Animated: \(animated)")
            }
        }
    }
}

// MARK: - DiffableDataSource

extension PostDetailVC {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: postDetailCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
        dataSource = UICollectionViewDiffableDataSource(collectionView: postDetailCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch Section.type(indexPath.section) {
            case .title:
                guard let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailTitleCVC.className, for: indexPath) as? PostDetailTitleCVC,
                      let model = itemIdentifier as? PostDetailModel.Title else { return UICollectionViewCell() }
                titleCell.setData(model: model)
                return titleCell
                
            case .images:
                guard let imagesCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailImagesCVC.className, for: indexPath) as? PostDetailImagesCVC,
                      let model = itemIdentifier as? [PostDetailModel.Image] else { return UICollectionViewCell() }
                imagesCell.imageViewTapped
                    .sink { error in
                        print(error)
                    } receiveValue: { [weak self] in
                        guard let self = self else { return }
                        self.presentImageSlide()
                    }.store(in: &self.cancelBag)

                imagesCell.setData(model: model)
                return imagesCell
                
            case .content:
                guard let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailContentCVC.className, for: indexPath) as? PostDetailContentCVC,
                      let model = itemIdentifier as? PostDetailModel.Content else { return UICollectionViewCell() }
                contentCell.setData(model: model)
                return contentCell
            }
        })
    }
    
    func applySnapshot(item: PostDetailModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.title, .images, .content])
        snapshot.appendItems([item.title], toSection: .title)
        if !item.images.isEmpty {
            snapshot.appendItems([item.images], toSection: .images)
        }
        snapshot.appendItems([item.content], toSection: .content)
        dataSource.apply(snapshot, animatingDifferences: false)
        self.view.setNeedsLayout()
    }
}

// MARK: - UICollectionViewDelegate

extension PostDetailVC: UICollectionViewDelegate {
    
}

extension PostDetailVC: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ImageSlideShowViewController.presentLikePush
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ImageSlideShowViewController.dismissLikePush
    }
}

extension PostDetailVC {
    fileprivate func generateImages()
    {
        let scale:Int = Int(UIScreen.main.scale)
        let height:Int = Int(view.frame.size.height) * scale
        let width:Int = Int(view.frame.size.width) * scale
        
        sampleImages = [
            Image(title: "Image 1", url: URL(string: "https://dummyimage.com/\(width)x\(height)/09a/fff.png&text=Image+1")!),
            Image(title: "Image 2", url: URL(string: "https://dummyimage.com/\(600)x\(600)/09b/fff.png&text=Image+2")!),
            Image(title: "Image 3", url: URL(string: "https://dummyimage.com/\(width)x\(height)/09c/fff.png&text=Image+3")!),
            Image(title: "Image 4", url: URL(string: "https://dummyimage.com/\(600)x\(600)/09d/fff.png&text=Image+4")!),
            Image(title: "Image 5", url: URL(string: "https://dummyimage.com/\(width)x\(height)/09e/fff.png&text=Image+5")!),
            Image(title: "Image 6", url: URL(string: "https://dummyimage.com/\(width)x\(height)/09f/fff.png&text=Image+6")!),
        ]
    }
}

class Image: NSObject, ImageSlideShowProtocol
{
    private let url: URL
    let title: String?
    
    init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
    
    func slideIdentifier() -> String {
        return String(describing: url)
    }
    
    func image(completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: self.url) { data, response, error in
            if let data = data,
               error == nil {
                let image = UIImage(data: data)
                completion(image, nil)
            } else {
                completion(nil, error)
            }
        }.resume()
    }
}
