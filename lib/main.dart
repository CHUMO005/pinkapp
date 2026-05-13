import 'package:flutter/material.dart';
import 'welcome.dart';
import 'reminderpage.dart';
import 'bmipage.dart';
import 'circletracker.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF48FB1)),
        useMaterial3: true,
        fontFamily: 'Nunito',
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum AuthMode { signIn, signUp, forgotPassword }

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AuthMode _mode = AuthMode.signIn;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  // Sign In
  final _signInUsernameCtrl = TextEditingController();
  final _signInPasswordCtrl = TextEditingController();
  bool _signInPasswordVisible = false;

  // Sign Up
  final _signUpUsernameCtrl = TextEditingController();
  final _signUpEmailCtrl = TextEditingController();
  final _signUpPasswordCtrl = TextEditingController();
  final _signUpConfirmCtrl = TextEditingController();
  bool _signUpPasswordVisible = false;
  bool _signUpConfirmVisible = false;

  // Forgot Password
  final _forgotEmailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _signInUsernameCtrl.dispose();
    _signInPasswordCtrl.dispose();
    _signUpUsernameCtrl.dispose();
    _signUpEmailCtrl.dispose();
    _signUpPasswordCtrl.dispose();
    _signUpConfirmCtrl.dispose();
    _forgotEmailCtrl.dispose();
    super.dispose();
  }

  void _switchMode(AuthMode mode) {
    _animController.reset();
    setState(() => _mode = mode);
    _animController.forward();
  }

  static const Color _pink = Color(0xFFF06292);
  static const Color _lightPink = Color(0xFFFCE4EC);
  static const Color _deepPink = Color(0xFFE91E8C);
  static const Color _softPink = Color(0xFFF8BBD0);
  static const Color _cardBg = Color(0xFFFFFFFF);
  static const Color _textDark = Color(0xFF4A2040);
  static const Color _textMuted = Color(0xFFAD7090);

  InputDecoration _inputDecor(String label, IconData icon,
      {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: _textMuted, fontSize: 14),
      prefixIcon: Icon(icon, color: _pink, size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFFFFF0F5),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _softPink, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _pink, width: 1.8),
      ),
    );
  }

  Widget _buildSignIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _signInUsernameCtrl,
          decoration: _inputDecor('Username', Icons.person_outline),
          style: const TextStyle(color: _textDark),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _signInPasswordCtrl,
          obscureText: !_signInPasswordVisible,
          decoration: _inputDecor(
            'Password',
            Icons.lock_outline,
            suffix: IconButton(
              icon: Icon(
                _signInPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: _textMuted,
                size: 20,
              ),
              onPressed: () => setState(
                  () => _signInPasswordVisible = !_signInPasswordVisible),
            ),
          ),
          style: const TextStyle(color: _textDark),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => _switchMode(AuthMode.forgotPassword),
            style: TextButton.styleFrom(
              foregroundColor: _pink,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Forgot password?',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(height: 20),
        _PinkButton(
          label: 'Sign In',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account? ",
                style: TextStyle(color: _textMuted, fontSize: 13)),
            GestureDetector(
              onTap: () => _switchMode(AuthMode.signUp),
              child: const Text('Sign Up',
                  style: TextStyle(
                      color: _deepPink,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _signUpUsernameCtrl,
          decoration: _inputDecor('Username', Icons.person_outline),
          style: const TextStyle(color: _textDark),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _signUpEmailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecor('Email', Icons.email_outlined),
          style: const TextStyle(color: _textDark),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _signUpPasswordCtrl,
          obscureText: !_signUpPasswordVisible,
          decoration: _inputDecor(
            'Create Password',
            Icons.lock_outline,
            suffix: IconButton(
              icon: Icon(
                _signUpPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: _textMuted,
                size: 20,
              ),
              onPressed: () => setState(
                  () => _signUpPasswordVisible = !_signUpPasswordVisible),
            ),
          ),
          style: const TextStyle(color: _textDark),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _signUpConfirmCtrl,
          obscureText: !_signUpConfirmVisible,
          decoration: _inputDecor(
            'Confirm Password',
            Icons.lock_outline,
            suffix: IconButton(
              icon: Icon(
                _signUpConfirmVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: _textMuted,
                size: 20,
              ),
              onPressed: () => setState(
                  () => _signUpConfirmVisible = !_signUpConfirmVisible),
            ),
          ),
          style: const TextStyle(color: _textDark),
        ),
        const SizedBox(height: 22),
        _PinkButton(
          label: 'Create Account',
          onPressed: () => _switchMode(AuthMode.signIn),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have an account? ',
                style: TextStyle(color: _textMuted, fontSize: 13)),
            GestureDetector(
              onTap: () => _switchMode(AuthMode.signIn),
              child: const Text('Sign In',
                  style: TextStyle(
                      color: _deepPink,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Enter your email and we\'ll send you a link to reset your password.',
          style: TextStyle(color: _textMuted, fontSize: 13.5, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 22),
        TextField(
          controller: _forgotEmailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecor('Email Address', Icons.email_outlined),
          style: const TextStyle(color: _textDark),
        ),
        const SizedBox(height: 22),
        _PinkButton(
          label: 'Send Reset Link',
          onPressed: () {},
        ),
        const SizedBox(height: 20),
        Center(
          child: GestureDetector(
            onTap: () => _switchMode(AuthMode.signIn),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.arrow_back_ios_rounded, size: 13, color: _pink),
                SizedBox(width: 4),
                Text('Back to Sign In',
                    style: TextStyle(
                        color: _pink,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String get _title {
    switch (_mode) {
      case AuthMode.signIn:
        return 'Welcome Back';
      case AuthMode.signUp:
        return 'Create Account';
      case AuthMode.forgotPassword:
        return 'Reset Password';
    }
  }

  String get _subtitle {
    switch (_mode) {
      case AuthMode.signIn:
        return 'Sign in to continue';
      case AuthMode.signUp:
        return 'Join us today';
      case AuthMode.forgotPassword:
        return 'We\'ve got you covered';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightPink,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                // Logo / Icon
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: _cardBg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _pink.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.favorite_rounded,
                      color: _pink, size: 34),
                ),
                const SizedBox(height: 20),

                // Tab Row (Sign In / Sign Up)
                if (_mode != AuthMode.forgotPassword)
                  Container(
                    decoration: BoxDecoration(
                      color: _softPink,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _TabButton(
                          label: 'Sign In',
                          active: _mode == AuthMode.signIn,
                          onTap: () => _switchMode(AuthMode.signIn),
                        ),
                        _TabButton(
                          label: 'Sign Up',
                          active: _mode == AuthMode.signUp,
                          onTap: () => _switchMode(AuthMode.signUp),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 24),

                // Card
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 420),
                  decoration: BoxDecoration(
                    color: _cardBg,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: _pink.withOpacity(0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(26, 28, 26, 28),
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _subtitle,
                          style: const TextStyle(
                              color: _textMuted, fontSize: 13.5),
                        ),
                        const SizedBox(height: 24),
                        if (_mode == AuthMode.signIn) _buildSignIn(),
                        if (_mode == AuthMode.signUp) _buildSignUp(),
                        if (_mode == AuthMode.forgotPassword)
                          _buildForgotPassword(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Tab Button ─────────────────────────────────────────────────────────────

class _TabButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabButton(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding:
            const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFF06292) : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFFAD7090),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

 class _PinkButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _PinkButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF06292),
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: const Color(0xFFF06292).withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
      ),
    );
  }
}