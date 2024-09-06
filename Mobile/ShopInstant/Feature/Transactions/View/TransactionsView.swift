//
//  TransactionsView.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 03/09/24.
//

import SwiftUI

struct TransactionsView: View {
    
    @StateObject var viewModel = TransactionsViewModel()
    
    var body: some View {
        GeometryReader(content: { geometry in
            NavigationStack {
                List {
                    if viewModel.items.isEmpty {
                        VStack(spacing: 15) {
                            Image(systemName: "list.bullet.clipboard.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width/2)
                                .foregroundStyle(.gray)
                            
                            Text(LocalizableString.Transactions.emptyTransaction)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .padding(.top, 30)
                        .listRowSeparator(.hidden)
                    } else {
                        ForEach(viewModel.items, id: \.id) { item in
                            Button {
                                viewModel.selectedItem = item
                            } label: {
                                TransactionCard(
                                    item: item
                                )
                            }
                            .buttonStyle(.plain)
                            .listRowInsets(EdgeInsets(top: 20, leading: 18, bottom: 20, trailing: 18))
                        }
                    }
                }
                .refreshable {
                    viewModel.refreshTrxs()
                }
                .sheet(item: $viewModel.selectedItem, content: { item in
                    DetailTransactionView(item: item)
                })
                .listStyle(.plain)
                .task {
                    await viewModel.fetchTrx()
                }
                .navigationTitle(LocalizableString.Transactions.transactions)
                .navigationBarTitleDisplayMode(.large)
            }
        })
    }
}

#Preview {
    TransactionsView()
}
