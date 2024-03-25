//
//  ExtractListViewModel.swift
//  CoraDesafio
//
//  Created by Erik Santos on 16/03/24.
//

import Foundation
import NetwokKit
import CoreKit
import SwiftUI
import DesignKit

typealias ExtractListViewModel = ExtractListView.ViewModel

extension ExtractListView {
    
    final class ViewModel: ObservableObject {
        
        // MARK: - Properties
        
        @Published var selectedIndex: Int = 0
        @Published var extractList: ExtractResponse?
        @Published var status: ScreenStatus = .success
        
        weak var coordinator: OnboardingCoordinating?
        let service: CoraServicing
        private var customTask: Task<Void, Error>?
        
        // MARK: - Initialize
        
        init(service: CoraServicing) {
            self.service = service
        }
        
        // MARK: - Public Methods
        
        func signOut() {
            print("🚫 STOP: <TOKEN>")
            print("🛜 ------------------------------------------- 🛜")
            customTask?.cancel()
        }
        
        func fetchExtractList() async {
            
            DispatchQueue.main.async {
                self.status = .loading
            }
            do {
                let extractResponse = try await service.fetchExtractList()
                
                DispatchQueue.main.asyncAndWait {
                    self.extractList = extractResponse
                    self.status = .success
                    
                    print("✅ Success: <LISTA EXTRATO>")
                    print("🛜 ------------------------------------------- 🛜")
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.status = .error
                    
                    print("🚫 ERROR: <LISTA EXTRATO>")
                    print("🛜 ------------------------------------------- 🛜")
                }
            }
        }
        
        func updateToken() async {
            self.customTask = Task {
                guard let task = customTask else { return }
                while !task.isCancelled {
                    do {
                        try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
                        try await service.updateToken()
                        
                        print("✅ Success: <UPDATE TOKEN>")
                        print("🛜 ------------------------------------------- 🛜")
                    } catch {
                        DispatchQueue.main.asyncAndWait {
                            if task.isCancelled {
                                self.coordinator?.perform(to: .onbarding)
                            }
                        }
                    }
                }
            }
            
        }
        
    }
}
