//
//  AppAddButtonView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/8/24.
//

import SwiftUI

struct AppAddButtonView: View {
    
    @EnvironmentObject var model: BlockingApplicationModel
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            Color(uiColor: .clear)
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(uiColor: .gray8))
            Button(action: { isPresented.toggle() }) {
                Image(uiImage: ImageLiterals.Challenge.icPlus)
            }
            .frame(width: 335, height: 68)
            .familyActivityPicker(isPresented: $isPresented, selection: $model.newSelection)
        }
        .background(Color(.clear))
    }
}

#Preview {
    AppAddButtonView()
}
