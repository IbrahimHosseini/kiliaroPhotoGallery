//
//  SharedViewControllerTest.swift
//  KiliaroPhotoGalleryTests
//
//  Created by Ibrahim Hosseini on 7/3/22.
//

import XCTest
@testable import KiliaroPhotoGallery

class SharedViewControllerTest: XCTestCase {

    func test_userImage_notNil() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.userImage)
    }

    func test_viewContainer_notNil() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.viewContainer)
    }

    func test_lableCount_notNil() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.labelCount)
    }

    func test_descriptionLabel_notNil() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.descriptionLabel)
    }

    func test_firstImageView_notNil() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.firstImageView)
    }

    func test_secondImageView_notNil() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.secondImageView)
    }

    func test_thirdImageView_notNil() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.thirdImageView)
    }


    // MARK: - Factory
    private func makeSUT() -> ShareViewController {
        let sut = UIStoryboard.main.instantiate(viewController: ShareViewController.self)
        sut.loadViewIfNeeded()
        return sut
    }
}
