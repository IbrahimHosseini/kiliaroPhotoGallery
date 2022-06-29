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
    @IBOutlet weak var collectionView: UICollectionView!

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
        setupCollectionView()

    }

    fileprivate func setupBinding() {
        viewMode.$gallery
            .receive(on: RunLoop.main)
            .sink {[weak self] gallery in
                guard let _ = self,
                      let gallery = gallery
                else { return }
                dump("Gallery-> \(gallery.map { $0.id })")
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

        collectionView.register(GalleryCollectionViewCell.self,
                                forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - collection view delegate

extension GalleyViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewMode.gallery?.count ?? 0
    }
}
