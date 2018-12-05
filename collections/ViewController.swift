//
//  ViewController.swift
//  collections
//
//  Created by Adriana González Martínez on 11/26/18.
//  Copyright © 2018 Adriana González Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        
        let customLayout = CustomFlowLayout()
        
        
        // Instantiating the UICollectionView, using the default flow layout
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Setting the data source & delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Allow for multiple selection
        collectionView.allowsMultipleSelection = false
        
        // Customization
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        
        //Registering the cell
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        return collectionView
    }()
    
    var data: [Int] = Array(0..<10)
    
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(showOptions(controller:)))

    }

    @objc func showOptions(controller: UIViewController) {
        let alert = UIAlertController(title: "Options", message: "Choose an update", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Example", style: .default, handler: { (_) in
            self.collectionView.performBatchUpdates({
                 // Update 
                 self.data[3] = 808080
                 self.collectionView.reloadItems(at: [IndexPath(item: 3, section: 0)])
                
            }, completion: nil)
            
            self.collectionView.performBatchUpdates({
                
                let updated = self.data[3]
                self.data.remove(at: 3)
                self.data.remove(at: 2)
                self.collectionView.deleteItems(at: [IndexPath(item: 2, section: 0)])
                
                self.data.insert(updated, at: 0)
                self.collectionView.moveItem(at: IndexPath(item: 3, section: 0), to:  IndexPath(item: 0, section: 0))
                
            }, completion: nil)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Insert 3 at the beginning", style: .default, handler: { (_) in
            self.collectionView.performBatchUpdates({
                self.data.insert(3, at: 0)
                self.data.insert(2, at: 0)
                self.data.insert(1, at: 0)
                
                self.collectionView.insertItems(at: [IndexPath(item: 2, section: 0), IndexPath(item: 1, section: 0), IndexPath(item: 0, section: 0)])
            }, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Update value at 5", style: .default, handler: { (_) in
            self.collectionView.performBatchUpdates({
                self.data[4] = 69
                self.collectionView.reloadItems(at: [IndexPath(item: 4, section: 0)])
            }, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete first 2, insert 3 more at the end", style: .default, handler: { (_) in
            self.collectionView.performBatchUpdates({
                self.data.remove(at: 1)
                self.data.remove(at: 0)
                self.collectionView.deleteItems(at: [IndexPath(item: 1, section: 0), IndexPath(item: 0, section: 0)])
            }, completion: nil)
            
            self.collectionView.performBatchUpdates({
                self.data.append(124)
                self.data.append(124)
                self.data.append(124)
                self.collectionView.insertItems(at: [IndexPath(item: 8, section: 0), IndexPath(item: 9, section: 0), IndexPath(item: 10, section: 0)])
            }, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Insert 3 more at the end, delete first 2", style: .default, handler: { (_) in
            self.collectionView.performBatchUpdates({
                self.data.append(12)
                self.data.append(15)
                self.data.append(16)
                self.collectionView.insertItems(at: [IndexPath(item: 10, section: 0), IndexPath(item: 11, section: 0), IndexPath(item: 12, section: 0)])
            }, completion: nil)
            
            self.collectionView.performBatchUpdates({
                self.data.remove(at: 0)
                self.data.remove(at: 0)
                self.collectionView.deleteItems(at: [IndexPath(row: 1, section: 0), IndexPath(row: 0, section: 0)])
            }, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete 3 at the beginning, insert 1 at the beginning", style: .default, handler: { (_) in
            self.collectionView.performBatchUpdates({
                self.data.remove(at: 2)
                self.data.remove(at: 1)
                self.data.remove(at: 0)
                self.collectionView.deleteItems(at: [IndexPath(item: 2, section: 0), IndexPath(item: 1, section: 0), IndexPath(item: 0, section: 0)])
            }, completion: nil)
            
            self.collectionView.performBatchUpdates({
                self.data.insert(-1, at: 0)
                self.collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
            }, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete 3 at the beginning, insert 1 at end", style: .default, handler: { (_) in
            self.collectionView.performBatchUpdates({
                self.data.remove(at: 2)
                self.data.remove(at: 1)
                self.data.remove(at: 0)
                self.collectionView.deleteItems(at: [IndexPath(item: 2, section: 0), IndexPath(item: 1, section: 0), IndexPath(item: 0, section: 0)])
            }, completion: nil)
            
            self.collectionView.performBatchUpdates({
                self.data.append(-10)
                self.collectionView.insertItems(at: [IndexPath(item: 7, section: 0)])
            }, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Insert 3 at the beginning, delete the first one", style: .default, handler: { (_) in
            self.collectionView.performBatchUpdates({
                self.data.insert(123, at: 0)
                self.data.insert(123, at: 0)
                self.data.insert(123, at: 0)
                self.collectionView.insertItems(at: [IndexPath(item: 2, section: 0), IndexPath(item: 1, section: 0), IndexPath(item: 0, section: 0)])
            }, completion: nil)
            
            self.collectionView.performBatchUpdates({
                self.data.remove(at: 0)
                self.collectionView.deleteItems(at: [IndexPath(item: 0, section: 0)])
            }, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.data = Array(0..<10)
            self.collectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion:nil)
    }
    
}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
        let data = self.data[indexPath.item]
        cell.textLabel.text = String(data)
        cell.textLabel.textColor = UIColor.white
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell =  collectionView.cellForItem(at: indexPath) as! Cell
        cell.backgroundColor = .white
        cell.textLabel.textColor = .purple
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Cell
        cell.backgroundColor = .purple
        cell.textLabel.textColor = .white
    }
    
}

