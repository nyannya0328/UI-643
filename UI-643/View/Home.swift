//
//  Home.swift
//  UI-643
//
//  Created by nyannyan0328 on 2022/08/16.
//

import SwiftUI

struct Home: View {
   @GestureState var location : CGPoint = .zero
    var body: some View {
        GeometryReader{proxy in
            
            
             let size = proxy.size
            
            let widht = (size.width / 10)
            let itemCount = Int((size.height / widht).rounded()) * 10

            LinearGradient(colors: [
                .cyan,.purple,.orange,.pink,.red


            ], startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask {
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 0), count: 10),spacing: 0) {
                    
                    
                    ForEach(0..<itemCount,id:\.self){_ in
                        
                        GeometryReader{innner in
                            
                            let rect = innner.frame(in:.global)
                            
                            let sclae = itemScale(rect: rect, size: size)
                            
                            let transformedRect = rect.applying(.init(scaleX: sclae, y: sclae))
                            
                            let transformLocation =  location.applying(.init(scaleX: sclae, y: sclae))
                            
                
                            
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.orange)
                                .scaleEffect(sclae)
                                .offset(x:(transformedRect.midX - rect.midX),y:(transformedRect.midY - rect.midY))
                                .offset(x:location.x - transformLocation.x,y:location.y - transformLocation.y)
                            
                        }
                        .padding(5)
                        .frame(height:widht)
                    }
                }
             
                
            }
            
            
        }
        .padding(15)
        .coordinateSpace(name: "GESTURE")
        .gesture(
        
            DragGesture(minimumDistance: 0.15).updating($location, body: { value, out, _ in
                out = value.location
            })
        
        )
        .preferredColorScheme(.dark)
    }
    func itemScale(rect : CGRect,size : CGSize)->CGFloat{
        
        let a = location.x - rect.midX
        let b = location.y - rect.midY
        
        
        let root = sqrt((a * a) + (b * b))
        
        let diagonalValue = sqrt((size.width * size.width) + (size.height * size.height))
        
        
        let scale = (root - 150) / 150
        //let scale = root / (diagonalValue / 2)
        
        let modifredScale = location == .zero ? 1 : (1 - scale)
        return modifredScale > 0 ? modifredScale : 0.001
    }
        
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
