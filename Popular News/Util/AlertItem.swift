//
//  AlertItem.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 10/06/22.
//

import Foundation

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

enum AlertContext {
    
    //MARK: - Network Errors
    static let invalidURL       = AlertItem(title: Text("Server Error"),
                                            message: Text("There is an error trying to reach the server. If this persists, please contact support."),
                                            dismissButton: .default(Text("Ok")))
    
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            message: Text("Unable to complete your request at this time. Please check your internet connection."),
                                            dismissButton: .default(Text("Ok")))
    
    static let invalidResponse  = AlertItem(title: Text("Server Error"),
                                            message: Text("Invalid response from the server. Please try again or contact support."),
                                            dismissButton: .default(Text("Ok")))
    
    static let invalidData      = AlertItem(title: Text("Server Error"),
                                            message: Text("The data received from the server was invalid. Please try again or contact support."),
                                            dismissButton: .default(Text("Ok")))
    
    
    static let invalidDecoding      = AlertItem(title: Text("Decoding Error"),
                                                message: Text("Unable to decode the data received from the server. Please try again or contact support."),
                                                dismissButton: .default(Text("Ok")))
    
    
    static let unKnown      = AlertItem(title: Text("Unknown Error"),
                                        message: Text("Some UnKnown Error occured. Please try again or contact support."),
                                        dismissButton: .default(Text("Ok")))
    
    
    //Fetch Error Message
    static let fetchingError      = AlertItem(title: Text("Error"),
                                              message: Text("There is some problem in Feching the News Articles  . Please try again or contact support."),
                                              dismissButton: .default(Text("Ok")))
}
