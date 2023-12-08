//
//  DetailViewController.swift
//  Project1
//
//  Created by Yulian Gyuroff on 17.09.23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedNumber: Int?
    var numberImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        //title = selectedImage
        if let selNum = selectedNumber, let numImg = numberImages{
            title = "Picture \(selNum+1) of \(numImg)"
        }else{
            title = selectedImage
        }
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped(){
        guard var image = imageView.image?.jpegData(compressionQuality: 0.8)
        else{
            print("No image found")
            return
        }
        
        let size = imageView.image?.size ?? CGSize(width: 512, height: 512)
        let renderer = UIGraphicsImageRenderer(size: size)
        let imageTemp = renderer.image { ctx in
            imageView.image?.draw(at: CGPoint(x: 0, y: 0))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.red,
                .backgroundColor: UIColor.white
                    
            ]
            
            let string = "From Storm Viewer"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: size.width-32, height: size.height-32),
                                  options: .usesLineFragmentOrigin, context: nil)
        }
        image = imageTemp.jpegData(compressionQuality: 1.0)!
        let vc = UIActivityViewController(activityItems: [image,selectedImage ?? "","Julian"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
