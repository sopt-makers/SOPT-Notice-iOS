//
//  PostDetailModel.swift
//  Domain
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import ImageSlideShow

public struct PostDetailModel {
    public let title: Title
    public let images: [Image]
    public let content: Content
    
    public init(title: Title, images: [Image], content: Content) {
        self.title = title
        self.images = images
        self.content = content
    }
}

extension PostDetailModel {
    public struct Title: Hashable {
        public let title: String
        public let writer: String
        public let date: String
        
        public init(title: String, writer: String, date: String) {
            self.title = title
            self.writer = writer
            self.date = date
        }
    }
}

extension PostDetailModel {
    public struct Image: Hashable {
        public let imageURL: String
        
        public init(imageURL: String) {
            self.imageURL = imageURL
        }
    }
}

extension PostDetailModel {
    public struct Content: Hashable {
        public let content: String
        
        public init(content: String) {
            self.content = content
        }
    }
}

public class ImageSlideShowImages: NSObject, ImageSlideShowProtocol {
    private let url: URL
    public let title: String?
    
    public init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
    
    public func slideIdentifier() -> String {
        return String(describing: url)
    }
    
    public func image(completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
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
