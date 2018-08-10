//
//  ReduceImageSizeProcessor.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import Kingfisher
import UIKit

struct ReduceImageSizeProcessor: ImageProcessor {
    // MARK: - Properties -
    let identifier = "com.nodes.ReduceImageSizeProcessor"
    
    // MARK: - Methods -
    func process(item: ImageProcessItem, options: KingfisherOptionsInfo) -> Image? {
        switch item {
        case .image(let image):
            return resizeImageToFit(image: image)
        case .data(let data):
            return resizeImageToFit(image: UIImage(data: data))
        }
    }
    
    private  func resizeImageToFit(image: UIImage?) -> UIImage? {
        guard
            let image = image,
            let cgImage = image.cgImage,
            let colorSpace = cgImage.colorSpace
            else {
                return nil
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let bitmapInfo = cgImage.bitmapInfo
        
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue)
            else {
                return nil
        }
        
        context.interpolationQuality = .default
        context.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width: CGFloat(width), height: CGFloat(height))))
        
        return context.makeImage().flatMap { UIImage(cgImage: $0) }
    }
}
