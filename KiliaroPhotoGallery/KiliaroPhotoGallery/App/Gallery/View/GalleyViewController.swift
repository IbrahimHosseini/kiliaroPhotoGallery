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
        viewMode.getSharedMedia("")
    }

    // MARK: - Actions


}
