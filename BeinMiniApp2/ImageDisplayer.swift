//
//  ImageDisplayer.swift
//  BeinMiniApp2
//
//  Created by Batu Hayırlıoğlu on 17.09.2024.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        // Create a background task to fetch the image data
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                // Ensure the data can be converted into an image
                if let image = UIImage(data: data) {
                    // Switch back to the main thread to update the UI
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

