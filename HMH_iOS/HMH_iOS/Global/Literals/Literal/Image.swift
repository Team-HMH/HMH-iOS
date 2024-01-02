//
//  Image.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/2/24.
//

import UIKit

enum ImageLiterals {
    enum NavigationBar {
        static var icArrowLeft: UIImage { .load(named: "ic_back")}
    }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        return image
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
