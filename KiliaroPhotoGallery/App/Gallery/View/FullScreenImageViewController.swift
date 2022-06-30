//
//  FullScreenImageViewController.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import UIKit

class FullScreenImageViewController: UIViewController {

    // MARK: - Properties
    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        return collectionView
    }()

    private var gallery: [GalleryCollectionViewModel] = []
    private var indexPath = IndexPath(item: 0, section: 0)

    func initWith(_ gallery: [GalleryCollectionViewModel], indexPath: IndexPath) {
        self.gallery = gallery
        self.indexPath = indexPath
    }

    // MARK: - View controller life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Functions

    fileprivate func setupView() {

        view.addSubview(collectionView)
        collectionView.frame = view.frame
        setupCollectionView()
        collectionView.scrollToItem(at: indexPath,
                                    at: .top,
                                    animated: false)

        title = "Image Gallery"

        backBarButtonItem()
    }

    // MARK: - Actions
    fileprivate func backBarButtonItem() {
       let back = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = back
    }

    @objc fileprivate func back() {
        dismiss(animated: true)
    }

}

// MARK: - collection view data source

extension FullScreenImageViewController: UICollectionViewDataSource {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.isDirectionalLockEnabled = true
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(GalleryCollectionViewCell.self)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(GalleryCollectionViewCell.self,
                                          indexPath: indexPath)
        if gallery.count > 0 {
            cell.fill(gallery[indexPath.row], isFullScreen: true)
        }
        return cell
    }
}

// MARK: - collection view delegate

extension FullScreenImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
}

// MARK: - create collection layout

extension FullScreenImageViewController {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        // size of the each item
        let fullScreenItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1))
        let fullItem = NSCollectionLayoutItem(layoutSize: fullScreenItemSize)

        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(1))

        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                             subitems: [fullItem])

        let section = NSCollectionLayoutSection(group: verticalGroup)

        return UICollectionViewCompositionalLayout(section: section)
    }
}
