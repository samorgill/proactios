//
//  ContentView.swift
//  proact
//
//  Created by Sam Orgill on 07/07/2026.
//

import SwiftUI
import Foundation
import Combine

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            ServicesView()
                .tabItem {
                    Label("Services", systemImage: "briefcase.fill")
                }

            BlogView()
                .tabItem {
                    Label("Blog", systemImage: "newspaper.fill")
                }

            ContactView()
                .tabItem {
                    Label("Contact", systemImage: "envelope.fill")
                }
        }
        .tint(ProACTTheme.primary)
    }
}

private enum ProACTTheme {
    static let primary = Color(red: 8 / 255, green: 43 / 255, blue: 95 / 255)
    static let secondary = Color(red: 251 / 255, green: 251 / 255, blue: 251 / 255)
    static let red = Color(red: 176 / 255, green: 0, blue: 0)
}

private struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HeroCard()

                    SectionHeader(
                        title: "What do you need help with?",
                        subtitle: "Choose the area that best matches your situation."
                    )

                    QuickHelpGrid()

                    SectionHeader(
                        title: "Why ProACT?",
                        subtitle: "Clear expatriate advice across tax, residency, business services, property and estate planning."
                    )

                    VStack(spacing: 12) {
                        FeatureRow(icon: "globe.europe.africa.fill", title: "Cross-border focus", text: "Support for people with income, assets, family or business interests across more than one country.")
                        FeatureRow(icon: "checkmark.seal.fill", title: "Practical next steps", text: "Plain English guidance on what applies, what to do next and where to avoid costly mistakes.")
                        FeatureRow(icon: "person.2.fill", title: "Advice from real people", text: "A joined-up team supporting expatriates, business owners and internationally mobile families.")
                    }
                    .frame(maxWidth: .infinity)

                    AdvisorStrip()
                    BottomImageCard()
                    HomeContactCard()
                }
                .padding()
            }
            .background(ProACTTheme.secondary)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

private struct HeroCard: View {
    var body: some View {
        VStack(alignment: .center, spacing: 18) {
            Image("ppea")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 270)
                .padding(12)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .accessibilityLabel("ProACT Partnership Expatriate Advice")

            VStack(alignment: .center, spacing: 8) {

                Text("Living & working abroad. Across borders and down generations.")
                    .font(.subheadline.weight(.medium))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)

            NavigationLink(destination: ServicesView()) {
                Label("View Services", systemImage: "arrow.right.circle.fill")
                    .font(.subheadline.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ProACTTheme.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: .black.opacity(0.08), radius: 14, x: 0, y: 8)
    }
}

private struct AdvisorStrip: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack(alignment: .center) {
                Image("ProACT_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 155)
                    .accessibilityLabel("ProACT Partnership")

                Spacer(minLength: 12)

                Text("Client advice")
                    .font(.caption.bold())
                    .textCase(.uppercase)
                    .foregroundStyle(ProACTTheme.red)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(ProACTTheme.red.opacity(0.08))
                    .clipShape(Capsule())
            }

            HStack(spacing: -12) {
                AdvisorImage(name: "ProactSam", size: 64)
                AdvisorImage(name: "proactlady4", size: 64)
                AdvisorImage(name: "ps_nobg", size: 64)
            }
            .frame(maxWidth: .infinity)

            VStack(alignment: .center, spacing: 6) {
                Text("Guidance from people who understand expatriate life.")
                    .font(.headline)
                    .foregroundStyle(ProACTTheme.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Explore services, read current guidance and contact the team from one place.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(18)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 5)
    }
}

private struct AdvisorImage: View {
    let name: String
    let size: CGFloat

    var body: some View {
        Image(name)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(.white, lineWidth: 3))
            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
    }
}

private struct QuickHelpGrid: View {
    private let items = [
        QuickHelpItem(title: "Tax", icon: "doc.text.fill", text: "Tax registration, tax returns, accounting & reports"),
        QuickHelpItem(title: "Residency", icon: "person.text.rectangle.fill", text: "Applications,  registrations & renewals"),
        QuickHelpItem(title: "Business services", icon: "briefcase.fill", text: "Accounts, tax, registered offices and company support"),
        QuickHelpItem(title: "Wills & probate", icon: "signature", text: "Wills, Estate planning across borders & Probate"),
        QuickHelpItem(title: "Property", icon: "building.columns.fill", text: "Sales, lettings & commercial investments"),
        QuickHelpItem(title: "Investments", icon: "building.columns.fill", text: "Joined-up financial guidance")
    ]

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(items) { item in
                QuickHelpCard(item: item)
            }
        }
    }
}

private struct QuickHelpCard: View {
    let item: QuickHelpItem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: item.icon)
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(ProACTTheme.primary)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(item.title)
                .font(.headline)
                .foregroundStyle(ProACTTheme.primary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            Text(item.text)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .topLeading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

private struct QuickHelpItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let text: String
}

private struct ServicesView: View {
    private let services = [
        Service(title: "Personal Tax Returns", icon: "doc.text.fill", description: "Annual tax return support for expatriates, overseas landlords and individuals with cross-border income."),
        Service(title: "Expat Tax Planning", icon: "chart.pie.fill", description: "Residence, double tax treaty position, overseas income and practical tax planning before problems arise."),
        Service(title: "Business Accounts & Tax", icon: "briefcase.fill", description: "Accounts, tax compliance and practical support for businesses, consultants and company owners."),
        Service(title: "Cyprus Company Support", icon: "building.2.fill", description: "Registered Cyprus address, company administration and ongoing business compliance support."),
        Service(title: "Wills, Probate & Estate Planning", icon: "signature", description: "Wills, probate support and estate planning for expats with family, assets or obligations across countries."),
        Service(title: "Residency Applications", icon: "person.text.rectangle.fill", description: "Support obtaining residency, handling registrations and understanding local obligations when moving abroad."),
        Service(title: "Property & Investments", icon: "building.columns.fill", description: "Joined-up expatriate guidance where property, investment and tax decisions overlap.")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Our Services")
                            .font(.largeTitle.bold())
                            .foregroundStyle(ProACTTheme.primary)
                        Text("Professional support for expatriates, overseas property owners and internationally mobile families.")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 8)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                        ForEach(services) { service in
                            ServiceCard(service: service)
                        }
                    }
                }
                .padding()
            }
            .background(ProACTTheme.secondary)
            .navigationTitle("Services")
        }
    }
}

private struct BlogView: View {
    @StateObject private var viewModel = BlogFeedViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Latest guidance")
                            .font(.title2.bold())
                        Text("Articles and updates from the ProACT blog for expatriates, overseas property owners and internationally mobile families.")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

                if viewModel.isLoading && viewModel.posts.isEmpty {
                    ProgressView("Loading blog posts...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                } else if let errorMessage = viewModel.errorMessage, viewModel.posts.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Unable to load blog")
                            .font(.headline)
                            .foregroundStyle(ProACTTheme.primary)
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Link("Open ProACT Blog", destination: URL(string: "https://proactpartnership.com/blog/")!)
                            .font(.headline)
                            .foregroundStyle(ProACTTheme.red)
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                } else {
                    ForEach(viewModel.posts) { post in
                        Link(destination: post.url) {
                            BlogPostCard(post: post)
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }

                Link(destination: URL(string: "https://proactpartnership.com/blog/")!) {
                    Label("Open ProACT Blog", systemImage: "safari.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(ProACTTheme.primary)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .background(ProACTTheme.secondary)
            .navigationTitle("Blog")
            .task {
                viewModel.loadFeed()
            }
            .refreshable {
                viewModel.loadFeed(forceRefresh: true)
            }
        }
    }
}

private struct ContactView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 16) {
                        Image("IMG_0100")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 220)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .accessibilityLabel("ProACT adviser")

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Speak to ProACT")
                                .font(.title.bold())
                            Text("Get in touch about tax, residency, wills, probate or international planning support.")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.bottom, 8)

                    ContactButton(title: "Visit Website", icon: "globe", url: URL(string: "https://proactpartnership.com")!)
                    ContactButton(title: "Email ProACT", icon: "envelope.fill", url: URL(string: "mailto:info@proactpartnership.com")!)
                    ContactButton(title: "Book / Buy Services", icon: "cart.fill", url: URL(string: "https://store.proactpartnership.com")!)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Initial app scope")
                            .font(.headline)
                        Text("This version is deliberately light: a clean service overview, simple blog access and quick contact routes.")
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                .padding()
            }
            .background(ProACTTheme.secondary)
            .navigationTitle("Contact")
        }
    }
}

private struct SectionHeader: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(.title2.bold())
                .foregroundStyle(ProACTTheme.primary)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)

            Text(subtitle)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

private struct FeatureRow: View {
    let icon: String
    let title: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(ProACTTheme.primary)
                .frame(width: 34)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct BottomImageCard: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("samofficebw")
                .resizable()
                .scaledToFill()
                .frame(height: 210)
                .frame(maxWidth: .infinity)
                .clipped()
                .overlay(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.68)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            VStack(alignment: .leading, spacing: 4) {
                Text("Advice that follows you abroad")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("Tax, estate planning and practical support for expatriate life.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.88))
            }
            .padding(18)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.10), radius: 12, x: 0, y: 6)
    }
}

private struct HomeContactCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Not sure where to start?")
                .font(.title3.bold())
                .foregroundStyle(ProACTTheme.primary)

            Text("Contact ProACT and we will point you towards the right service.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            NavigationLink(destination: ContactView()) {
                Label("Contact the team", systemImage: "envelope.fill")
                    .font(.subheadline.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ProACTTheme.primary)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 5)
    }
}

private struct ServiceCard: View {
    let service: Service

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: service.icon)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 46, height: 46)
                .background(ProACTTheme.primary)
                .clipShape(RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 6) {
                Text(service.title)
                    .font(.headline)
                    .foregroundStyle(ProACTTheme.primary)
                    .lineLimit(2)

                Text(service.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(5)
            }

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 190, alignment: .topLeading)
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

private struct BlogPostCard: View {
    let post: BlogPost

    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(post.displayDate.uppercased())
                    .font(.caption.bold())
                    .foregroundStyle(ProACTTheme.red)
                Text(post.title)
                    .font(.headline)
                    .foregroundStyle(ProACTTheme.primary)
                Text("Tap to read")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

private struct ContactButton: View {
    let title: String
    let icon: String
    let url: URL

    var body: some View {
        Link(destination: url) {
            HStack {
                Label(title, systemImage: icon)
                    .font(.headline)
                Spacer()
                Image(systemName: "arrow.up.right")
                    .font(.subheadline.bold())
            }
            .padding()
            .background(ProACTTheme.primary)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

private struct Service: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let description: String
}

private struct BlogPost: Identifiable {
    let id = UUID()
    let title: String
    let url: URL
    let displayDate: String
}

private final class BlogFeedViewModel: NSObject, ObservableObject, XMLParserDelegate {
    @Published var posts: [BlogPost] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let feedURL = URL(string: "https://proactpartnership.com/blog/?format=rss")!
    private var parsedPosts: [BlogPost] = []
    private var currentElement = ""
    private var currentTitle = ""
    private var currentLink = ""
    private var currentPubDate = ""
    private var isInsideItem = false

    func loadFeed(forceRefresh: Bool = false) {
        if isLoading || (!posts.isEmpty && !forceRefresh) {
            return
        }

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: feedURL) { [weak self] data, _, error in
            guard let self else { return }

            if let error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
                return
            }

            guard let data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No blog feed data was returned."
                    self.isLoading = false
                }
                return
            }

            self.parsedPosts = []
            let parser = XMLParser(data: data)
            parser.delegate = self
            let success = parser.parse()

            DispatchQueue.main.async {
                self.posts = self.parsedPosts
                self.errorMessage = success ? nil : "The blog feed could not be read."
                self.isLoading = false
            }
        }.resume()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        currentElement = elementName

        if elementName == "item" {
            isInsideItem = true
            currentTitle = ""
            currentLink = ""
            currentPubDate = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard isInsideItem else { return }

        switch currentElement {
        case "title":
            currentTitle += string
        case "link":
            currentLink += string
        case "pubDate":
            currentPubDate += string
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let title = currentTitle.trimmingCharacters(in: .whitespacesAndNewlines)
            let link = currentLink.trimmingCharacters(in: .whitespacesAndNewlines)
            let pubDate = currentPubDate.trimmingCharacters(in: .whitespacesAndNewlines)

            if let url = URL(string: link), !title.isEmpty {
                parsedPosts.append(
                    BlogPost(
                        title: title,
                        url: url,
                        displayDate: formattedDate(from: pubDate)
                    )
                )
            }

            isInsideItem = false
        }

        currentElement = ""
    }

    private func formattedDate(from rssDate: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"

        guard let date = formatter.date(from: rssDate) else {
            return rssDate.isEmpty ? "ProACT Blog" : rssDate
        }

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .none
        return displayFormatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
