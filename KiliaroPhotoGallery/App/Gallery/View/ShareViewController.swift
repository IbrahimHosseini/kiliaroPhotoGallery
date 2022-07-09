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

    var viewModel: GalleryViewModelInterface?

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
        userImage.setBorder(color: .cultured,
                            width: 5)

        userImage.backgroundColor = .white

        userImage.image = UIImage(named: "user")
        userImage.contentMode = .scaleAspectFit

        userImage.tintColor = .russianViolet

        viewContainer.setShadow()
        viewContainer.backgroundColor = .white

        labelCount.text = ""
        labelCount.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(more))
        labelCount.addGestureRecognizer(tap)

        clearCacheButtonItem()

        setupNotifications()

    }

    private func setupNotifications() {
        [Notifications.Reachability.connected.name,
         Notifications.Reachability.notConnected.name].forEach { (notification) in
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(changeInternetConnection),
                                                   name: notification,
                                                   object: nil)
        }
    }

    @objc private func changeInternetConnection(notification: Notification) {
        if notification.name == Notifications.Reachability.notConnected.name {
            DispatchQueue.main.async {
                self.hideRefreshButton()
            }
        } else {
            DispatchQueue.main.async {
                self.showRefreshButton()
            }
        }
    }

    fileprivate func showRefreshButton() {
        Indicator.error(title: "No internet connection")
        self.refreshBarButton()
    }

    fileprivate func hideRefreshButton() {
        Indicator.done(title: "Internet connected")
        self.navigationItem.leftBarButtonItem = nil
    }

    fileprivate func clearCacheButtonItem() {
        let back = UIBarButtonItem(barButtonSystemItem: .trash,
                                   target: self,
                                   action: #selector(popUpView))
        navigationController?.navigationBar.tintColor = .russianViolet
        navigationItem.rightBarButtonItem = back
    }

    fileprivate func refreshBarButton() {
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: self,
                                      action: #selector(loadData))
        navigationController?.navigationBar.tintColor = .russianViolet
        navigationItem.leftBarButtonItem = refresh
    }

    @objc fileprivate func popUpView() {
        let alert = UIAlertController(title: "Clear Cache",
                                      message: "After a clear cache, all data will be lost!",
                                      preferredStyle: .actionSheet)

        let clear = UIAlertAction(title: "Clear", style: .destructive) { action in
            self.viewModel?.removeAllMedia()
            Indicator.done(title: "Clear cache successfully")
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(clear)
        alert.addAction(cancel)

        present(alert,
                animated: true)

    }

    fileprivate func setupBinding() {
        viewModel?.galleryPublisher
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

    @objc private func loadData() {
        let key = Constants.sharedKey
        viewModel?.getSharedMedia(key)
    }

    fileprivate func refreshView(data: [GalleryCollectionViewModel]) {
        self.gallery = data
        let count = gallery.count

        DispatchQueue.main.async {
            self.labelCount.text = "+\(count - 3)"
            self.descriptionLabel.text = "shared \(count) photos with you!"

            let firstImageUrl = self.imageUrl(data[0].thumbnailUrl)
            self.firstImageView.url = firstImageUrl

            let secondImageUrl = self.imageUrl(data[1].thumbnailUrl)
            self.secondImageView.url = secondImageUrl

            let thirdImageUrl = self.imageUrl(data[2].thumbnailUrl)
            self.thirdImageView.url = thirdImageUrl
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
        let vc = UIStoryboard.main.instantiate(viewController: GalleryViewController.self)
        vc.gallery = self.gallery
        if let navigation = navigationController, self.gallery.count > 0 {
            navigation.pushViewController(vc, animated: true)
        }
    }

}

