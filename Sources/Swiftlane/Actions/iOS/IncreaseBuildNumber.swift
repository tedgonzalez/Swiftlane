//
//  IncreaseBuildNumber.swift
//  Swiftlane
//
//  Created by Khoa on 11/02/2022.
//

import Foundation

public final class IncreseBuildNumber {
    public var workflow: Workflow?

    public init() {}

    public func run() async throws {
        Settings.cs.action("Increase build number")

        try Settings.cli.run(
            program: "agvtool",
            argument: ["next-version", "-all"].joined(separator: " "),
            currentDirectoryURL: workflow?.directory
        )
    }
}
