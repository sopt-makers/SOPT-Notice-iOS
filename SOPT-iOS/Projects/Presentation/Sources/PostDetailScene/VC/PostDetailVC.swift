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
    private var cancelBag = Set<AnyCancellable>()
    
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var sampleImages:[Image] = []
  
    // MARK: - UI Components
    
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
        self.applySnapshot()
        self.generateImages()
    }
}

// MARK: - UI & Layout

extension PostDetailVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(postDetailCollectionView)
        
        postDetailCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
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
            switch Section.type(indexPath.section) {
            case .title:
                guard let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailTitleCVC.className, for: indexPath) as? PostDetailTitleCVC else { return UICollectionViewCell() }
                return titleCell
                
            case .images:
                guard let imagesCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailImagesCVC.className, for: indexPath) as? PostDetailImagesCVC else { return UICollectionViewCell() }
                imagesCell.imageViewTapped
                    .sink { error in
                        print(error)
                    } receiveValue: { [weak self] in
                        guard let self = self else { return }
                        self.presentImageSlide()
                    }.store(in: &self.cancelBag)

                return imagesCell
                
            case .content:
                guard let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailContentCVC.className, for: indexPath) as? PostDetailContentCVC else { return UICollectionViewCell() }
                return contentCell
            }
        })
    }
    
    // TODO: - image 수에 따라 데이터 받고 appendItems 분기처리하기
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.title, .images, .content])
        snapshot.appendItems([1],toSection: .title)
        snapshot.appendItems([2],toSection: .images)
        snapshot.appendItems([3],toSection: .content)
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
