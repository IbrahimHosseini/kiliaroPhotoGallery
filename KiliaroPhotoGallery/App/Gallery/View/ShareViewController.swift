//
//  ShareViewController.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import UIKit
import Combine

class ShareViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var firstImageView: ImageView!
    @IBOutlet weak var secondImageView: ImageView!
    @IBOutlet weak var thirdImageView: ImageView!

    // MARK: - Properties
    var cancellable = Set<AnyCancellable>()

    var viewModel: GalleryViewModelInterface!

    func initWith(_ viewModel: GalleryViewModelInterface) {
        self.viewModel = viewModel
    }

    private var gallery: [GalleryCollectionViewModel] = []

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

    // MARK: - Functions

    fileprivate func setupView() {
        userImage.setBorder(color: ._F5F6F4,
                            width: 5)

        userImage.backgroundColor = .white

        userImage.image = UIImage(named: "user")
        userImage.contentMode = .scaleAspectFit

        userImage.tintColor = ._2C2649

        viewContainer.setShadow()
        viewContainer.backgroundColor = .white

        labelCount.text = ""
        labelCount.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(more))
        labelCount.addGestureRecognizer(tap)

        clearCacheButtonItem()

    }

    fileprivate func clearCacheButtonItem() {
        let back = UIBarButtonItem(barButtonSystemItem: .trash,
                                   target: self,
                                   action: #selector(popUpView))
        navigationController?.navigationBar.tintColor = ._2C2649
        navigationItem.rightBarButtonItem = back
    }

    @objc fileprivate func popUpView() {
        let alert = UIAlertController(title: "Clear Cache",
                                      message: "After a clear cache, all data will be lost!",
                                      preferredStyle: .actionSheet)

        let clear = UIAlertAction(title: "Clear", style: .destructive) { action in
            CacheHandler.shared.removeAll()
            //TODO: call refresh view
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(clear)
        alert.addAction(cancel)

        present(alert,
                animated: true)

    }

    fileprivate func setupBinding() {
        viewModel.galleryPublisher
            .receive(on: RunLoop.main)
            .sink {[weak self] gallery in
                guard let self = self,
                      let gallery = gallery
                else { return }
                if gallery.count > 0 {
                    self.refreshView(data: gallery)
                }
            }
            .store(in: &cancellable)
    }

    func loadData() {
        let key = Constants.sharedKey
        CacheHandler.shared.load(object: key) { [weak self] media in
            let data = media
                .map { elements -> [GalleryCollectionViewModel] in
                    var dataGallery: [GalleryCollectionViewModel] = []
                    elements.forEach { media in
                        dataGallery.append(GalleryCollectionViewModel(media))
                    }
                    return dataGallery
                }

            guard let data = data else {
                self?.viewModel.getSharedMedia(key)
                return
            }
            self?.refreshView(data: data)
        }
    }

    fileprivate func refreshView(data: [GalleryCollectionViewModel]) {
        self.gallery = data
        let count = gallery.count
        DispatchQueue.main.async {
            self.labelCount.text = "+\(count - 3)"
            self.descriptionLabel.text = "shared \(count) photos with you!"

            let firstImageUrl = self.imageUrl(data[0].thumbnailUrl)
            CacheHandler.shared
                .load(image: firstImageUrl) { image in
                    guard let image = image else {
                        DispatchQueue.main.async {
                            self.firstImageView.setImage(urlString: firstImageUrl)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self.firstImageView.image = image
                    }
                }

            let secondImageUrl = self.imageUrl(data[1].thumbnailUrl)
            CacheHandler.shared
                .load(image: secondImageUrl) { image in
                    guard let image = image else {
                        DispatchQueue.main.async {
                            self.secondImageView.setImage(urlString: secondImageUrl)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self.secondImageView.image = image
                    }
                }

            let thirdImageUrl = self.imageUrl(data[2].thumbnailUrl)
            CacheHandler.shared
                .load(image: thirdImageUrl) { image in
                    guard let image = image else {
                        DispatchQueue.main.async {
                            self.thirdImageView.setImage(urlString: thirdImageUrl)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self.thirdImageView.image = image
                    }
                }
        }
    }

    fileprivate func imageUrl(_ url: String) -> String {
        let url = ImageSizeHandler()
            .set(width: 150)
            .set(height: 150)
            .set(url: url)
        return url.buildUrl()
    }

    @objc fileprivate func more() {
        let vc = UIStoryboard.main.instantiate(viewController: GalleyViewController.self)
        vc.gallery = self.gallery
        if let navigation = navigationController {
            navigation.pushViewController(vc, animated: true)
        }
    }

    // MARK: - Actions

}

