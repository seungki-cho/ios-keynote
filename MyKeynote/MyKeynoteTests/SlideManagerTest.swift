//
//  SlideManagerTest.swift
//  SlideManagerTest
//
//  Created by cho seungki on 2023/07/17.
//

import XCTest

final class SlideManagerTest: XCTestCase {
    var sut: SlideManager!
    
    override func setUpWithError() throws {
        let mockRectFactory = MockRectFactory()
        sut = SlideManager(rectFactory: mockRectFactory)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_아무것도없는곳Tap하면_선택된Rect가nil이다() {
        //Given
        _ = sut.makeRect(by: Square.self)
        var nilRect: Rectable?
        sut.selectedRectDidChanged = { rect in
            nilRect = rect
        }
        //When
        sut.tapped(at: SKPoint(x: 201, y: 201))
        //Then
        XCTAssertNil(nilRect)
    }
    func test_RectableTap하면_선택된Rect가nil이아니다() {
        //Given
        _ = sut.makeRect(by: Square.self)
        var nilRect: Rectable?
        sut.selectedRectDidChanged = { rect in
            nilRect = rect
        }
        //When
        sut.tapped(at: SKPoint(x: 150, y: 150))
        //Then
        XCTAssertNotNil(nilRect)
    }
    func test_Rectable두번Tap하면_선택된Rectable이일치한다() {
        //Given
        let willBeSelectedRect = sut.makeRect(by: Square.self)
        var selectedRect: Rectable?
        sut.selectedRectDidChanged = { rect in
            selectedRect = rect
        }
        //When
        sut.tapped(at: SKPoint(x: 150, y: 150))
        sut.tapped(at: SKPoint(x: 150, y: 150))
        //Then
        XCTAssertNotNil(selectedRect)
        XCTAssertTrue(willBeSelectedRect.isEqual(with: selectedRect!))
    }
    func test_RectableTap후에빈곳Tap하면_선택된Rect가nil이다() {
        //Given
        _ = sut.makeRect(by: Square.self)
        var selectedRect: Rectable?
        sut.selectedRectDidChanged = { rect in
            selectedRect = rect
        }
        //When
        sut.tapped(at: SKPoint(x: 150, y: 150))
        sut.tapped(at: SKPoint(x: 99, y: 99))
        //Then
        XCTAssertNil(selectedRect)
    }
    }
        }
    }
}
