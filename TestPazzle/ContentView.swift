//
//  ContentView.swift
//  TestPazzle
//
//  Created by kaito on 2023/11/30.
//

import SwiftUI
import AudioToolbox

struct ContentView: View {
    @State var crossWords = [
          ["", "", "", ""],
          ["-", "", "-", ""],
          ["", "", "", ""],
          ["", "-", "", ""]
      ]
    
    let successWords = [
        ["し", "ま", "う", "ま"],
        ["-", "ん", "-", "つ"],
        ["お", "と", "さ", "た"],
        ["に", "-", "い", "け"]
    ]

    let questions = [
        ["①横：白黒の模様を持つ馬", "②縦：袖が無い外套の一種　ヒーローや騎士が身につけること多い", "", "③縦：秋の味覚とされる高級なキノコ"],
        ["", "", "", ""],
        ["④横：便り。連絡。　〇〇〇〇がない\n　縦：想像上の怪物　〇〇ごっこで捕まえる役", "", "⑤縦：ゾウに次ぐ大型の陸上哺乳類　頭部に1本か2本の太い角をもっている", ""],
        ["", "", "⑥横：くぼ地に水がたまった所　湖や沼より小さい", ""]
    ]
    
    let inputWords = [
        ["ら", "や", "ま", "は", "な", "た", "さ", "か", "あ"],
        ["り", "わ", "み", "ひ", "に", "ち", "し", "き", "い"],
        ["る", "ゆ", "む", "ふ", "ぬ", "つ", "す", "く", "う"],
        ["れ", "ん", "め", "へ", "ね", "て", "せ", "け", "え"],
        ["ろ", "よ", "も", "ほ", "の", "と", "そ", "こ", "お"]
    ]
    
    @State var selectedX = 0
    @State var selectedY = 0
    
    @State private var succesalert =  false
    
    var body: some View {
        VStack {
            HStack{
                Text("文字並べパズル").font(.title).fontWeight(.black).padding()
                Spacer()
            }
            Spacer()
            VStack(spacing: 0){
                ForEach(0..<4) { y in
                    HStack(spacing: 0) {
                        ForEach(0..<4) { x in
                            if crossWords[y][x] != "-"{
                                ZStack {
                                    Button(action:  {
                                        selectedX = x
                                        selectedY = y
                                    }) {
                                        Text(crossWords[y][x])
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .border(.black)
                                            .background((selectedY == y && selectedX == x) ? .yellow : .white)
                                            .foregroundColor(Color.black)
                                            .font(Font.system(size: 30).bold())
                                    }
                                    Text(questions[y][x].prefix(1))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                }
                            } else {
                                Spacer()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .border(.black)
                                    .background(Color.black)
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 30).bold())
                            }
                        }
                    }.frame(height: 80)
                }
            }.frame(height: 80)
            Spacer()
            VStack() {
                if questions[selectedY][selectedX] != "" {
                    Text(questions[selectedY][selectedX])
                        .font(.title3)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
            }
            .frame(height: 80)
            VStack{
                VStack(spacing: 1.5) {
                    ForEach(0..<5) { y in
                        HStack(spacing: 1.5) {
                            ForEach(0..<9) { x in
                                Button(action: {
                                    let selectedinputWords = inputWords[y][x]
                                    
                                    if selectedinputWords == successWords[selectedY][selectedX] {
                                        crossWords[selectedY][selectedX] = selectedinputWords
                                        if crossWords == successWords {
                                            succesalert = true
                                        }
                                    } else {
                                        UINotificationFeedbackGenerator().notificationOccurred(.error)
                                    }
                                }){
                                    Text(inputWords[y][x])
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .border(.black)
                                        .background(Color.yellow.opacity(0.4))
                                        .foregroundColor(Color.black)
                                        .font(.largeTitle)
                                        .fontWeight(.black)
                                }
                            }
                        }
                    }
                }
            }.frame(height: 200).background(Color.gray)
        }
        .alert(isPresented: $succesalert) {
             Alert(title: Text("クリア!"))
         }
    }
}

#Preview {
    ContentView()
}
