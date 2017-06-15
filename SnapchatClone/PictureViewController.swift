//
//  PictureViewController.swift
//  SnapchatClone
//
//  Created by JuanJ on 6/14/17.
//  Copyright © 2017 JJB. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self 

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker,animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        nextButton.isEnabled = false
        let imagesFolder = Storage.storage().reference().child("images")
        
        // jpeg es mas facil de trabajar porque ocupa menos espacio
        
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        //NSUUID, es utilizado para darle un nombre propio a la imagen 
        
        imagesFolder.child("\(NSUUID().uuidString).png").putData(imageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload")
            if error != nil {
                print("We have an error")
            } else {
                print(metadata?.downloadURL())
                self.performSegue(withIdentifier: "selectUsersSegue", sender: nil)
            }
        })

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
