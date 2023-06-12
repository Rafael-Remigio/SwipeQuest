import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E), // Define a cor de fundo como preto
        ),
        child: Column(
          children: [
            Spacer(),
            PersonSignature(
              name: 'Rafael Remígio',
              linkedinUrl: 'https://www.linkedin.com/in/rafael-remígio-148866252/',
              githubUrl: 'https://github.com/Rafael-Remigio',
              linkedinImage:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/LinkedIn_icon.svg/768px-LinkedIn_icon.svg.png',
              githubImage:
                  'https://cdn.icon-icons.com/icons2/2351/PNG/512/logo_github_icon_143196.png',
            ),
            Spacer(),
            PersonSignature(
              name: 'MPetersonNevesFilho',
              linkedinUrl: 'https://www.linkedin.com/in/mpeterson-nevesfilho/',
              githubUrl: 'https://github.com/MPetersonNevesFilho',
              linkedinImage:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/LinkedIn_icon.svg/768px-LinkedIn_icon.svg.png',
              githubImage:
                  'https://cdn.icon-icons.com/icons2/2351/PNG/512/logo_github_icon_143196.png',
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class PersonSignature extends StatelessWidget {
  final String name;
  final String linkedinUrl;
  final String githubUrl;
  final String linkedinImage;
  final String githubImage;

  PersonSignature({
    required this.name,
    required this.linkedinUrl,
    required this.githubUrl,
    required this.linkedinImage,
    required this.githubImage,
  });

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF1E1E1E), // Define a cor do card como transparente
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Arredonda as bordas do card
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _launchURL(linkedinUrl),
                    child: Image.network(
                      linkedinImage,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () => _launchURL(githubUrl),
                    child: Image.network(
                      githubImage,
                      height: 74.0,
                      width: 74.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignatureScreen(),
  ));
}
