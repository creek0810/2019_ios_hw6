//
//  LoadingViewController.swift
//  2019_ios_hw6
//
//  Created by 王心妤 on 2019/4/4.
//  Copyright © 2019年 river. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet var loadingView: UIView!
    override func viewDidLoad() {
        // establish image mask
        let image = UIImage(named: "logo")
        let imageView = UIImageView(frame: loadingView.bounds)
        imageView.image = image
        imageView.contentMode = .center
       
        // use random function to build gradient layer
        let color = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor]
        let color1 = color.randomElement()
        var color2 = color.randomElement()
        while(color2 == color1){
            color2 = color.randomElement()
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [color1, color2]
        
        // combine the gradientLayer shapeLayer and imageView
        loadingView.layer.addSublayer(gradientLayer)
        loadingView.mask = imageView
        
        
        super.viewDidLoad()
        // wait 3 seconds and goto main controller
        var timer: Timer?
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (_) in
            self.performSegue(withIdentifier: "goToMain", sender: " ")
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! UINavigationController
    }
}
