//
//  ExtractDetailsViewModel.swift
//  CoraDesafio
//
//  Created by Erik Santos on 23/03/24.
//

import Foundation
import CoreKit
import NetwokKit

typealias ExtractDetailsViewModel = ExtractDetailsView.ViewModel

extension ExtractDetailsView {
    
    final class ViewModel: ObservableObject {
        
        // MARK: - Properties
        
        @Published var extractDetails: ExtractDetailsResponse?
        @Published var status: ScreenStatus = .success
        
        private let service: CoraServicing
        private let extractId: String
        
        // MARK: - Initialize
        
        init(extractDetails: ExtractDetailsResponse? = nil, service: CoraServicing, extractId: String) {
            self.extractDetails = extractDetails
            self.service = service
            self.extractId = extractId
        }
        
        // MARK: - Public Methods
        
        func fetchExtractDetails() async {
            DispatchQueue.main.asyncAndWait {
                self.status = .loading
            }
            
            do {
                let extractResponse = try await service.fetchExtractDetails(extractId)
                
                DispatchQueue.main.asyncAndWait {
                    self.extractDetails = extractResponse
                    self.status = .success
                }
                
            } catch {
                DispatchQueue.main.asyncAndWait {
                    self.status = .error
                }
            }
        }
    }
}
