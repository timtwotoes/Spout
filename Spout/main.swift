//
//  main.swift
//  Spout
//
//  Created by Tim Wolff on 06/10/2020.
//  Copyright © 2020 Tim Wolff. All rights reserved.
//

import Foundation

public func printContents(at url: URL) throws {
    let contents = try String(contentsOf: url)
    print(contents)
}

do {
    switch try CommandLine.parseArguments() {
    case .none: print("spout <filename>")
    case .inputFile(let url): try printContents(at: url)
    }
} catch (let error) {
    print(error.localizedDescription)
    exit(1)
}
