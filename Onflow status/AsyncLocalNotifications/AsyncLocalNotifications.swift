//
//  LocalNotifications.swift
//  Onflow status
//
//  Created by Nikita Rossik on 8/31/22.
//

import OnflowNetwork
import OSLog
@preconcurrency import UserNotifications

private extension Logger {
	static let asyncNotifications = Logger(subsystem: .bundleIdentifier, category: String(describing: AsyncLocalNotifications.self))
}

struct AsyncLocalNotifications: Sendable {
	private init() {}
	static let instance = Self()

	let notificationIdentifier = UUID().uuidString
	let notificationCenter = UNUserNotificationCenter.current()
	let authorizationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]

	func requestNotificationPermission() async throws -> Bool {
		do {
			return try await notificationCenter.requestAuthorization(options: authorizationOptions)
		} catch {
			throw error
		}
	}

	func currentAuthorizationSetting() async -> UNAuthorizationStatus {
		let currentSettings = await notificationCenter.notificationSettings()
		return currentSettings.authorizationStatus
	}

	func getNotificationsSettings() async -> UNNotificationSettings {
		let settings = await notificationCenter.notificationSettings()
		return settings
	}

	func checkPendingNotifications() async {
		let notificationRequests = await notificationCenter.pendingNotificationRequests()

		for notification in notificationRequests {
			Logger.asyncNotifications.info("🪵 > \(notification.identifier)")
		}
	}

	func createNotificationRequest(_ service: Services) async throws -> UNNotificationRequest {

		let notificationContent = UNMutableNotificationContent()
		notificationContent.title = service.serviceName
		notificationContent.body = "Some of service has an issue."

		var dateComponents = DateComponents()
		dateComponents.calendar = .current

		let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

		let notificationRequest = UNNotificationRequest(
			identifier: notificationIdentifier,
			content: notificationContent,
			trigger: calendarTrigger
		)

		return notificationRequest
	}

	func sendNotification(for service: Services) async throws {
		do {
			try await notificationCenter.add(createNotificationRequest(service))
		} catch {
			Logger.asyncNotifications.error("🪵 \(error)")
		}
	}
}
