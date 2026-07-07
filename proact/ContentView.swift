//
//  ContentView.swift
//  proact
//
//  Created by Sam Orgill on 07/07/2026.
//

import SwiftUI
import Foundation
import Combine
import WebKit

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
    var body: some View {
        ServiceGrid(variant: .compact)
    }
}


private struct ServicesView: View {

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Professional support for expatriates, overseas property owners and internationally mobile families.")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 8)

                    ServiceGrid(variant: .detailed)
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
                        Text("The latest expatriate news, views & analysis.")
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
                        NavigationLink(destination: BlogDetailView(post: post)) {
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Link(destination: URL(string: "https://proactpartnership.com/subscribe")!) {
                        Label("Subscribe", systemImage: "envelope.badge.fill")
                            .font(.headline)
                            .foregroundStyle(ProACTTheme.red)
                    }
                    .accessibilityLabel("Subscribe to the ProACT newsletter")
                }
            }
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
    var selectedService: String? = nil

    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var location = ""
    @State private var service = "General enquiry"
    @State private var message = ""
    @State private var prefersCall = true
    @State private var showMailError = false

    private let serviceOptions = ["General enquiry"] + ProACTService.all.map(\.title)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    ContactHeroCard()

                    VStack(alignment: .leading, spacing: 14) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Send an enquiry")
                                .font(.title2.bold())
                                .foregroundStyle(ProACTTheme.primary)

                            Text("Tell us what you need help with and the team will point you towards the right service.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }

                        VStack(spacing: 12) {
                            ContactTextField(title: "Name", text: $name, icon: "person.fill", keyboardType: .default)
                            ContactTextField(title: "Email", text: $email, icon: "envelope.fill", keyboardType: .emailAddress)
                            ContactTextField(title: "Phone", text: $phone, icon: "phone.fill", keyboardType: .phonePad)
                            ContactTextField(title: "Where are you based?", text: $location, icon: "mappin.and.ellipse", keyboardType: .default)

                            VStack(alignment: .leading, spacing: 8) {
                                Label("Service", systemImage: "briefcase.fill")
                                    .font(.caption.bold())
                                    .foregroundStyle(ProACTTheme.primary)

                                Picker("Service", selection: $service) {
                                    ForEach(serviceOptions, id: \.self) { option in
                                        Text(option).tag(option)
                                    }
                                }
                                .pickerStyle(.menu)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            .background(ProACTTheme.secondary)
                            .clipShape(RoundedRectangle(cornerRadius: 14))

                            VStack(alignment: .leading, spacing: 8) {
                                Label("How can we help?", systemImage: "text.bubble.fill")
                                    .font(.caption.bold())
                                    .foregroundStyle(ProACTTheme.primary)

                                TextEditor(text: $message)
                                    .frame(minHeight: 120)
                                    .scrollContentBackground(.hidden)
                                    .background(.clear)
                            }
                            .padding()
                            .background(ProACTTheme.secondary)
                            .clipShape(RoundedRectangle(cornerRadius: 14))

                            Toggle("I would prefer a call back", isOn: $prefersCall)
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(ProACTTheme.primary)
                        }

                        Button {
                            submitEnquiry()
                        } label: {
                            Label("Send enquiry", systemImage: "paperplane.fill")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(canSubmit ? ProACTTheme.red : Color.gray.opacity(0.45))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .disabled(!canSubmit)
                    }
                    .padding(18)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 5)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick contact")
                            .font(.headline)
                            .foregroundStyle(ProACTTheme.primary)

                        ContactButton(title: "Chat with us on WhatsApp", icon: "message.fill", url: URL(string: "https://wa.me/441753260010")!, isPrimary: false)
                        ContactButton(title: "Visit Website", icon: "globe", url: URL(string: "https://proactpartnership.com")!)
                        ContactButton(title: "Email ProACT", icon: "envelope.fill", url: URL(string: "mailto:info@proactpartnership.com")!)
                        ContactButton(title: "Buy Services", icon: "cart.fill", url: URL(string: "https://store.proactpartnership.com")!)
                    }
                    .padding(18)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 5)
                }
                .padding()
            }
            .background(ProACTTheme.secondary)
            .navigationTitle("Contact")
            .onAppear {
                if let selectedService {
                    service = selectedService
                }
            }
            .alert("Unable to open email", isPresented: $showMailError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please email info@proactpartnership.com directly or use the website contact route.")
            }
        }
    }

    private var canSubmit: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func submitEnquiry() {
        let subject = "ProACT App Enquiry - \(service)"
        let body = """
        Name: \(name)
        Email: \(email)
        Phone: \(phone.isEmpty ? "Not provided" : phone)
        Location: \(location.isEmpty ? "Not provided" : location)
        Service: \(service)
        Preferred contact: \(prefersCall ? "Call back" : "Email")

        Message:
        \(message)
        """

        var components = URLComponents()
        components.scheme = "mailto"
        components.path = "info@proactpartnership.com"
        components.queryItems = [
            URLQueryItem(name: "subject", value: subject),
            URLQueryItem(name: "body", value: body)
        ]

        guard let url = components.url, UIApplication.shared.canOpenURL(url) else {
            showMailError = true
            return
        }

        UIApplication.shared.open(url)
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

private enum ServiceGridVariant {
    case compact
    case detailed
}

private struct ServiceGrid: View {
    let variant: ServiceGridVariant

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: variant == .compact ? 12 : 14) {
            ForEach(ProACTService.all) { service in
                ServiceCard(service: service, variant: variant)
            }
        }
    }
}

private struct ServiceCard: View {
    let service: ProACTService
    let variant: ServiceGridVariant

    var body: some View {
        NavigationLink(destination: ContactView(selectedService: service.title)) {
            VStack(alignment: .leading, spacing: variant == .compact ? 10 : 12) {
                Image(systemName: service.icon)
                    .font(variant == .compact ? .title3 : .title2)
                    .foregroundStyle(.white)
                    .frame(width: variant == .compact ? 40 : 46, height: variant == .compact ? 40 : 46)
                    .background(ProACTTheme.primary)
                    .clipShape(RoundedRectangle(cornerRadius: variant == .compact ? 12 : 14))

                VStack(alignment: .leading, spacing: 6) {
                    Text(service.title)
                        .font(.headline)
                        .foregroundStyle(ProACTTheme.primary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(variant == .compact ? service.summary : service.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(variant == .compact ? 3 : 6)
                        .fixedSize(horizontal: false, vertical: true)
                }

                if variant == .detailed {
                    Spacer(minLength: 0)
                }

                HStack(spacing: 6) {
                    Text("Enquire")
                        .font(.caption.bold())

                    Image(systemName: "arrow.right")
                        .font(.caption.bold())
                }
                .foregroundStyle(ProACTTheme.red)
                .padding(.top, 2)
            }
            .padding(variant == .compact ? 14 : 16)
            .frame(maxWidth: .infinity, minHeight: variant == .compact ? 164 : 224, alignment: .topLeading)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: variant == .compact ? 20 : 22))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(.plain)
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

private struct BlogDetailView: View {
    let post: BlogPost

    var body: some View {
        WebArticleView(url: post.url)
            .navigationTitle(post.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Link(destination: post.url) {
                        Image(systemName: "safari.fill")
                            .foregroundStyle(ProACTTheme.primary)
                    }
                    .accessibilityLabel("Open article in browser")
                }
            }
    }
}

private struct WebArticleView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.backgroundColor = UIColor(ProACTTheme.secondary)
        webView.backgroundColor = UIColor(ProACTTheme.secondary)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if webView.url != url {
            webView.load(URLRequest(url: url))
        }
    }
}

private struct ContactHeroCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image("IMG_0100")
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .accessibilityLabel("ProACT adviser")

            VStack(alignment: .leading, spacing: 8) {
                Text("Speak to ProACT")
                    .font(.title.bold())
                    .foregroundStyle(ProACTTheme.primary)

                Text("Get in touch about tax, residency, business services, wills, probate, property or international planning support.")
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.bottom, 4)
    }
}

private struct ContactTextField: View {
    let title: String
    @Binding var text: String
    let icon: String
    let keyboardType: UIKeyboardType

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.caption.bold())
                .foregroundStyle(ProACTTheme.primary)

            TextField(title, text: $text)
                .textInputAutocapitalization(keyboardType == .emailAddress ? .never : .words)
                .keyboardType(keyboardType)
                .autocorrectionDisabled(keyboardType == .emailAddress)
        }
        .padding()
        .background(ProACTTheme.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

private struct ContactButton: View {
    let title: String
    let icon: String
    let url: URL
    var isPrimary: Bool = true

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
            .background(isPrimary ? ProACTTheme.primary : ProACTTheme.red)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

private struct ProACTService: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let summary: String
    let description: String

    static let all = [
        ProACTService(
            title: "Tax",
            icon: "doc.text.fill",
            summary: "Tax registration, tax returns, accounting & reports",
            description: "Tax registration, annual tax returns, overseas income reporting, accounting support and practical tax reports for expatriates, landlords and cross-border individuals."
        ),
        ProACTService(
            title: "Residency",
            icon: "person.text.rectangle.fill",
            summary: "Applications, registrations & renewals",
            description: "Support with residency applications, registrations, renewals and local obligations when moving to, living in or working from another country."
        ),
        ProACTService(
            title: "Business Services",
            icon: "briefcase.fill",
            summary: "Accounts, tax, registered offices and company support",
            description: "Accounts, business tax, company administration, registered Cyprus office services and ongoing support for consultants, business owners and international companies."
        ),
        ProACTService(
            title: "Wills & Probate",
            icon: "signature",
            summary: "Wills, estate planning across borders & probate",
            description: "Wills, estate planning and probate support for expatriates with family, assets, property or responsibilities across more than one country."
        ),
        ProACTService(
            title: "Property",
            icon: "building.columns.fill",
            summary: "Sales, lettings & commercial investments",
            description: "Guidance around property sales, lettings, overseas landlords, commercial investments and the tax or residency issues that can sit alongside property decisions."
        ),
        ProACTService(
            title: "Investments",
            icon: "chart.line.uptrend.xyaxis",
            summary: "Joined-up financial guidance",
            description: "Joined-up financial guidance for expatriates where investments, pensions, tax residence, property and long-term planning need to be considered together."
        )
    ]
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
