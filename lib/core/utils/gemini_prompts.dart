// คีย์สำหรับบอกคำสั่งกับ Gemini (System Instruction / Prompt)
const String kFinancialAnalysisPrompt =
    "Extract all raw financial statement values for the specified company. "
    "Focus on the Balance Sheet (งบแสดงฐานะการเงิน) and Income Statement (งบกำไรขาดทุนเบ็ดเสร็จ). "
    "Make sure to clean the numbers (remove commas, spaces) and convert them to numeric values. "
    "If a specific value is missing or not present in the PDF, return 0.0.";

const Map<String, dynamic> kFinancialResponseSchema = {
  "type": "OBJECT",
  "properties": {
    "companyName": {"type": "STRING", "description": "ชื่อบริษัท/ชื่อกิจการ"},
    "industrySector": {
      "type": "STRING",
      "description": "กลุ่มประเภทอุตสาหกรรม/กลุ่มธุรกิจ"
    },
    "year": {
      "type": "INTEGER",
      "description": "ปีของงบการเงินที่วิเคราะห์ เช่น 2025"
    },

    // งบแสดงฐานะการเงิน (Balance Sheet)
    "currentAssets": {"type": "NUMBER", "description": "สินทรัพย์หมุนเวียนรวม"},
    "currentLiabilities": {
      "type": "NUMBER",
      "description": "หนี้สินหมุนเวียนรวม"
    },
    "cashAndEquivalents": {
      "type": "NUMBER",
      "description": "เงินสดและรายการเทียบเท่าเงินสด"
    },
    "inventory": {"type": "NUMBER", "description": "สินค้าคงเหลือ"},
    "accountsReceivable": {
      "type": "NUMBER",
      "description": "ลูกหนี้การค้าและลูกหนี้อื่น"
    },
    "accountsPayable": {
      "type": "NUMBER",
      "description": "เจ้าหนี้การค้าและเจ้าหนี้อื่น"
    },
    "totalAssets": {"type": "NUMBER", "description": "สินทรัพย์รวม"},
    "totalEquity": {"type": "NUMBER", "description": "ส่วนของผู้ถือหุ้นรวม"},
    "sharesOutstanding": {
      "type": "NUMBER",
      "description": "จำนวนหุ้นที่ออกและชำระเต็มมูลค่าแล้ว"
    },

    // งบกำไรขาดทุน (Income Statement)
    "revenue": {
      "type": "NUMBER",
      "description": "รายได้จากการขายหรือการให้บริการ"
    },
    "costOfGoodsSold": {
      "type": "NUMBER",
      "description": "ต้นทุนขายหรือต้นทุนการให้บริการ"
    },
    "grossProfit": {"type": "NUMBER", "description": "กำไรขั้นต้น"},
    "operatingIncome": {
      "type": "NUMBER",
      "description": "กำไรจากการดำเนินงาน (EBIT)"
    },
    "netIncome": {"type": "NUMBER", "description": "กำไรสุทธิประจำปี"}
  },
  "required": [
    "companyName",
    "industrySector",
    "year",
    "currentAssets",
    "currentLiabilities",
    "netIncome"
  ]
};
