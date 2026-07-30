import 'package:flutter/material.dart';

void main() {
  runApp(const FinancasApp());
}

class FinancasApp extends StatelessWidget {
  const FinancasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finanças',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF560C87)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

// ── Data models ──────────────────────────────────────────────────────────────

enum TransactionType { income, expense }

class Transaction {
  final String title;
  final String date;
  final double amount;
  final TransactionType type;
  final IconData icon;
  final Color iconColor;

  const Transaction({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.icon,
    required this.iconColor,
  });
}

// ── Screens ──────────────────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Transaction> _transactions = [
    Transaction(
      title: 'Salário',
      date: '05/07/2026',
      amount: 5200.00,
      type: TransactionType.income,
      icon: Icons.attach_money,
      iconColor: Color(0xFF4CAF50),
    ),
    Transaction(
      title: 'Aluguel',
      date: '08/07/2026',
      amount: 1500.00,
      type: TransactionType.expense,
      icon: Icons.home_outlined,
      iconColor: Color(0xFFFF5722),
    ),
    Transaction(
      title: 'Supermercado',
      date: '09/07/2026',
      amount: 320.50,
      type: TransactionType.expense,
      icon: Icons.shopping_cart_outlined,
      iconColor: Color(0xFFFF9800),
    ),
    Transaction(
      title: 'Internet',
      date: '10/07/2026',
      amount: 99.90,
      type: TransactionType.expense,
      icon: Icons.wifi,
      iconColor: Color(0xFF2196F3),
    ),
    Transaction(
      title: 'Combustível',
      date: '12/07/2026',
      amount: 200.00,
      type: TransactionType.expense,
      icon: Icons.local_gas_station_outlined,
      iconColor: Color(0xFF9C27B0),
    ),
    Transaction(
      title: 'Restaurante',
      date: '16/07/2026',
      amount: 150.00,
      type: TransactionType.expense,
      icon: Icons.restaurant_outlined,
      iconColor: Color(0xFFE91E63),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF560C87),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const Text(
          'Finanças',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.tune)),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _selectedIndex == 0 ? _buildBody() : _buildPlaceholder(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Drawer ────────────────────────────────────────────────────────────────

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF560C87), Color(0xFF6E22C9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Rian Rafael',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'rianrafael063@gmail.com',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),

          // Balance chip
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF560C87).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF560C87),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo atual',
                      style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'R\$ 2.350,00',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          const Divider(indent: 20, endIndent: 20, color: Color(0xFFF0F0F0)),
          const SizedBox(height: 4),

          // Menu items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.home_outlined,
                  label: 'Início',
                  isActive: _selectedIndex == 0,
                  onTap: () {
                    setState(() => _selectedIndex = 0);
                    Navigator.pop(context);
                  },
                ),
                _DrawerItem(
                  icon: Icons.swap_horiz,
                  label: 'Transações',
                  isActive: _selectedIndex == 1,
                  onTap: () {
                    setState(() => _selectedIndex = 1);
                    Navigator.pop(context);
                  },
                ),
                _DrawerItem(
                  icon: Icons.grid_view_outlined,
                  label: 'Categorias',
                  isActive: _selectedIndex == 2,
                  onTap: () {
                    setState(() => _selectedIndex = 2);
                    Navigator.pop(context);
                  },
                ),
                _DrawerItem(
                  icon: Icons.bar_chart_outlined,
                  label: 'Relatórios',
                  isActive: _selectedIndex == 3,
                  onTap: () {
                    setState(() => _selectedIndex = 3);
                    Navigator.pop(context);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Divider(color: Color(0xFFF0F0F0)),
                ),
                _DrawerItem(
                  icon: Icons.credit_card_outlined,
                  label: 'Contas',
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  icon: Icons.flag_outlined,
                  label: 'Metas',
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  icon: Icons.notifications_outlined,
                  label: 'Notificações',
                  badge: '3',
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  label: 'Configurações',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Footer
          const Divider(indent: 20, endIndent: 20, color: Color(0xFFF0F0F0)),
          _DrawerItem(
            icon: Icons.logout,
            label: 'Sair',
            iconColor: const Color(0xFFE53935),
            labelColor: const Color(0xFFE53935),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Body ──────────────────────────────────────────────────────────────────

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 8),
          _buildTransactionsList(),
        ],
      ),
    );
  }

  // ── Summary card ──────────────────────────────────────────────────────────

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Resumo do Mês',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF212121),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Julho / 2026',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Receitas / Despesas
          Row(
            children: [
              Expanded(
                child: _buildAmountColumn(
                  label: 'Receitas',
                  amount: 'R\$ 5.200,00',
                  color: const Color(0xFF4CAF50),
                ),
              ),
              Container(width: 1, height: 48, color: const Color(0xFFEEEEEE)),
              Expanded(
                child: _buildAmountColumn(
                  label: 'Despesas',
                  amount: 'R\$ 2.850,00',
                  color: const Color(0xFFE53935),
                  align: CrossAxisAlignment.end,
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, color: Color(0xFFEEEEEE)),
          ),

          // Saldo
          const Text(
            'Saldo',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9E9E9E),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'R\$ 2.350,00',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountColumn({
    required String label,
    required String amount,
    required Color color,
    CrossAxisAlignment align = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF9E9E9E),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  // ── Transactions list ─────────────────────────────────────────────────────

  Widget _buildTransactionsList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              'Transações',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212121),
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF5F5F5)),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _transactions.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, indent: 72, color: Color(0xFFF5F5F5)),
            itemBuilder: (context, index) =>
                _TransactionTile(transaction: _transactions[index]),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── FAB ───────────────────────────────────────────────────────────────────

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: const Color(0xFF531B96),
      foregroundColor: Colors.white,
      elevation: 4,
      child: const Icon(Icons.add, size: 28),
    );
  }

  // ── Bottom nav ────────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Resumo'),
      BottomNavigationBarItem(
        icon: Icon(Icons.swap_horiz),
        label: 'Transações',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.grid_view_outlined),
        label: 'Categorias',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart_outlined),
        label: 'Relatórios',
      ),
    ];

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (i) => setState(() => _selectedIndex = i),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF531B96),
      unselectedItemColor: const Color(0xFF9E9E9E),
      selectedLabelStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      backgroundColor: Colors.white,
      elevation: 8,
      items: items,
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Text(
        'Em breve…',
        style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16),
      ),
    );
  }
}

// ── Drawer item ───────────────────────────────────────────────────────────────

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final String? badge;
  final Color? iconColor;
  final Color? labelColor;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.badge,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFF531B96);
    final resolvedIcon =
        iconColor ?? (isActive ? activeColor : const Color(0xFF616161));
    final resolvedLabel =
        labelColor ?? (isActive ? activeColor : const Color(0xFF212121));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? activeColor.withOpacity(0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        leading: Icon(icon, color: resolvedIcon, size: 22),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: resolvedLabel,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : isActive
            ? Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF531B96),
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}

// ── Transaction tile ──────────────────────────────────────────────────────────

class _TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const _TransactionTile({required this.transaction});

  String get _formattedAmount {
    final prefix = transaction.type == TransactionType.income ? '+' : '-';
    final value = transaction.amount.toStringAsFixed(2).replaceAll('.', ',');
    return '$prefix R\$ $value';
  }

  Color get _amountColor => transaction.type == TransactionType.income
      ? const Color(0xFF4CAF50)
      : const Color(0xFFE53935);

  IconData get _arrowIcon => transaction.type == TransactionType.income
      ? Icons.arrow_upward
      : Icons.arrow_downward;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: transaction.iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              transaction.icon,
              color: transaction.iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),

          // Title + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  transaction.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),

          // Amount + arrow
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formattedAmount,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _amountColor,
                ),
              ),
              const SizedBox(height: 2),
              Icon(_arrowIcon, color: _amountColor, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}