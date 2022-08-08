//
//  SystemStatusViewModel_Test.swift
//  Onflow status Unit Tests
//
//  Created by Nikita Rossik on 8/7/22.
//

@testable import Onflow_status

import OnflowNetwork
import XCTest

final class SystemStatusViewModel_Test: XCTestCase {

	// Production service
	let systemStatusService = SystemStatusService()
	var viewModel: SystemStatusViewModel?

	override func setUpWithError() throws {
		viewModel = SystemStatusViewModel(onflowService: systemStatusService)
	}

	override func tearDownWithError() throws {
		viewModel = nil
	}

	func test_SystemStatusViewModel_systemData_emptyOnInit() {
		// Given
		guard let systemData = viewModel?.systemData else { return }
		// When

		// Then
		XCTAssertNotNil(systemData)
		XCTAssertTrue(systemData.isEmpty)
		XCTAssertEqual(systemData.count, 0)
	}

	// alertErrorMessage = nil at Init
	func test_SystemStatusViewModel_alertErrorMessage_shouldBeNilAtInit() {
		guard let alertErrorMessage = viewModel?.alertErrorMessage else { return }

		XCTAssertNil(alertErrorMessage)
	}

	func test_SystemStatusViewModel_searchText_shouldBeEmptyAtInit() {
		guard let searchText = viewModel?.searchText else { return }

		XCTAssertTrue(searchText.isEmpty)
		XCTAssertEqual(searchText, "")
	}

	func test_SystemStatusViewModel_chooseAppIcon() async {
		guard let viewModel = viewModel else { return }

		// NOTE: - Open simulator to complete test
		for icon in AppIcon.allCases {
			await viewModel.chooseAppIcon(for: icon)
		}

		XCTAssertFalse(AppIcon.allCases.isEmpty)
	}
}
