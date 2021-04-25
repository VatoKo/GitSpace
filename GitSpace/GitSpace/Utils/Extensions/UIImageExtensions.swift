//
//  UIImageExtensions.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import UIKit

// Source: https://stackoverflow.com/questions/6672517/is-programmatically-inverting-the-colors-of-an-image-possible
extension UIImage {
    func inverseImage(cgResult: Bool) -> UIImage? {
        let coreImage = UIKit.CIImage(image: self)
        guard let filter = CIFilter(name: "CIColorInvert") else { return nil }
        filter.setValue(coreImage, forKey: kCIInputImageKey)
        guard let result = filter.value(forKey: kCIOutputImageKey) as? UIKit.CIImage else { return nil }
        if cgResult {
            return UIImage(cgImage: CIContext(options: nil).createCGImage(result, from: result.extent)!)
        }
        return UIImage(ciImage: result)
    }
}
