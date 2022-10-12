//
//  PurchaseSheetView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 10.10.2022.
//

import SwiftUI

struct PurchaseSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var storeVM: StoreViewModel
    @StateObject private var viewModel = PurchaseViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            titleSection
            premiumDescriptionList
            purchaseSubscriptionButtonsView
            restorePurcheseBtn
            buyButton
            Spacer()
        }
        .onAppear{
            viewModel.onAppear(storeVM.allSubscriptions)
        }
    }
}

struct PurchaseSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseSheetView()
            .environmentObject(StoreViewModel())
    }
}


extension PurchaseSheetView{
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 15) {
            Text("Premium")
                .font(.largeTitle.weight(.bold))
            Text("Upgrade to unlock")
                .font(.title2.weight(.bold))
        }
        .padding()
        .hLeading()
    }
    
    private var premiumDescriptionList: some View{
        ForEach(viewModel.rowDescriptions, id: \.self) { title in
            premiumRowView(title)
        }
    }
    
    private func premiumRowView(_ title: String) -> some View{
        Label {
            Text(title)
        } icon: {
            Image(systemName: "checkmark.circle")
                .foregroundColor(.circleTrack)
        }
        .font(.title3.weight(.bold))
        .hLeading()
        .padding()
        .background(Color.primaryButton)
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    private var purchaseSubscriptionButtonsView: some View{
        HStack(spacing: 15){
            ForEach(viewModel.allSubscriptions, id: \.id) { subscription in
                purchaseSubscriptionButton(subscription)
            }
        }
        .padding(.horizontal)
    }
    
    private func purchaseSubscriptionButton(_ sub: StoreSubscriptionModel) -> some View{
        let isSelect: Bool = viewModel.selectedSubs?.id == sub.id
       return Button {
           viewModel.selectedSubs = sub
        } label: {
            VStack(spacing: 10){
                Text(sub.price ?? "")
                    .font(.title2.weight(.heavy))
                Text(sub.title)
                    .font(.title2.weight(.medium))
            }
            .foregroundColor(isSelect ? .invertPrimaryFont : .primaryFont)
            .padding(.vertical, 20)
            .hCenter()
            .background(Color.gray, in: RoundedRectangle(cornerRadius: 5).stroke(lineWidth: isSelect ? 0 : 1))
            .background(isSelect ? Color.circleTrack : Color.clear, in: RoundedRectangle(cornerRadius: 5))
        }
    }
    
    private var restorePurcheseBtn: some View{
        Button {
            storeVM.restorePurchese()
        } label: {
            Text("Restore Purchase")
                .foregroundColor(.primaryFont)
                .font(.title3.weight(.bold))
        }
        .hCenter()
    }
    
    private var buyButton: some View{
        Button {
            if let subscription = viewModel.selectedSubs{
                storeVM.purchaseProduct(subscription){
                    dismiss()
                }
            }
        } label: {
            Text("Buy \(viewModel.selectedSubs?.title ?? "")")
                .font(.title3.weight(.bold))
                .foregroundColor(.black)
                .hCenter()
        }
        .buttonStyle(PrimaryButtonStyle(fillColor: .circleTrack))
        .padding(.top)
        .padding(.horizontal)
    }
}




final class PurchaseViewModel: ObservableObject{
    
    @Published var allSubscriptions = [StoreSubscriptionModel]()
    @Published var selectedSubs: StoreSubscriptionModel?

    
    let rowDescriptions: [String] = [
        "Add multiple challanges",
        "Create custom challenges",
        "Large selection of challange options",
        "No adverts"
    ]
    
    func onAppear(_ allSubs: [StoreSubscriptionModel]){
        if !allSubs.isEmpty{
            allSubscriptions = allSubs
            selectedSubs = allSubs.first
        }
    }
}



