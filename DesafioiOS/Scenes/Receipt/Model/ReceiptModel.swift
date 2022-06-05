//
//  ReceiptModel.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

struct ReceiptModel: Codable {
    let icon: String
    let status: String
    let value: String
    let date: String
    let addresseeInfo: PersonalInfo
    let beneficiaryInfo: PersonalInfo
    let description: String
}

struct PersonalInfo: Codable {
    let title: String
    let name: String
    let cpf: String
    let bank: String
    let account: String
}
