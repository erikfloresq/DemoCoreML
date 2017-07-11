//
//  SqueezeNetViewController.swift
//  DemoCoreML
//
//  Created by Erik Flores on 11/07/17.
//  Copyright © 2017 Orbis Ventures. All rights reserved.
//

import UIKit

class SqueezeNetViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prediction: UILabel!
    
    let imageResource:[UIImage] = [#imageLiteral(resourceName: "Lion"),#imageLiteral(resourceName: "Panda"),#imageLiteral(resourceName: "Auto"),#imageLiteral(resourceName: "Chow"),#imageLiteral(resourceName: "SaintBernard")]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.predict(image: self.imageView.image!)
    }
    
    func predict(image:UIImage) {
        let model = SqueezeNet()
        guard let squeezeNetOutput = try? model.prediction(image: Please.generatePixelBuffer(from: image)!) else {
            fatalError("Unexpected runtime error.")
        }
        self.prediction.text = squeezeNetOutput.classLabel
    }

}

extension SqueezeNetViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageResource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.photo.image = self.imageResource[indexPath.row]
        return cell
    }
    
}

extension SqueezeNetViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imageView.image = self.imageResource[indexPath.row]
        self.predict(image: self.imageResource[indexPath.row])
    }
}


