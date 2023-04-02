//
//  SignUpProfileViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/31.
//

import UIKit
import PhotosUI

class SignUpProfileViewController: UIViewController {
    
    private var signUpProfileView = SignUpProfileView()
    
    var configuration: PHPickerConfiguration = {
        let configuration = PHPickerConfiguration()
        
//        configuration.filter = .images
        
        return configuration
    }()
    
    lazy var picker = PHPickerViewController(configuration: self.configuration)
    
    var contentView: SignUpProfileView {
        return view as! SignUpProfileView
    }
    
    override func loadView() {
        super.loadView()
        setupSignUpProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSignUpProfileView() {
        signUpProfileView.delegate = self
        
        view = signUpProfileView
    }
}

extension SignUpProfileViewController: ProfileEditViewDelegate, NavigationDelegate {
    func openImagePicker() {
        
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func pushNextViewController() {
        self.navigationController?.pushViewController(SignUpDoneViewController(), animated: true)
    }
    
    func navigateBack() {
        
    }
}

extension SignUpProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.signUpProfileView.setProfileImage(image: image as? UIImage)
                }
            }
        }
    }
}
