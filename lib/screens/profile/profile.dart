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
        SnackBarMessage.errorSnackbar(
            context, value.message);
      } else {
        var docType =value.data['data'];
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
  }
  @override
  Widget build(BuildContext context) {
    bool midiumDevice = MediaQuery.of(context).size.width >= 392;
    bool smallDevice = MediaQuery.of(context).size.width >= 375;
    void logout(){
      var http = HttpRequest();
      http.logout().then((value){
        http.clearToken();
        Navigator.pushReplacementNamed(context, LoginScreen.route);
      });
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      loading ? const ProfileSkeleton() : ProfileCard(profile:profile),
                      const SizedBox(height: 32),
                      smallDevice
                          ? Row(
                              children: [
                                Expanded(
                                    child: OutlinedButton.icon(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, EditProfileScreen.route, arguments: {'profile': profile}).then((value) {
                                                setState(() {
                                                  getProfile();
                                                });
                                          });
                                        },
                                        icon: const Icon(Icons.edit_outlined),
                                        label: const Text('PROFILE'))),
                                SizedBox(width: midiumDevice ? 32 : 15),
                                Expanded(
                                    child: ElevatedButton.icon(
                                        onPressed: logout,
                                        icon: const Icon(Icons.logout_outlined),
                                        label: const Text('LOG OUT'))),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                    child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, EditProfileScreen.route, arguments: {'profile': profile}).then((value) {

                                                setState(() {
                                                  getProfile();
                                            });
                                          });
                                        },
                                        child: const Text('PROFILE'))),
                                SizedBox(width: midiumDevice ? 32 : 15),
                                Expanded(
                                    child: ElevatedButton(
                                        onPressed: logout,
                                        child: const Text('LOG OUT'))),
                              ],
                            ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: AppTypography(
                text: 'Account Deletion Policy',
                size: 12,
                weight: FontWeight.w500,
                spacing: 0.1,
                color: HexColor('#6505A3'),
              )),
              const AppTypography(
                text: 'Version: ',
                size: 12,
                weight: FontWeight.w500,
                spacing: 0.1,
              ),
              const AppTypography(
                text: '1.16.102',
                size: 12,
                weight: FontWeight.w600,
                spacing: 0.1,
              )
            ],
          ),
        )
      ],
    );
  }
}
