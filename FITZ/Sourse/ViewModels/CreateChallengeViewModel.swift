//
//  CreateChallengeViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import SwiftUI

final class CreateChallengeViewModel: ObservableObject{
    @Published var dropdowns: [CallengePartModel] = [
        .init(type: .exercise),
        .init(type: .start),
        .init(type: .increase),
        .init(type: .length)
    ]
}


extension CreateChallengeViewModel{

}
