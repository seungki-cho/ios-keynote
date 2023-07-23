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
    
    func test_Rectable를Tap하고Alpha를변경하면_반영된다() {
        //Given
        let rect = sut.makeRect(by: Square.self)
        var selectedRect: Rectable?
        sut.selectedRectDidChanged = { rect in
            selectedRect = rect
        }
        var changingRect: Rectable?
        sut.changed = { rect in
            changingRect = rect
        }
        //When
        sut.tapped(at: SKPoint(x: 150, y: 150))
        sut.changeAlpha(to: 10)
        //Then
        XCTAssertEqual(rect.alpha, selectedRect?.alpha)
        XCTAssertEqual(selectedRect?.alpha, changingRect?.alpha)
        XCTAssertEqual(rect.alpha, 10)
    }
    func test_Rectable를Tap하고Color를변경하면_반영된다() {
        //Given
        let rect = sut.makeRect(by: Square.self)
        var selectedRect: Rectable?
        sut.selectedRectDidChanged = { rect in
            selectedRect = rect
        }
        var changingRect: Rectable?
        sut.changed = { rect in
            changingRect = rect
        }
        //When
        sut.tapped(at: SKPoint(x: 150, y: 150))
        sut.changeColor(to: SKColor(red: 85, green: 170, blue: 255))
        //Then
        let selectedRectColor = (selectedRect as? Colorful)?.color
        let changingRectColor = (changingRect as? Colorful)?.color
        
        XCTAssertEqual(rect.color.red, selectedRectColor?.red)
        XCTAssertEqual(rect.color.green, selectedRectColor?.green)
        XCTAssertEqual(rect.color.blue, selectedRectColor?.blue)
        XCTAssertEqual(selectedRectColor?.red, changingRectColor?.red)
        XCTAssertEqual(selectedRectColor?.green, changingRectColor?.green)
        XCTAssertEqual(selectedRectColor?.blue, changingRectColor?.blue)
        XCTAssertEqual(rect.color.red, 85)
        XCTAssertEqual(rect.color.green, 170)
        XCTAssertEqual(rect.color.blue, 255)
    }
}
