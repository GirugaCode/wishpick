//
//  PhotoSelctorController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 10/18/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Photos
import UIKit

class PhotoSelctorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: PROPERTIES
    let cellId = "cellId"
    let headerId = "headerId"
    var images = [UIImage]()
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationButtons()
        setupCollectionView()
        fetchPhotos()
    }

    //MARK: TOP NAVIGATION
    fileprivate func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }

    @objc func handleNext() {
        print("Handle Next")
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil )
    }
    
    //MARK: SETUP COLLECTION VIEW
    private func setupCollectionView() {
        collectionView.backgroundColor = .orange
        collectionView.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    //MARK: COLLECTION VIEW PROTOCOLS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        header.backgroundColor = .red
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        cell.photoImageView.image = images[indexPath.item]
        return cell
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: GET PHOTOS
    fileprivate func fetchPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 15
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        allPhotos.enumerateObjects({ (asset, count, stop) in
            print(asset)
            
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                if let image = image {
                    self.images.append(image)
                }
                if count == allPhotos.count - 1 {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}
