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

    }
        }
    }
}
