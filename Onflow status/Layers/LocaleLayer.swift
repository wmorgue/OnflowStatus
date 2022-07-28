//
//  LocaleLayer.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/20/22.
//

import Foundation
import struct SwiftUI.AppStorage

enum CurrentLocale: String, CaseIterable, Identifiable {
	case english = "English"
	case china = "Chinese"
	case japan = "Japanese"
	case korea = "Korean"
	case german = "German"
	case spanish = "Spanish"
	case french = "French"
	case italia = "Italian"
	case portugal = "Portuguese"
	case russia = "Russian"

	var id: String { self.rawValue }

	var identifier: String {
		switch self {
		case .english: return "en_US"
		case .china: return "zh_CN"
		case .japan: return "ja_JP"
		case .korea: return "ko_KR"
		case .german: return "de_DE"
		case .spanish: return "es_ES"
		case .french: return "fr_FR"
		case .italia: return "it_IT"
		case .portugal: return "pt_BR"
		case .russia: return "ru_RU"
		}
	}
}

final class LocaleLayer: ObservableObject {

	private init() {}
	static let instance = LocaleLayer()

	@AppStorage("serviceLocale")
	var locale = CurrentLocale.english.identifier

	var allLocales = CurrentLocale.allCases

	func setNewLocale(newLocale: CurrentLocale) {
		locale = newLocale.identifier
	}

//	func updateForNetwork(newLocale: CurrentLocale) {
//		NetworkLayer().developerLocale = newLocale
//	}
}
