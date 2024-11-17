//
//  UIImageExtension.swift
//  SwiftUITemplate
//
//  Created by Kiet Truong on 05/07/2023.
//

import SwiftUI

extension UIImage {
    
    /// Compress image for the given height and quality
    ///
    /// - Parameters:
    ///     - newHeight: Height for the compressed image
    ///     - quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
    func compress(newHeight: CGFloat, quality: CGFloat) -> UIImage {
        let resizedImage = self.aspectFittedToHeight(newHeight)
        resizedImage.jpegData(compressionQuality: quality)
        return resizedImage
    }
    
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
