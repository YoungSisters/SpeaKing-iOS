//
//  SignUpProfileViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/31.
//

import UIKit
import PhotosUI

class SignUpProfileViewController: UIViewController {
    
    var userInfo: SignUpModel!
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
    
    private var signUpService: AuthServiceProtocol!

    init(signUpService: AuthServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.signUpService = signUpService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupSignUpProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupSignUpProfileView() {
        signUpProfileView.delegate = self
        
        view = signUpProfileView
    }
}

extension SignUpProfileViewController: ProfileEditViewDelegate, SignUpProfileViewDelegate {
    func openImagePicker() {
        
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func postSignUp() {
        signUpService.signUp(self.userInfo) { response in
            print(response)
            self.navigationController?.pushViewController(SignUpDoneViewController(), animated: true)

        }
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
