//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by 임태빈 on 2021/04/01.
//

import UIKit
import Photos
import PhotosUI
class GalleryViewController: UIViewController {



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    let imagePicker = UIImagePickerController()
    var configuration = PHPickerConfiguration()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let picker =  PHPickerViewController(configuration: configuration)
    
        self.present(picker, animated: true, completion: nil)
        // requestPhotosPermission()
//        imagePicker.allowsEditing = true
//
//        imagePicker.sourceType = .photoLibrary
//
//        //imagePicker.sourceType = .camera
//        present(imagePicker,animated: true,completion: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonDidTap(_ sender: Any) {
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 0
    configuration.filter = .any(of: [.images, .videos])
    let picker = PHPickerViewController(configuration: configuration)
    
    self.present(picker, animated: true, completion: nil)
    }
    func settingLibrary() -> Void{
        
        configuration.filter = .images
        
    }

}


extension ViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) // 1
        let itemProvider = results.first?.itemProvider // 2
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // 4
                DispatchQueue.main.async {
                    self.myImageView.image = image as? UIImage // 5
                }
            }
        } else { // TODO: Handle empty results or item provider not being able load UIImage
            
        }
    }

    
}
