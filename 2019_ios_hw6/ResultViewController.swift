//
//  ResultViewController.swift
//  2019_ios_hw6
//
//  Created by 王心妤 on 2019/4/1.
//  Copyright © 2019年 river. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController{
    var arg = RenderArg()
    @IBOutlet weak var resultImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultImage.image = build()
    }
    @IBAction func share(_ sender: Any) {
        if let image = resultImage.image{
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
        
    }
    func build() -> UIImage?{
        let resultWidth = [950, 1330]
        let resultHeight = [1330, 950]
        if arg.style != nil{
            let resultSize = CGRect(x: 0, y: 0, width: resultWidth[arg.style], height: resultHeight[arg.style])
            let result = UIView(frame: resultSize)
            result.backgroundColor = UIColor.white
            let imageView = buildImage()
            result.addSubview(imageView!)
            let contentLabel = buildLabel()
            let dateLabel = buildDate()
            result.addSubview(contentLabel!)
            result.addSubview(dateLabel!)
            return result.toimage
        }
        return nil
    }
    func buildImage() -> UIImageView?{
        let imageWidth = [731, 1024]
        let imageHeight = [1024, 731]
        let filter = ["CIPhotoEffectInstant", "CIPhotoEffectNoir", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CIPhotoEffectFade", "CIPhotoEffectProcess", "CIPhotoEffectMono"]
        let x = [109, 153]
        let y = [153, 109]
        if arg.style != nil{
            let imageSize = CGRect(x: x[arg.style], y: y[arg.style], width: imageWidth[arg.style], height: imageHeight[arg.style])
            let imageView = UIImageView(frame: imageSize)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            if arg.useFilter == true{
                let ciImage = CIImage(image: arg.pic!)
                if let filter = CIFilter(name: filter[arg.filter]) {
                    filter.setValue(ciImage, forKey: kCIInputImageKey)
                    //filter.setValue(arg.filterVolume, forKey: kCIInputIntensityKey)
                    if let outputImage = filter.outputImage, let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) {
                        let image = UIImage(cgImage: cgImage)
                        imageView.image = image
                    }
                }
            }else{
                imageView.image = arg.pic
            }
            imageView.alpha = CGFloat(arg.alpha)
            return imageView
        }
        return nil
    }
    func strVerticalize(){
        var newStr = ""
        for i in arg.content{
            newStr.append(i)
            newStr.append("\n")
        }
        arg.content = newStr
    }
    func buildLabel() -> UILabel?{
        let labelSize: CGRect
        if arg.style == 0 {
            strVerticalize()
            labelSize = CGRect(x: 49, y: 153, width: 731, height: 1024)
        }else{
            labelSize = CGRect(x: 153, y: 850, width: 1024, height: 1024)
        }
        let contentLabel = UILabel(frame: labelSize)
        contentLabel.text = arg.content
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 50)
        contentLabel.sizeToFit()
        return contentLabel
    }
    func buildDate() -> UILabel?{
        // date -> str
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateStr = dateFormatter.string(from: arg.date)
        // build label
        let labelSize: CGRect
        if arg.style == 0 {
            labelSize = CGRect(x: 620, y: 1130, width: 731, height: 1024)
        }else{
            labelSize = CGRect(x: 960, y: 790, width: 731, height: 1024)
        }
        let dateLabel = UILabel(frame: labelSize)
        dateLabel.text = dateStr
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont.systemFont(ofSize: 40)
        dateLabel.textColor = UIColor.white
        dateLabel.sizeToFit()
        return dateLabel
    }
}

extension UIView {
    var toimage: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
}
