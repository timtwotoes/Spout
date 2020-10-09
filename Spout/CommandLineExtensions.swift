//
//  CommandLineExtensions.swift
//  spout
//
//  Created by Tim Wolff on 06/10/2020.
//  Copyright © 2020 Tim Wolff. All rights reserved.
//

import Foundation

extension CommandLine {
    
    /// Arguments parsed from the command line.
    ///
    /// - none: No arguments parsed.
    /// - inputFile: Parsed file path as an URL.
    public enum ParsedArguments {
        /// No arguments parsed.
        case none
        /// Parsed file path as an URL.
        case inputFile(url: URL)
    }
    
    /// Describes an error that occurs during command line parsing.
    public enum ArgumentParsingError: Error, CustomStringConvertible {
        case unrecognizedParameter
        
        public var description: String {
            switch self {
            case .unrecognizedParameter: return "Unrecognized parameter"
            }
        }
    }
    
    /// Parses arguments passed to the application.
    ///
    /// - Returns: ParsedArguments containing the parsed arguments
    /// - Throws: ArgumentParsingError or an LocalizedError
    public static func parseArguments() throws -> ParsedArguments {
        // Argument 0 is always the name of the executable
        guard arguments.count > 1 else {
            return .none
        }
        
        let argument = arguments[1]
        let firstCharacterInArgument = argument.first!
        
        guard firstCharacterInArgument != "-" else {
            throw ArgumentParsingError.unrecognizedParameter
        }
        
        if firstCharacterInArgument == "/" {
            // Absolute path
            let url = URL(fileURLWithPath: argument)
            return ParsedArguments.inputFile(url: url)
        } else {
            // Relative path
            let currentDirectory = FileManager.default.currentDirectoryPath
            let url = URL(fileURLWithPath: currentDirectory + argument)
            return ParsedArguments.inputFile(url: url)
        }
    }
}
