import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DashenBankApp());
}

class DashenBankApp extends StatelessWidget {
  const DashenBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashen Bank',
      theme: ThemeData(
        primaryColor: const Color(0xFF1A3E6F),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'System',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A3E6F),
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF1A3E6F),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
      ),
      home: const PinLoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==================== PIN LOGIN SCREEN ====================
class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  String _pin = '';
  bool _showPin = false;
  bool _isLoading = false;

  void _onNumberTap(String number) {
    setState(() {
      if (_pin.length < 5) {
        _pin += number;
      }
    });
  }

  void _onClear() {
    setState(() {
      if (_pin.isNotEmpty) {
        _pin = _pin.substring(0, _pin.length - 1);
      }
    });
  }

  Future<void> _onSubmit() async {
    if (_pin.length == 5) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashenBankHomePage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter 5-digit PIN'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 80,
                        errorBuilder: (_, __, ___) => Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A3E6F),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text('DB', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Welcome back!', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 10),
                      const Text('Enter Your PIN To Sign In.', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: index < _pin.length ? const Color(0xFF1A3E6F) : Colors.grey.shade300,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: _showPin && index < _pin.length
                                  ? Text(_pin[index], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A3E6F)))
                                  : index < _pin.length
                                      ? Container(width: 16, height: 16, decoration: const BoxDecoration(color: Color(0xFF1A3E6F), shape: BoxShape.circle))
                                      : null,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: _showPin,
                                  onChanged: (val) => setState(() => _showPin = val ?? false),
                                  activeColor: const Color(0xFF1A3E6F),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text('Show PIN'),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Forgot PIN? Reset PIN', style: TextStyle(color: Color(0xFF1A3E6F))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ['1', '2', '3'].map((n) => _buildNumberButton(n)).toList()),
                          const SizedBox(height: 16),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ['4', '5', '6'].map((n) => _buildNumberButton(n)).toList()),
                          const SizedBox(height: 16),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ['7', '8', '9'].map((n) => _buildNumberButton(n)).toList()),
                          const SizedBox(height: 16),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_buildNumberButton('0'), _buildClearButton(), _buildSubmitButton()]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A3E6F))),
                    SizedBox(height: 20),
                    Text('Loading your account...', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) => GestureDetector(
        onTap: _isLoading ? null : () => _onNumberTap(number),
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4)]),
          child: Center(child: Text(number, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: _isLoading ? Colors.grey.shade400 : Colors.black87))),
        ),
      );

  Widget _buildClearButton() => GestureDetector(
        onTap: _isLoading ? null : _onClear,
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
          child: const Center(child: Text('C', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.red))),
        ),
      );

  Widget _buildSubmitButton() => GestureDetector(
        onTap: _isLoading ? null : _onSubmit,
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(color: _isLoading ? Colors.grey.shade400 : const Color(0xFF1A3E6F), shape: BoxShape.circle),
          child: const Center(child: Icon(Icons.check, size: 32, color: Colors.white)),
        ),
      );
}

// ==================== MAIN HOME SCREEN ====================
class DashenBankHomePage extends StatefulWidget {
  const DashenBankHomePage({super.key});

  @override
  State<DashenBankHomePage> createState() => _DashenBankHomePageState();
}

class _DashenBankHomePageState extends State<DashenBankHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const AppsScreen(),
    const TransactionScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1A3E6F),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.apps_outlined), label: 'Apps'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Transaction'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==================== HOME SCREEN ====================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBalanceVisible = false;
  bool _isAccountVisible = false;
  final String _accountNumber = '1000123456789';
  final String _balance = 'ETB 25,450.75';

  void _copyToClipboard(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateToService(String title, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Hello Seid', style: TextStyle(fontSize: 14)),
            Text('Welcome Back!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1A3E6F), Color(0xFF2C5282)]),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(radius: 30, backgroundColor: Colors.white24, child: Icon(Icons.person, size: 35, color: Colors.white)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Sheerik', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text('SEID MOHAMMED SEID', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_isAccountVisible ? _accountNumber : '**************', style: const TextStyle(color: Colors.white60, fontSize: 16)),
                      GestureDetector(
                        onTap: () {
                          if (_isAccountVisible) {
                            _copyToClipboard(_accountNumber, 'Account number copied!');
                          } else {
                            setState(() => _isAccountVisible = true);
                          }
                        },
                        child: Icon(_isAccountVisible ? Icons.copy : Icons.visibility, size: 20, color: Colors.white60),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_isBalanceVisible ? _balance : '******', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () => setState(() => _isBalanceVisible = !_isBalanceVisible),
                        child: Icon(_isBalanceVisible ? Icons.visibility : Icons.visibility_off, size: 22, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Quick Actuins', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: Color(0xFF1A3E6F)))),
              ],
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              childAspectRatio: 0.9,
              children: [
                _buildServiceItem(Icons.account_balance_wallet, 'Send To\nDashen', () => _navigateToService('Send to Dashen', const SendToDashenScreen())),
                _buildServiceItem(Icons.compare_arrows, 'Send To\nOther (IPS)', () => _navigateToService('Send to Other Bank', const SendToOtherBankScreen())),
                _buildServiceItem(Icons.account_balance_wallet_outlined, 'Send To\nWallet', () => _navigateToService('Send to Wallet', const SendToWalletScreen())),
                _buildServiceItem(Icons.business_center, 'Micro\nFinance', () => _navigateToService('Micro Finance', const MicroFinanceScreen())),
                _buildServiceItem(Icons.phone_android, 'Mobile\nTop-up', () => _navigateToService('Mobile Top-up', const MobileTopUpScreen())),
                _buildServiceItem(Icons.receipt, 'Bill\nPayments', () => _navigateToService('Bill Payments', const BillPaymentScreen())),
                _buildServiceItem(Icons.local_activity, 'Ethio\nAirline', () => _navigateToService('Ethiopian Airlines', const EthiopianAirlinesScreen())),
                _buildServiceItem(Icons.more_horiz, 'See\nMore', () {}),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('3 Click e-commerce', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: Color(0xFF1A3E6F)))),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildProductCard('Honey Natural Gold', Icons.bolt, Colors.amber),
                  _buildProductCard('Dubai Chocolate', Icons.cake, Colors.brown),
                  _buildProductCard('Coffee Premium Coffee', Icons.coffee, Colors.brown),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(IconData icon, String label, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF0F4F8), borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: const Color(0xFF1A3E6F), size: 28)),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
          ],
        ),
      );

  Widget _buildProductCard(String title, IconData icon, Color color) => Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 100, decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: const BorderRadius.vertical(top: Radius.circular(16))), child: Center(child: Icon(icon, size: 50, color: color))),
            Padding(padding: const EdgeInsets.all(8), child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
          ],
        ),
      );
}

// ==================== SEND TO DASHEN SCREEN ====================
class SendToDashenScreen extends StatelessWidget {
  const SendToDashenScreen({super.key});

  void _showAmountDialog(BuildContext context, String name) {
    final amountController = TextEditingController();
    final referenceController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Send to $name'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount (ETB)', prefixText: 'ETB '),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: referenceController,
              decoration: const InputDecoration(labelText: 'Reference (Optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transfer initiated successfully!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A3E6F)),
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send To Dashen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildContactCard(context, 'Seid Mohammed', '1000123456789', Icons.person),
            _buildContactCard(context, 'Almaz Bekele', '1000876543210', Icons.person),
            _buildContactCard(context, 'Tigist Worku', '1000567891234', Icons.person),
            _buildContactCard(context, 'Abebe Kebede', '1000987654321', Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, String name, String account, IconData icon) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: CircleAvatar(backgroundColor: const Color(0xFF1A3E6F).withOpacity(0.1), child: Icon(icon, color: const Color(0xFF1A3E6F))),
          title: Text(name),
          subtitle: Text(account),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showAmountDialog(context, name),
        ),
      );
}

// ==================== SEND TO OTHER BANK (IPS) ====================
class SendToOtherBankScreen extends StatelessWidget {
  const SendToOtherBankScreen({super.key});

  final List<Map<String, dynamic>> banks = const [
    {'name': 'Commercial Bank of Ethiopia', 'icon': Icons.account_balance, 'color': 0xFF1B5E20},
    {'name': 'Awash Bank', 'icon': Icons.account_balance, 'color': 0xFFE65100},
    {'name': 'United Bank', 'icon': Icons.account_balance, 'color': 0xFF0D47A1},
    {'name': 'Nib International Bank', 'icon': Icons.account_balance, 'color': 0xFF4A148C},
    {'name': 'Wegagen Bank', 'icon': Icons.account_balance, 'color': 0xFFB71C1C},
    {'name': 'Oromia Bank', 'icon': Icons.account_balance, 'color': 0xFF004D40},
    {'name': 'Zemen Bank', 'icon': Icons.account_balance, 'color': 0xFF1A237E},
    {'name': 'Berhan Bank', 'icon': Icons.account_balance, 'color': 0xFF3E2723},
  ];

  void _showTransferDialog(BuildContext context, String bankName) {
    final accountController = TextEditingController();
    final amountController = TextEditingController();
    final referenceController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Transfer to $bankName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: accountController,
              decoration: const InputDecoration(labelText: 'Account Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount (ETB)', prefixText: 'ETB '),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: referenceController,
              decoration: const InputDecoration(labelText: 'Reference (Optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transfer to $bankName initiated!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A3E6F)),
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send To Other Bank (IPS)')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.6, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: banks.length,
        itemBuilder: (context, index) => _buildBankCard(context, banks[index]),
      ),
    );
  }

  Widget _buildBankCard(BuildContext context, Map<String, dynamic> bank) => GestureDetector(
        onTap: () => _showTransferDialog(context, bank['name']),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Color(bank['color']).withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(bank['icon'], size: 40, color: Color(bank['color'])),
              ),
              const SizedBox(height: 12),
              Text(bank['name'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      );
}

// ==================== SEND TO WALLET (TeleBirr, M-Pesa) ====================
class SendToWalletScreen extends StatelessWidget {
  const SendToWalletScreen({super.key});

  final List<Map<String, dynamic>> wallets = const [
    {'name': 'TeleBirr', 'icon': Icons.phone_android, 'color': 0xFF1A3E6F, 'description': 'Ethio Telecom Mobile Money'},
    {'name': 'M-Pesa', 'icon': Icons.phone_iphone, 'color': 0xFFE30000, 'description': 'Safaricom Mobile Money'},
  ];

  void _showWalletTransferDialog(BuildContext context, String walletName) {
    final phoneController = TextEditingController();
    final amountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Send to $walletName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount (ETB)', prefixText: 'ETB '),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Money sent via $walletName!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A3E6F)),
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send To Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...wallets.map((wallet) => _buildWalletCard(context, wallet)),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletCard(BuildContext context, Map<String, dynamic> wallet) => Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Color(wallet['color']).withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(wallet['icon'], size: 32, color: Color(wallet['color'])),
          ),
          title: Text(wallet['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          subtitle: Text(wallet['description']),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showWalletTransferDialog(context, wallet['name']),
        ),
      );
}

// ==================== MOBILE TOP-UP ====================
class MobileTopUpScreen extends StatelessWidget {
  const MobileTopUpScreen({super.key});

  final List<Map<String, dynamic>> providers = const [
    {'name': 'Ethio Telecom', 'icon': Icons.signal_cellular_alt, 'color': 0xFF00A651, 'prefix': '09', 'description': 'Prepaid & Postpaid'},
    {'name': 'Safaricom', 'icon': Icons.network_cell, 'color': 0xFFE30000, 'prefix': '07', 'description': 'M-Pesa & Voice Plans'},
  ];

  void _showTopUpDialog(BuildContext context, String provider, String prefix) {
    final phoneController = TextEditingController();
    final amountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('$provider Top-up'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number ($prefix********)'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount (ETB)', prefixText: 'ETB '),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ETB loaded on $provider!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A3E6F)),
            child: const Text('Top Up'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Top-up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...providers.map((provider) => _buildProviderCard(context, provider)),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderCard(BuildContext context, Map<String, dynamic> provider) => Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Color(provider['color']).withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(provider['icon'], size: 32, color: Color(provider['color'])),
          ),
          title: Text(provider['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          subtitle: Text(provider['description']),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showTopUpDialog(context, provider['name'], provider['prefix']),
        ),
      );
}

// ==================== BILL PAYMENT ====================
class BillPaymentScreen extends StatelessWidget {
  const BillPaymentScreen({super.key});

  final List<Map<String, dynamic>> bills = const [
    {'name': 'Electricity Bill', 'icon': Icons.electrical_services, 'color': 0xFFFFA000},
    {'name': 'Water Bill', 'icon': Icons.water_drop, 'color': 0xFF0288D1},
    {'name': 'Internet Bill', 'icon': Icons.wifi, 'color': 0xFF7B1FA2},
    {'name': 'TV Subscription', 'icon': Icons.tv, 'color': 0xFFD32F2F},
    {'name': 'Education Fee', 'icon': Icons.school, 'color': 0xFF388E3C},
    {'name': 'Property Tax', 'icon': Icons.home_work, 'color': 0xFF5D4037},
  ];

  void _showBillPaymentDialog(BuildContext context, String billName) {
    final accountController = TextEditingController();
    final amountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Pay $billName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: accountController,
              decoration: InputDecoration(labelText: '$billName Account Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount (ETB)', prefixText: 'ETB '),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$billName paid successfully!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A3E6F)),
            child: const Text('Pay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bill Payments')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.6, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: bills.length,
        itemBuilder: (context, index) => _buildBillCard(context, bills[index]),
      ),
    );
  }

  Widget _buildBillCard(BuildContext context, Map<String, dynamic> bill) => GestureDetector(
        onTap: () => _showBillPaymentDialog(context, bill['name']),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Color(bill['color']).withOpacity(0.1), shape: BoxShape.circle), child: Icon(bill['icon'], size: 40, color: Color(bill['color']))),
              const SizedBox(height: 12),
              Text(bill['name'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      );
}

// ==================== ETHIOPIAN AIRLINES ====================
class EthiopianAirlinesScreen extends StatelessWidget {
  const EthiopianAirlinesScreen({super.key});

  void _showFlightSearch(BuildContext context) {
    final fromController = TextEditingController(text: 'Addis Ababa (ADD)');
    final toController = TextEditingController();
    final dateController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Search Flights'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fromController,
              decoration: const InputDecoration(labelText: 'From'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: toController,
              decoration: const InputDecoration(labelText: 'To'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Departure Date', hintText: 'Select Date'),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  dateController.text = '${date.day}/${date.month}/${date.year}';
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showMessage(context, 'Searching flights...');
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A3E6F)),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ethiopian Airlines')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1A3E6F), Color(0xFF0D47A1)]), borderRadius: BorderRadius.circular(20)),
              child: const Column(
                children: [
                  Icon(Icons.flight_takeoff, size: 60, color: Colors.white),
                  SizedBox(height: 12),
                  Text('Ethiopian Airlines', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('ShebaMiles Partner', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildMenuItem(context, Icons.search, 'Search Flights', () => _showFlightSearch(context)),
            _buildMenuItem(context, Icons.local_activity, 'Check-in', () => _showMessage(context, 'Check-in feature coming soon')),
            _buildMenuItem(context, Icons.history, 'Booking History', () => _showMessage(context, 'Booking history coming soon')),
            _buildMenuItem(context, Icons.card_travel, 'ShebaMiles', () => _showMessage(context, 'ShebaMiles feature coming soon')),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(leading: Icon(icon, color: const Color(0xFF1A3E6F)), title: Text(title), trailing: const Icon(Icons.chevron_right), onTap: onTap),
      );
}

// ==================== MICRO FINANCE ====================
class MicroFinanceScreen extends StatelessWidget {
  const MicroFinanceScreen({super.key});

  final List<Map<String, dynamic>> microFinanceOptions = const [
    {'name': 'WASASA Microfinance', 'icon': Icons.account_balance, 'color': 0xFF2E7D32, 'interest': '12%', 'maxLoan': '50,000 ETB'},
    {'name': 'Vision Fund', 'icon': Icons.visibility, 'color': 0xFF1565C0, 'interest': '15%', 'maxLoan': '100,000 ETB'},
    {'name': 'Amhara Credit', 'icon': Icons.credit_card, 'color': 0xFF6A1B9A, 'interest': '10%', 'maxLoan': '75,000 ETB'},
    {'name': 'Oromia Microfinance', 'icon': Icons.people, 'color': 0xFFE65100, 'interest': '13%', 'maxLoan': '60,000 ETB'},
    {'name': 'Specialized MFI', 'icon': Icons.business, 'color': 0xFFC2185B, 'interest': '11%', 'maxLoan': '80,000 ETB'},
    {'name': 'PEACE MFI', 'icon': Icons.favorite, 'color': 0xFF00897B, 'interest': '9%', 'maxLoan': '45,000 ETB'},
  ];

  void _showLoanDialog(BuildContext context, Map<String, dynamic> mfi) {
    final amountController = TextEditingController();
    final durationController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Apply for Loan - ${mfi['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Interest Rate: ${mfi['interest']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Maximum Loan: ${mfi['maxLoan']}'),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Loan Amount (ETB)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(labelText: 'Duration (Months)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Loan application submitted to ${mfi['name']}!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A3E6F)),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Micro Finance')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.6, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: microFinanceOptions.length,
        itemBuilder: (context, index) => _buildMFICard(context, microFinanceOptions[index]),
      ),
    );
  }

  Widget _buildMFICard(BuildContext context, Map<String, dynamic> mfi) => GestureDetector(
        onTap: () => _showLoanDialog(context, mfi),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Color(mfi['color']).withOpacity(0.1), shape: BoxShape.circle), child: Icon(mfi['icon'], size: 40, color: Color(mfi['color']))),
              const SizedBox(height: 12),
              Text(mfi['name'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text('Interest: ${mfi['interest']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
              Text('Max: ${mfi['maxLoan']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
      );
}

// ==================== OTHER SCREENS ====================
class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apps')),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 3,
        children: [
          _buildAppItem(Icons.send, 'Send Money'),
          _buildAppItem(Icons.qr_code_scanner, 'Scan & Pay'),
          _buildAppItem(Icons.phone_android, 'Mobile Top-up'),
          _buildAppItem(Icons.receipt, 'Bill Payment'),
          _buildAppItem(Icons.shopping_bag, 'Merchant Pay'),
          _buildAppItem(Icons.trending_up, 'Micro Finance'),
        ],
      ),
    );
  }

  Widget _buildAppItem(IconData icon, String label) => Column(
        children: [
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFF0F4F8), borderRadius: BorderRadius.circular(20)), child: Icon(icon, color: const Color(0xFF1A3E6F), size: 32)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
}

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTransactionItem('Mobile Top-up', '+251912345678', 'ETB 150.00', 'Today', Icons.phone_android),
          _buildTransactionItem('Bill Payment', 'Electricity Bill', 'ETB 850.00', 'Yesterday', Icons.electrical_services),
          _buildTransactionItem('Send Money', 'To: Seid Mohammed', 'ETB 2,000.00', 'Dec 12, 2024', Icons.send),
          _buildTransactionItem('Merchant Payment', 'Coffee Shop', 'ETB 45.00', 'Dec 10, 2024', Icons.store),
          _buildTransactionItem('Receive Money', 'From: Work Salary', '+ETB 15,000.00', 'Dec 5, 2024', Icons.download),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String subtitle, String amount, String date, IconData icon) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: CircleAvatar(backgroundColor: const Color(0xFF1A3E6F).withOpacity(0.1), child: Icon(icon, color: const Color(0xFF1A3E6F))),
          title: Text(title),
          subtitle: Text('$subtitle\n$date'),
          trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold, color: amount.contains('+') ? Colors.green : Colors.black)),
        ),
      );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Color(0xFF1A3E6F), child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 20),
            const Text('Seid Mohammed Seid', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('seid@dashenbank.com', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PinLoginScreen())),
            ),
          ],
        ),
      ),
    );
  }
}