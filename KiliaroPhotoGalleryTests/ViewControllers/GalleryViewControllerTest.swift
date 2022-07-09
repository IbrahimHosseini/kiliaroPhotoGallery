//
//  GalleryViewControllerTest.swift
//  KiliaroPhotoGalleryTests
//
//  Created by Ibrahim Hosseini on 7/3/22.
//

import XCTest
@testable import KiliaroPhotoGallery

class GalleryViewControllerTest: XCTestCase {

    func test_collectionView_notNil() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.collectionView)
    }

    func test_collectionViewDelegate_sets() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.collectionView.delegate)
    }

    func test_collectionViewDataSource_sets() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.collectionView.dataSource)
    }

    // MARK: - Factory
    private func makeSUT() -> GalleryViewController {
        let sut = UIStoryboard.main.instantiate(viewController: GalleryViewController.self)
        sut.loadViewIfNeeded()
        return sut
    }
}
