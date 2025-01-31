//
//  main.swift
//  Script
//
//  Created by Khoa on 16/02/2022.
//

import Swiftlane
import AppStoreConnect

@main
public struct Script {
    mutating func run() throws {
        Task {
            do {
                try await deployMyApp()
            } catch {
                print(error)
            }
        }
    }

    private func deployMyApp() async throws {
        var workflow = Workflow()
        workflow.directory = Settings.fs
            .homeDirectory()
            .appendingPathComponent("XcodeProject2/swiftlane/Examples/MyApp")

        let build = Build()
        build.project("MyApp")
        build.workflow = workflow
        try await build.run()

        guard
            let issuerId = Settings.env["ASC_ISSUER_ID"],
            let privateKeyId = Settings.env["ASC_PRIVATE_KEY_ID"],
            let privateKey = Settings.env["ASC_PRIVATE_KEY"]
        else { return }

        let _ = try ASC(
            credential: AppStoreConnect.Credential(
                issuerId: issuerId,
                privateKeyId: privateKeyId,
                privateKey: privateKey
            )
        )
    }
}
