//
//  ResNet50ViewController.swift
//  DemoCoreML
//
//  Created by Erik Flores on 11/07/17.
//  Copyright © 2017 Orbis Ventures. All rights reserved.
//

import UIKit

class ResNet50ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prediction: UILabel!
    
     let imageResource:[UIImage] = [#imageLiteral(resourceName: "Lion224"),#imageLiteral(resourceName: "Panda224"),#imageLiteral(resourceName: "Chow224"),#imageLiteral(resourceName: "Auto224"),#imageLiteral(resourceName: "SaintBernard224")]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.predict(image: self.imageView.image!)
    }
    
    func predict(image:UIImage) {
        let model = Resnet50()
        guard let resNet50Output = try? model.prediction(image: Please.generatePixelBuffer(from: image)!) else {
            fatalError("Unexpected runtime error.")
        }
        self.prediction.text = resNet50Output.classLabel
    }

}

extension ResNet50ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageResource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.photo.image = self.imageResource[indexPath.row]
        return cell
    }
    
}

extension ResNet50ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imageView.image = self.imageResource[indexPath.row]
        self.predict(image: self.imageResource[indexPath.row])
    }
}
