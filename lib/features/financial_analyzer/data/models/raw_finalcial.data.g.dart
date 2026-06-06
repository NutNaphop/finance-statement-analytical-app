// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_finalcial.data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RawFinancialDataAdapter extends TypeAdapter<RawFinancialData> {
  @override
  final typeId = 0;

  @override
  RawFinancialData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RawFinancialData(
      companyName: fields[0] as String,
      industrySector: fields[1] as String,
      year: (fields[2] as num).toInt(),
      currentAssets: (fields[3] as num).toDouble(),
      currentLiabilities: (fields[4] as num).toDouble(),
      cashAndEquivalents: (fields[5] as num).toDouble(),
      inventory: (fields[6] as num).toDouble(),
      accountsReceivable: (fields[7] as num).toDouble(),
      accountsPayable: (fields[8] as num).toDouble(),
      totalAssets: (fields[9] as num).toDouble(),
      totalEquity: (fields[10] as num).toDouble(),
      sharesOutstanding: (fields[11] as num).toDouble(),
      revenue: (fields[12] as num).toDouble(),
      costOfGoodsSold: (fields[13] as num).toDouble(),
      grossProfit: (fields[14] as num).toDouble(),
      operatingIncome: (fields[15] as num).toDouble(),
      netIncome: (fields[16] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, RawFinancialData obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.companyName)
      ..writeByte(1)
      ..write(obj.industrySector)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.currentAssets)
      ..writeByte(4)
      ..write(obj.currentLiabilities)
      ..writeByte(5)
      ..write(obj.cashAndEquivalents)
      ..writeByte(6)
      ..write(obj.inventory)
      ..writeByte(7)
      ..write(obj.accountsReceivable)
      ..writeByte(8)
      ..write(obj.accountsPayable)
      ..writeByte(9)
      ..write(obj.totalAssets)
      ..writeByte(10)
      ..write(obj.totalEquity)
      ..writeByte(11)
      ..write(obj.sharesOutstanding)
      ..writeByte(12)
      ..write(obj.revenue)
      ..writeByte(13)
      ..write(obj.costOfGoodsSold)
      ..writeByte(14)
      ..write(obj.grossProfit)
      ..writeByte(15)
      ..write(obj.operatingIncome)
      ..writeByte(16)
      ..write(obj.netIncome);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RawFinancialDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
