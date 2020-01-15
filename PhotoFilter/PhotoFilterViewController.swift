import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins
import Photos

class PhotoFilterViewController: UIViewController {

    @IBOutlet weak var brightnessSlider: UISlider!
    @IBOutlet weak var contrastSlider: UISlider!
    @IBOutlet weak var saturationSlider: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    
    var originalImage: UIImage? {
        didSet {
            updateImage()
        }
    }
    
    private let context = CIContext(options: nil)
    private let filter = CIFilter.colorControls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalImage = imageView.image
    }
    
    private func image(byFiltering image: UIImage) -> UIImage {
        return image
    }
    
    private func updateImage() {
        if let originalImage = originalImage {
            imageView.image = image(byFiltering: originalImage)
        } else {
            imageView.image = nil
        }
    }
    
    // MARK: Actions
    
    @IBAction func choosePhotoButtonPressed(_ sender: Any) {
        presentImagePickerController()
    }
    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("The photo library is not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func savePhotoButtonPressed(_ sender: UIButton) {
        // TODO: Save to photo library
    }
    

    // MARK: Slider events
    
    @IBAction func brightnessChanged(_ sender: UISlider) {

    }
    
    @IBAction func contrastChanged(_ sender: Any) {

    }
    
    @IBAction func saturationChanged(_ sender: Any) {

    }
}

extension PhotoFilterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            originalImage = image
        } else if let image = info[.originalImage] as? UIImage {
            originalImage = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
