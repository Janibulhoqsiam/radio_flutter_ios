import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class contactscreen extends StatelessWidget {
  const contactscreen({super.key});

  void _openWhatsApp() async {
    final phone = '+597400500'; // Your phone number here
    final url = 'https://wa.me/$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F6BD6),
              Color(0xFF1552A1),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Email Section with padding
                    // Padding(
                    //   padding: const EdgeInsets.all(16),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: const [
                    //       SizedBox(height: 24),
                    //       SectionHeader(title: 'Email:'),
                    //       ContactDetail(title: 'Directie', subtitle: ' charles@apintie.sr'),
                    //       ContactDetail(title: 'Advertenties/Administratie', subtitle: 'sales@apintie.sr'),
                    //       ContactDetail(title: 'Webmaster', subtitle: 'webmaster@apintie.sr'),
                    //       SizedBox(height: 24),
                    //     ],
                    //   ),
                    // ),

                    EmailSection(),

                    // ✅ Phone section without global padding
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeader(title: 'Telefoonnummers:'),
                          Row(
                            children: [
                              const Expanded(
                                child: ContactDetail(
                                  title: 'Studio (Radio)',
                                  subtitle: '+597 400500',
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  final phone = '+597400500';
                                  final url = 'https://wa.me/$phone';
                                  launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.09),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green[600],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.lightGreenAccent, width: 2),
                                  ),
                                  child: const Text(
                                    'whatsAPP',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const ContactDetail(title: 'Studio (Televisie)', subtitle: '+597 401400'),
                          const ContactDetail(title: 'Nieuwsdienst', subtitle: '+597 400403'),
                          const ContactDetail(title: 'Sportredactie', subtitle: '+597 400800'),
                          const ContactDetail(title: 'Administratie', subtitle: '+597 400455'),
                          const ContactDetail(title: 'Directie', subtitle: '+597 400450'),
                          const ContactDetail(title: 'Facsimile', subtitle: '+597 400684'),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),

                    // ✅ Address section with global padding
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SectionHeader(title: 'Post- en bezoekadres:'),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Verlengde Gemenelandsweg 37\nParamaribo, Suriname\nZuid Amerika',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

class CardItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const CardItem({required this.title, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF064997),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class ContactDetail extends StatelessWidget {
  final String title;
  final String subtitle;

  const ContactDetail({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
    );
  }
}



class EmailSection extends StatelessWidget {
  const EmailSection({super.key});



  Future<void> _launchEmailClient(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    print('Attempting to launch email client with URI: $emailUri');

    try {
      final bool launched = await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication, // force using external app chooser
      );

      if (!launched) {
        print('Could not launch email client for URI: $emailUri');
        throw 'Could not launch email client';
      }
    } catch (e) {
      print('Error launching email client: $e');

    }
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const SectionHeader(title: 'Email:'),
          Row(
            children: [
              const Expanded(
                child: ContactDetail(
                  title: 'Directie',
                  subtitle: 'charles@apintie.sr',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.email, color: Colors.blue),
                onPressed: () => _launchEmailClient('charles@apintie.sr'),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: ContactDetail(
                  title: 'Advertenties/Administratie',
                  subtitle: 'sales@apintie.sr',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.email, color: Colors.blue),
                onPressed: () => _launchEmailClient('sales@apintie.sr'),
              ),
            ],
          ),

          Row(
            children: [
              const Expanded(
                child: ContactDetail(
                  title: 'Webmaster',
                  subtitle: 'webmaster@apintie.sr',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.email, color: Colors.blue),
                onPressed: () => _launchEmailClient('webmaster@apintie.sr'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
