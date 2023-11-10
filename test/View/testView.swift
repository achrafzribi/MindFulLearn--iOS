//
//  testView.swift
//  test
//
//  Created by hazem salmani on 6/11/2023.
//
import SwiftUI

struct Challenge: Identifiable {
    var id = UUID()
    var title: String
    var image: String
}

struct HomeView: View {
    let challenges = [
        Challenge(title: "Méditation", image: "meditation-icon"),
        Challenge(title: "Marche quotidienne", image: "walking-icon"),
        Challenge(title: "Journaling", image: "journaling-icon")
    ]

    var body: some View {
        NavigationView {
            VStack {
               // Text("MindFulLearn Challanges")
                 //   .font(.title)
                   // .padding()
                    //.foregroundColor(.black)
                    //.background(Color.white)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
                        ForEach(challenges) { challenge in
                            NavigationLink(destination: ChallengeDetailView(challenge: challenge)) {
                                ChallengeCard(challenge: challenge)
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(Color.white)
            .navigationTitle("MindFul Challanges")
            .navigationBarItems(trailing: NavigationLink(destination: SimpleLeaderboardView()) {
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            })
        }
    }
}

struct ChallengeCard: View {
    let challenge: Challenge

    var body: some View {
        VStack {
            Image(challenge.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .cornerRadius(10)

            Text(challenge.title)
                .font(.headline)
                .padding(.top, 5)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ChallengeDetailView: View {
    let challenge: Challenge

    var body: some View {
        VStack {
            Image(challenge.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)

            Text(challenge.title)
                .font(.title)
                .padding()
                .foregroundColor(.green)

            Text("Description détaillée du défi et instructions vont ici.")
                .padding()

            Spacer()
        }
        .navigationTitle(challenge.title)
        .background(Color.white)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profil utilisateur et historique des défis vont ici.")
            .navigationTitle("Historique")
            .background(Color.green)
    }
}

struct homechallenges: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

