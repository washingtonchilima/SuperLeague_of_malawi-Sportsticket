import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatefulWidget {
  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  String selectedCountryCode = 'Spain (+34)';
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1A3A),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D1A3A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'E-mail address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'chilimawashington20@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This account is associated with this email address and mobile phone. If you wish to change your email address, please log out and log back in. Remember that your tickets will be associated with the same email address as your ticket purchase or transfer.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Country/Region code',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedCountryCode,
              dropdownColor: Color(0xFF0D1A3A),
              items: [
                DropdownMenuItem(
                  child: Text(
                    'Spain (+34)',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'Spain (+34)',
                ),
                DropdownMenuItem(
                  child: Text(
                    'USA (+1)',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'USA (+1)',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Malawi (+265)',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'Malawi (+265)',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Zambia (+260)',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'Zambia (+260)',
                ),
                DropdownMenuItem(
                  child: Text(
                    'South Africa (+27)',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'South Africa (+27)',
                ),
                // Add more country codes as needed
              ],
              onChanged: (value) {
                setState(() {
                  selectedCountryCode = value!;
                });
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF1A2B4E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Phone number',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
              ),
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF1A2B4E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.yellow, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Save action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'SAVE',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
