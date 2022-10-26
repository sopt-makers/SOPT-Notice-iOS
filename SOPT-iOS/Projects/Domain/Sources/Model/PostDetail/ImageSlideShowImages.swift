//
//  ImageSlideShowImages.swift
//  Domain
//
//  Created by Junho Lee on 2022/10/26.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import ImageSlideShow

public class ImageSlideShowImages: ImageSlideShowProtocol {
    private let url: URL?
    public let title: String?
    
    public init(title: String, url: String) {
        self.title = title
        self.url = URL(string: url)
    }
    
    public func slideIdentifier() -> String {
        return String(describing: url)
    }
    
    public func image(completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let url = self.url else { return completion(UIImage(), nil) }
        session.dataTask(with: url) { data, response, error in
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
