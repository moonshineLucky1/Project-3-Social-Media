//
//  DetailViewController.swift
//  0225Project1_PH
//
//  Created by 李沐軒 on 2019/2/26.
//  Copyright © 2019 李沐軒. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectImage: String?
    var total: Int?
    var current: Int?
    var selectNow: Int?
    
    @IBOutlet var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let selectImage = selectImage, let current = current {
          
            myImage.image = UIImage(named: selectImage)
            selectNow = current + 1
        }
        
        title = "Picture \(String(describing: selectNow!)) of \(total!)"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        
        guard let image = myImage.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found.")
            return
            }
        
        let items: [Any] = [image]
    
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
        
    }

}
