import 'package:hive_ce/hive.dart';
part 'raw_finalcial.data.g.dart';

@HiveType(typeId: 0)
class RawFinancialData {
  @HiveField(0)
  final String companyName;

  @HiveField(1)
  final String industrySector;

  @HiveField(2)
  final int year;

  // 1. ตัวเลขจากงบแสดงฐานะการเงิน (Balance Sheet)
  @HiveField(3)
  final double currentAssets; // สินทรัพย์หมุนเวียน

  @HiveField(4)
  final double currentLiabilities; // หนี้สินหมุนเวียน

  @HiveField(5)
  final double cashAndEquivalents; // เงินสดและรายการเทียบเท่าเงินสด

  @HiveField(6)
  final double inventory; // สินค้าคงเหลือ

  @HiveField(7)
  final double accountsReceivable; // ลูกหนี้การค้า

  @HiveField(8)
  final double accountsPayable; // เจ้าหนี้การค้า

  @HiveField(9)
  final double totalAssets; // สินทรัพย์รวม

  @HiveField(10)
  final double totalEquity; // ส่วนของผู้ถือหุ้นรวม

  @HiveField(11)
  final double sharesOutstanding; // จำนวนหุ้นที่จดทะเบียนชำระแล้ว

  // 2. ตัวเลขจากงบกำไรขาดทุนเบ็ดเสร็จ (Income Statement)
  @HiveField(12)
  final double revenue; // รายได้จากการขาย/บริการ

  @HiveField(13)
  final double costOfGoodsSold; // ต้นทุนขาย/บริการ

  @HiveField(14)
  final double grossProfit; // กำไรขั้นต้น

  @HiveField(15)
  final double operatingIncome; // กำไรจากการดำเนินงาน (EBIT)

  @HiveField(16)
  final double netIncome; // กำไรสุทธิ

  const RawFinancialData({
    required this.companyName,
    required this.industrySector,
    required this.year,
    required this.currentAssets,
    required this.currentLiabilities,
    required this.cashAndEquivalents,
    required this.inventory,
    required this.accountsReceivable,
    required this.accountsPayable,
    required this.totalAssets,
    required this.totalEquity,
    required this.sharesOutstanding,
    required this.revenue,
    required this.costOfGoodsSold,
    required this.grossProfit,
    required this.operatingIncome,
    required this.netIncome,
  });

  // ฟังก์ชันสกัดข้อมูลจาก JSON ที่ตอบกลับมาจาก Gemini API
  factory RawFinancialData.fromJson(Map<String, dynamic> json) {
    // ฟังก์ชันช่วยแปลงข้อมูลที่อาจมาเป็น String หรือ Number ให้เป็น double อย่างปลอดภัย
    double toDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) {
        // ลบลูกน้ำและช่องว่างออกก่อนแปลง
        final cleaned = value.replaceAll(',', '').trim();
        return double.tryParse(cleaned) ?? 0.0;
      }
      return 0.0;
    }

    return RawFinancialData(
      companyName: json['companyName'] as String? ?? '',
      industrySector: json['industrySector'] as String? ?? '',
      year: json['year'] as int? ?? DateTime.now().year,
      currentAssets: toDouble(json['currentAssets']),
      currentLiabilities: toDouble(json['currentLiabilities']),
      cashAndEquivalents: toDouble(json['cashAndEquivalents']),
      inventory: toDouble(json['inventory']),
      accountsReceivable: toDouble(json['accountsReceivable']),
      accountsPayable: toDouble(json['accountsPayable']),
      totalAssets: toDouble(json['totalAssets']),
      totalEquity: toDouble(json['totalEquity']),
      sharesOutstanding: toDouble(json['sharesOutstanding']),
      revenue: toDouble(json['revenue']),
      costOfGoodsSold: toDouble(json['costOfGoodsSold']),
      grossProfit: toDouble(json['grossProfit']),
      operatingIncome: toDouble(json['operatingIncome']),
      netIncome: toDouble(json['netIncome']),
    );
  }

  // แปลงกลับเป็น Map (สำหรับกรณีที่อยากบันทึกดิบเก็บไว้)
  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'industrySector': industrySector,
      'year': year,
      'currentAssets': currentAssets,
      'currentLiabilities': currentLiabilities,
      'cashAndEquivalents': cashAndEquivalents,
      'inventory': inventory,
      'accountsReceivable': accountsReceivable,
      'accountsPayable': accountsPayable,
      'totalAssets': totalAssets,
      'totalEquity': totalEquity,
      'sharesOutstanding': sharesOutstanding,
      'revenue': revenue,
      'costOfGoodsSold': costOfGoodsSold,
      'grossProfit': grossProfit,
      'operatingIncome': operatingIncome,
      'netIncome': netIncome,
    };
  }
}
