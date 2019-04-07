//
//  ViewController.swift
//  2019_ios_hw6
//
//  Created by 王心妤 on 2019/3/27.
//  Copyright © 2019年 river. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var useFilter: UISwitch!
    @IBOutlet weak var content: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var stylePicker: UISegmentedControl!
    @IBOutlet weak var filterPicker: UIPickerView!
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var alphaPicker: UISlider!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func goToResult(_ sender: Any) {
        if photoImageView.image == nil{
            warningLabel.text = "照片為必填欄位"
        }else{
            warningLabel.text = ""
            self.performSegue(withIdentifier: "showResult", sender: " ")
        }
    }
    @IBAction func swichChange(_ sender: Any) {
        if useFilter.isOn == true{
            filterPicker.alpha = 1
        }else{
            filterPicker.alpha = 0.5
        }
    }
    @IBAction func alphaValueChanged(_ sender: Any) {
        let alpha = String(format: "%.2f", alphaPicker.value)
        alphaLabel.text = alpha
    }
    @IBAction func pickPicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ResultViewController
        let data = RenderArg(content: content.text, pic: photoImageView.image, date: datePicker.date, alpha: Double(alphaPicker.value), style: stylePicker.selectedSegmentIndex, filter: filterPicker.selectedRow(inComponent: 0), useFilter: useFilter.isOn)
        controller.arg = data
    }
    
    // picker view config
    let name = ["懷舊", "黑白", "色調", "歲月", "褪色", "沖印", "單色"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return name.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return name[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterPicker.delegate = self
        filterPicker.dataSource = self
    }

}

