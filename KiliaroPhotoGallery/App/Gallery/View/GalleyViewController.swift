//
//  GalleyViewController.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import UIKit
import Combine

class GalleyViewController: UIViewController {

    // MARK: - Outlets


    // MARK: - Properties
    var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        return collectionView
    }()

    private var cancelable = Set<AnyCancellable>()
    private let sharedKey = "djlCbGusTJamg_ca4axEVw"

    var viewMode = GalleryViewModel()

    // MARK: - View controller life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Functions

    fileprivate func setupView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame

        setupCollectionView()
    }

    fileprivate func setupBinding() {
        viewMode.$gallery
            .receive(on: RunLoop.main)
            .sink {[weak self] gallery in
                guard let self = self,
                      let gallery = gallery
                else { return }
                if gallery.count > 0 {
                    self.collectionView.reloadData()
                }
            }
            .store(in: &cancelable)
    }

    func loadData() {
        viewMode.getSharedMedia(sharedKey)
    }

    // MARK: - Actions


}

// MARK: - collection view data source

extension GalleyViewController: UICollectionViewDataSource {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(GalleryCollectionViewCell.self)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(GalleryCollectionViewCell.self,
                                          indexPath: indexPath)
        if let data = viewMode.gallery {
            cell.fill(data[indexPath.row])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: tap on image and show full screen image
    }
}

// MARK: - collection view delegate

extension GalleyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewMode.gallery?.count ?? 0
    }
}

// MARK: - create collection layout

extension GalleyViewController {
    static func createLayout() -> UICollectionViewCompositionalLayout {

        let margin: CGFloat = UIScreen.main.bounds.width * 0.01

        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                              heightDimension: .fractionalWidth(1/3))


        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(top: margin,
                                                     leading: margin,
                                                     bottom: margin,
                                                     trailing: margin)


        // Group
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(1/3))

        let verticalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize,
                                                             subitems: [item])

        // Sections
        let section = NSCollectionLayoutSection(group: verticalGroup)

        // Return
        return UICollectionViewCompositionalLayout(section: section)
    }
}
