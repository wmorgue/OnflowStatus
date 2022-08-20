//
//  LocaleLayer.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/20/22.
//

import Foundation
import struct SwiftUI.AppStorage

public enum CurrentLocale: String, CaseIterable, Identifiable {
	case english = "USA"
	case china = "China"
	case japan = "Japan"
	case korea = "South Korea"
	case german = "Germany"
	case spanish = "Spain"
	case french = "France"
	case italia = "Italy"
	case portugal = "Portugal"
	case russia = "Russia"

	public var id: String { self.rawValue }

	public var identifier: String {
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

public final class LocaleLayer: ObservableObject {

	private init() {}
	public static let instance = LocaleLayer()

	@AppStorage("serviceLocale")
	public var locale: String = CurrentLocale.english.identifier

	public let developerLocale = CurrentLocale.english.identifier

	public var allLocales = CurrentLocale.allCases
}
