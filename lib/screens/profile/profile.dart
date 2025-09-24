import 'package:flutter/material.dart';
import 'package:ums_staff/screens/auth/login.dart';
import 'package:ums_staff/screens/profile/model.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';

import '../../core/http.dart';
import '../../shared/theme/color.dart';
import '../../widgets/card/profile.dart';
import '../../widgets/dataDisplay/typography.dart';
import '../../widgets/skeleton/profile.dart';
import 'edit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool loading = false;
  Profile? profile;

  void getProfile(){
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.getProfileData().then((value) {
      setState(() {
        loading = false;
      });
      if (!value.success) {
        SnackBarMessage.errorSnackbar(context, value.message);
      } else {
        var docType = value.data['data'];
        if( docType != null ){
          setState(() {
            profile = Profile.fromJson(docType);
          });
        }
      }
    });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 375;

    void logout(){
      var http = HttpRequest();
      http.clearToken();
      Navigator.pushReplacementNamed(context, LoginScreen.route);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Minimal header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#6505A3'),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage your personal information',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Expanded(
            child: Stack(
              children: [
                // Background decoration
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: HexColor('#6505A3').withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Profile card with modern border
                      Container(
                        child: loading
                            ? const ProfileSkeleton()
                            : ProfileCard(profile: profile),
                      ),

                      const SizedBox(height: 32),

                      // Quick actions section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'QUICK ACTIONS',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),

                            if (isSmallScreen)
                              Column(
                                children: [
                                  _buildActionButton(
                                    icon: Icons.edit_document,
                                    title: 'Edit Profile',
                                    subtitle: 'Update your personal info',
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          EditProfileScreen.route,
                                          arguments: {'profile': profile}
                                      ).then((value) {
                                        setState(() {
                                          getProfile();
                                        });
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  _buildActionButton(
                                    icon: Icons.logout,
                                    title: 'Sign Out',
                                    subtitle: 'Log out from your account',
                                    onTap: logout,
                                    isLogout: true,
                                  ),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildActionButton(
                                      icon: Icons.edit_document,
                                      title: 'Edit Profile',
                                      subtitle: 'Update personal info',
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            EditProfileScreen.route,
                                            arguments: {'profile': profile}
                                        ).then((value) {
                                          setState(() {
                                            getProfile();
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildActionButton(
                                      icon: Icons.logout,
                                      title: 'Sign Out',
                                      subtitle: 'Log out from account',
                                      onTap: logout,
                                      isLogout: true,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Statistics section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              HexColor('#6505A3').withOpacity(0.1),
                              HexColor('#6505A3').withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem('Member since', '2023'),
                            _buildStatItem('Last login', 'Today'),
                            _buildStatItem('Status', 'Active'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Account deletion policy link
                      // Container(
                      //   width: double.infinity,
                      //   padding: const EdgeInsets.all(16),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(12),
                      //     border: Border.all(
                      //       color: Colors.grey[300]!,
                      //       width: 1,
                      //     ),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.delete_outline,
                      //         color: Colors.red[400],
                      //         size: 20,
                      //       ),
                      //       const SizedBox(width: 12),
                      //       Expanded(
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'Account Deletion',
                      //               style: TextStyle(
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w600,
                      //                 color: Colors.grey[800],
                      //               ),
                      //             ),
                      //             const SizedBox(height: 2),
                      //             Text(
                      //               'Learn about our account deletion policy',
                      //               style: TextStyle(
                      //                 fontSize: 12,
                      //                 color: Colors.grey[600],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Icon(
                      //         Icons.arrow_forward_ios_rounded,
                      //         color: Colors.grey[500],
                      //         size: 16,
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom navigation styled footer
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  // Navigate to account deletion policy
                  _showAccountDeletionPolicy(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.privacy_tip_outlined,
                        color: HexColor('#6505A3'), size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Account Deletion Policy',
                      style: TextStyle(
                        color: HexColor('#6505A3'),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'v',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '1.16.102',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAccountDeletionPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.security, color: HexColor('#6505A3')),
              const SizedBox(width: 5),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Account Deletion Policy',
                  style: TextStyle(
                    color: HexColor('#6505A3'),
                    fontWeight: FontWeight.bold,
                    fontSize: 20, // Keep your small size but let FittedBox handle scaling
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Account Deletion Process',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'To request account deletion, please contact our support team with your account details. '
                      'We will process your request within 30 days of verification.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Data Retention',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Upon account deletion, all personal data will be permanently removed from our systems. '
                      'Some anonymized data may be retained for analytical purposes.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Contact Support',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: support@umsstaff.com\nPhone: +1-555-0123',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'CLOSE',
                style: TextStyle(
                  color: HexColor('#6505A3'),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to full policy page or open web view
                Navigator.of(context).pop();
                // Add navigation to full policy page here
              },
              child: Text(
                'VIEW FULL POLICY',
                style: TextStyle(
                  color: HexColor('#6505A3'),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Material(
      color: isLogout ? HexColor('#6505A3').withOpacity(0.1) : Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isLogout ? HexColor('#6505A3').withOpacity(0.3) : Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isLogout ? HexColor('#6505A3') : HexColor('#6505A3').withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isLogout ? Colors.white : HexColor('#6505A3'),
                  size: 18,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isLogout ? HexColor('#6505A3') : Colors.grey[800],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: isLogout ? HexColor('#6505A3').withOpacity(0.7) : Colors.grey[600],
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: HexColor('#6505A3'),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}