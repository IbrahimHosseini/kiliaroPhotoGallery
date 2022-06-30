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

    let viewMode = GalleryViewModel()

    private let sharedKey = "djlCbGusTJamg_ca4axEVw"

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

        userImage.image = UIImage(systemName: "person.fill")

        viewContainer.setShadow()

        labelCount.text = ""
        labelCount.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(more))
        labelCount.addGestureRecognizer(tap)

    }

    fileprivate func setupBinding() {
        viewMode.$gallery
            .receive(on: RunLoop.main)
            .sink {[weak self] gallery in
                guard let self = self,
                      let gallery = gallery
                else { return }
                if gallery.count > 0 {
                    self.gallery = gallery
                    self.refreshView()
                }
            }
            .store(in: &cancellable)
    }

    func loadData() {
        viewMode.getSharedMedia(sharedKey)
    }

    fileprivate func refreshView() {
        let count = gallery.count
        labelCount.text = "+\(count - 3)"
        descriptionLabel.text = "shared \(count) photos with you!"

        let firstImageUrl = imageUrl(gallery[0].thumbnailUrl)
        firstImageView.setImage(urlString: firstImageUrl)

        let secondImageUrl = imageUrl(gallery[1].thumbnailUrl)
        secondImageView.setImage(urlString: secondImageUrl)

        let thirdImageUrl = imageUrl(gallery[2].thumbnailUrl)
        thirdImageView.setImage(urlString: thirdImageUrl)
    }

    fileprivate func imageUrl(_ url: String) -> String {
        let url = ImageSizeHandler()
            .setUrl(url)

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

