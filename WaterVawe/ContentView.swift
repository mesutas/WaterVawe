//
//  ContentView.swift
//  WaterVawe
//
//  Created by Mesut As on 22.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
    var body: some View {
        VStack {
            Image("as")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(10)
                .background(.white, in: Circle())
               
            Text("Mesut As")
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .padding(.bottom, 40)
//            MARK: Wave form
            GeometryReader{ proxy in
                let size = proxy.size
                ZStack{
//                    MARK: Water Drop
                    Image(systemName: "drop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
//                    Streching in X Axis
                        .scaleEffect(x:1.1, y: 1)
                        .offset(y: -1)
                    
//                     Wave Form Shape
                    WaterVawe(progress: progress, waveHeight: 0.05, offset: startAnimation)
                        .fill(Color("Blue"))
                    
//                    Water Drops
                        .overlay(content: {
                            
                            ZStack{
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: -20)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x:40,y:30)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 25, height: 25)
                                    .offset(x:-30,y:80)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 25, height: 25)
                                    .offset(x: 50,y: 70)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: 40, y:100)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: -40, y: 50)
                            }
                        })
                        
//                     Masking into drop shape
                        .mask {
                            Image(systemName: "drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                               
                        }
                    
//                    add Button
                        .overlay(alignment: .bottom){
                            Button{
                                progress += 0.01
                            }label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 40, weight: .black))
                                    .foregroundColor(Color("Blue"))
                                    .shadow(radius: 3)
                                    .padding(25)
                                    .background(.white, in: Circle())
                            }
                            .offset(y: 30)
                        }
                    
                    
                }.frame(width: size.width, height: size.height, alignment: .center)
                    .onAppear {
//                        Lopping Animation
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                            startAnimation = size.width
                        }
                    }
            }
            .frame(height: 350)
            VStack {
                Text("Water Amount / Su Miktarı")
                    .padding(30)
                Text("@mesutasdeveloper")
            }
           
             
            
            Slider(value: $progress)
                
             
         
            
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .background(Color("BG"))
    }
}

#Preview {
    ContentView()
}

struct WaterVawe : Shape {
    var progress: CGFloat
//    wave height
    var waveHeight: CGFloat
//     intial animation start
    var offset: CGFloat
    
//    enabling animation
    var animatableData: CGFloat {
        get{offset}
        set{offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: .zero)
            
//            Draving Waves User sine
            let progressHeight : CGFloat = (1 - progress) * rect.height
            let hight = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2){
                
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (hight * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
//            Bottom Portion
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
        }
    }
}
