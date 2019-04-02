//
//  ViewController.swift
//  0225Project1_PH
//
//  Created by 李沐軒 on 2019/2/25.
//  Copyright © 2019 李沐軒. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIActivityItemSource {
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "Download #MyAwesomeApp via @moonshineLucky1."
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        
        if activityType == .postToTwitter {
            return "Download #MyAwesomeApp via @moonshineLucky1."
        } else {
            return "Download MyAwesomeApp from https://github.com/moon0411."
        }
    }
    
    

    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Strom Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                pictures.sort()
            }
        }

    }
        
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectImage = pictures[indexPath.row]
            vc.total = pictures.count
            vc.current = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    @objc func shareTapped() {
        
        let items: [Any] = ["Moonshine is coding in some UIActivityViewController stuff.", URL(string: "https://medium.com/@moon0411")!]
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
        
    }
   
}


