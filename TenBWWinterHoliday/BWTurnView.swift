//
//  BWTurnView.swift
//  TenBWWinterHoliday
//
//  Created by Alan Richard on 1/30/21.
//

import SwiftUI

struct BWTurnView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var collection: BWRoundCollection
    
    var round: BWRound
    var showNextButton: Bool
    
    @State var nameInputDialogShowing = false
    @State var name = ""
    
    //@State var statusBar = StatusBar()
    
    var body: some View {
        let indexForUser = collection.indexOf(turn: round) + 1
        return GeometryReader { geometry in
//            VStack {
//                StatusBarView(statusBar: statusBar)
//                Spacer()
//            }
            ZStack {
                Color("BackgroundColor")
                VStack {
                    VStack {
                        HStack {
                            Image("btn_back")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: btn2Size.width, height: btn2Size.height)
                            Spacer()
                            if showNextButton {
                                Image("btn_next")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: btn2Size.width, height: btn2Size.height)
                            }
                        }
                        Group {
                            Text("        我是共青团员 ") +
                            Text(collection.user.name)
                                .foregroundColor(Color("NameColor"))
                                .underline(true, color: Color("FontColor"))
                            +
                            Text(" ，我完成了学生团员“寒假十课”第\(BWRoundCollection.numberToChineseChar(indexForUser) ?? "nil")课！")
                        }
                        .font(.system(size: fontSize))
                        .foregroundColor(Color("FontColor"))
                        .lineSpacing(lineSpacing)
                        .padding(.vertical, 10)
                        .padding(.trailing, 20)
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 10)
                    Image("bg_hz\(indexForUser)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * badgeScaleFactor)
                    //Image(uiImage: collection.getBadgeImage(for: indexForUser))
                    
                    Image("bg_cabc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 70)
                    Spacer()
                }
                BottomBar()
            }
        }
        .navigationBarItems(leading: backButton,
                            trailing: Image(systemName: "ellipsis")
                                .popover(isPresented: $nameInputDialogShowing, content: {
                                    Form {
                                        TextField("Name", text: $name, onCommit: { collection.changeUserName(to: name) })
                                    }
                                })
                                .onTapGesture {
                                    nameInputDialogShowing = true
                                })
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var backButton: some View {
        Image(systemName: "xmark")
            .font(Font.title2.weight(.light))
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
            }
    }
    
    // MARK: - Draw constants
    // 2.6rem; height: 0.973rem
    private let fontSize: CGFloat = 26
    private let lineSpacing: CGFloat = 9.0
    private let btn2Size = CGSize(width: 2.6 * 42, height: 0.973 * 42)
    private let badgeScaleFactor: CGFloat = 0.93
}

struct BottomBar: View {
    var body: some View {
        VStack {
            Spacer()
            Divider()
            HStack {
                Spacer()
                HStack(spacing: 100) {
                    Image(systemName: "chevron.left")
                        .font(Font.title2.weight(.light))
                    Image(systemName: "chevron.right")
                        .font(Font.title2.weight(.light))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
        }.ignoresSafeArea(edges: .top)
    }
}

struct StatusBarView: View {
    var statusBar: StatusBar
    
    var body: some View {
        HStack {
            Text(statusBar.formattedTimeShort)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .padding(.leading, 16)
            Spacer()
            HStack(spacing: 6) {
                CellularIcon(height: 11)
                Image(systemName: "wifi")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                Image(systemName: "battery.100")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 16)
            }
        }.padding()
        .edgesIgnoringSafeArea(.top)
    }
}

struct CellularIcon: View {
    var height: CGFloat
    
    var body: some View {
        VStack {
            HStack(spacing: 2) {
                VStack {
                    Spacer(minLength: 0)
                    RoundedRectangle(cornerRadius: 1)
                        .frame(height: height / 2.9)
                }
                VStack {
                    Spacer(minLength: 0)
                    RoundedRectangle(cornerRadius: 1)
                        .frame(height: height / 1.7)
                }
                VStack {
                    Spacer(minLength: 0)
                    RoundedRectangle(cornerRadius: 1)
                        .frame(height: height / 1.28)
                }
                RoundedRectangle(cornerRadius: 1)
            }
            .foregroundColor(.black)
            .frame(width: height / 32 * 51, height: height)
            //.padding(.top, height / 32 * 51 - height)
        }
    }
}

struct BWTurnView_Previews: PreviewProvider {
    static var previews: some View {
        let collection = BWRoundCollection()
        collection.user.name = "我也是"
        return BWTurnView(round: BWRound(id: 1), showNextButton: true)
            .environmentObject(collection)
    }
}
