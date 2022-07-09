//
//  GalleryViewController.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import UIKit
import Combine

class GalleryViewController: UIViewController {

    // MARK: - Properties
    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        return collectionView
    }()

    var gallery: [GalleryCollectionViewModel] = []

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

        title = "Galley Images"
    }

    // MARK: - Actions

}

// MARK: - collection view data source

extension GalleryViewController: UICollectionViewDataSource {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(GalleryCollectionViewCell.self)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(GalleryCollectionViewCell.self,
                                          indexPath: indexPath)
        if gallery.count > 0 {
            cell.fill(gallery[indexPath.row])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.main.instantiate(viewController: FullScreenImageViewController.self)
        if gallery.count > 0 {
            vc.initWith(gallery, indexPath: indexPath)
            let navigation = UINavigationController(rootViewController: vc)
            navigation.modalPresentationStyle = .overFullScreen
            present(navigation, animated: true)
        }
    }
}

// MARK: - collection view delegate

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
}

// MARK: - create collection layout

extension GalleryViewController {
    static func createLayout() -> UICollectionViewCompositionalLayout {

        // dynamic margin size
        let margin: CGFloat = 1

        // MARK: - Triple item

        // size of the each item
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                   heightDimension: .fractionalHeight(1))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)

        // margin of the each item
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: margin,
                                                          leading: margin,
                                                          bottom: margin,
                                                          trailing: margin)
        let tripleGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalWidth(1/3))
        let tripleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: tripleGroupSize,
                                                             subitems: [smallItem, smallItem, smallItem])


        // MARK: - Main with pair item

        // large item
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3),
                                                   heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: margin,
                                                          leading: margin,
                                                          bottom: margin,
                                                          trailing: margin)
        // pair item
        let pairItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1/2))
        let pairItem = NSCollectionLayoutItem(layoutSize: pairItemSize)
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: margin,
                                                         leading: margin,
                                                         bottom: margin,
                                                         trailing: margin)

        let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                       heightDimension: .fractionalHeight(1))
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize,
                                                             subitem: pairItem,
                                                             count: 2)

        /// Merge the large and pair group
        let largeWithPairGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalWidth(2/3))
        let largeWithPairGroup = NSCollectionLayoutGroup.horizontal(layoutSize: largeWithPairGroupSize,
                                                                    subitems: [largeItem,
                                                                               trailingGroup])


        // MARK: - Pair with main item
        let largeWithPairGroupReverse = NSCollectionLayoutGroup.horizontal(layoutSize: largeWithPairGroupSize,
                                                                           subitems: [trailingGroup,
                                                                                      largeItem])

        // MARK: - Vertical group

        /// heightDimension is equal to sum of the all other groups heightDimension.
        /// All other group is => largeWithPairGroup, tripleGroup, largeWithPairGroupReverse, tripleGroup (2/3 + 1/3 + 2/3 + 1/3)
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(6/3))

        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                             subitems: [largeWithPairGroup,
                                                                        tripleGroup,
                                                                        largeWithPairGroupReverse,
                                                                        tripleGroup])

        // MARK: - Sections

        let section = NSCollectionLayoutSection(group: verticalGroup)

        // MARK: - Return

        return UICollectionViewCompositionalLayout(section: section)
    }
}
