//
//  ViewController.swift
//  Share Photo
//
//  Created by 安部学 on 2020/02/24.
//  Copyright © 2020 Manabu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }


    @IBOutlet weak var pictureImage: UIImageView!
    

    @IBAction func cameraButtonAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action) in
            
                let imagePickerController = UIImagePickerController()
            
                imagePickerController.sourceType = .camera
            
                imagePickerController.delegate = self
            
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action) in
                
                let imagePicerController = UIImagePickerController()
                
                imagePicerController.sourceType = .photoLibrary
                
                imagePicerController.delegate = self
                
                self.present(imagePicerController, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func shareButtonAction(_ sender: Any) {

        if let shareImage = pictureImage.image {

            let shareItems = [shareImage]

            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)

            controller.popoverPresentationController?.sourceView = view

            present(controller,animated: true, completion: nil)
        }

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        dismiss(animated: true, completion: {
            
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
    
    }
    
    var captureImage : UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nextViewController = segue.destination as? EffectViewController {
            
            nextViewController.originalImage = captureImage
        }
    }
}
