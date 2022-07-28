//
//  ProblemFormViewController.swift
//  ProblemsCity
//
//  Created by Lucas Oliveira de Borba on 27/07/22.
//

import UIKit

class ProblemFormViewController: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldDate: UITextField!
    @IBOutlet weak var imageViewProblem: UIImageView!
    @IBOutlet weak var textFieldDescription: UITextView!
    @IBOutlet weak var buttonAddEdit: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var problem: Problem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.keyboardDismissMode = .interactive
        
        if let problem = problem {
            title = "Edição"
            textFieldName.text = problem.name
            textFieldAddress.text = problem.address
            textFieldDate.text = problem.date
            textFieldDescription.text = problem.occurrence
            if let image = problem.image{
                imageViewProblem.image = UIImage(data: image)
            }
            buttonAddEdit.setTitle("Alterar", for: .normal)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else{
            return
        }
        
        scrollView.contentInset.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
    }
    @objc func keyboardWillHide(){
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    
    @IBAction func selectImageProblem(_ sender: Any) {
        
        let alert = UIAlertController(title: "Selecionar Imagem", message: "De onde você deseja escolher a imagem?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Câmera", style: .default){_ in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        let libraryAction = UIAlertAction(title: "Biblioteca de Fotos", style: .default){
            _ in self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Álbum de Fotos", style: .default){
            _ in self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
            
    func selectPicture(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if problem == nil {
            problem = Problem(context: context)
        }
        problem?.name = textFieldName.text
        problem?.address = textFieldAddress.text
        problem?.date = textFieldDate.text
        problem?.occurrence = textFieldDescription.text
        problem?.image = imageViewProblem.image?.jpegData(compressionQuality: 0.9)
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
}

extension ProblemFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage]as? UIImage{
            imageViewProblem.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
