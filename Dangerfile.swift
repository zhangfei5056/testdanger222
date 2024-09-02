//
//  Dangerfile.swift
//
//  Created by Yuan Cao on 2024/8/22.
//  Copyright © Jaguar Land Rover Ltd 2024 All rights reserved.
//  This software is confidential and proprietary information.
//

import Foundation
import Danger

let danger = Danger()

// Function to check if a file is a test file by path
func isTestFile(_ fileName: String) -> Bool {
    return fileName.contains("Testing/Unit Tests/Tests/")
    || fileName.contains("Testing/UI Tests/Tests/")
    || fileName.contains("Testing/BDD/Tests/")
    || fileName.contains("WatchTests/Tests/")
}

// Gather all Swift files in the PR
let allSwiftFiles = danger.git.modifiedFiles + danger.git.createdFiles

// Filter for test files
let testFiles = allSwiftFiles.filter { isTestFile($0) }

if !testFiles.isEmpty {
    markdown("""**Test files do not comply with the guidelines:**""")

    // Ensure all test files end with "Tests.swift"
    for file in testFiles where !file.hasSuffix("Tests.swift") {
        fail("\(file) does not end with 'Tests.swift', please update the file name.")
    }
} else {
    message("This MR does not include any test files.")
}
