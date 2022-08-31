//
//  LocalNotifications.swift
//  Onflow status
//
//  Created by Nikita Rossik on 8/31/22.
//

import OnflowNetwork
@preconcurrency import UserNotifications

struct LocalNotifications: Sendable {
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

//	func resetNotificationPermissions() async -> UNAuthorizationStatus {
//		UNAuthorizationStatus.notDetermined
//	}

	func currentAuthorizationSetting() async -> UNAuthorizationStatus {
		let currentSettings = await notificationCenter.notificationSettings()
		return currentSettings.authorizationStatus
	}

	func getNotificationsSettings() async {
		let settings = await notificationCenter.notificationSettings()
		print("ℹ️ Notification settings: \(settings)")
	}

	func checkPendingNotifications() async {
		let notificationRequests = await notificationCenter.pendingNotificationRequests()

		for notification in notificationRequests {
			print("> \(notification.identifier)")
		}
	}

	func createNotificationRequest(_ service: Services) async throws -> UNNotificationRequest {

		let notificationContent = UNMutableNotificationContent()
		notificationContent.title = service.serviceName
		notificationContent.body = "Some of service has an issue."

		var dateComponents = DateComponents()
		dateComponents.calendar = .current
		dateComponents.hour = 10

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
			print("\(#function): \(error)")
		}
	}
}
