function formatDate(date) {
  const pad = (num) => num.toString().padStart(2, '0');

  const day = pad(date.getDate());
  const month = pad(date.getMonth() + 1); // Note: months are 0-indexed

  let year = date.getFullYear();
  if (year < 2500) {
    year += 543;
  }
  const hours = pad(date.getHours());
  const minutes = pad(date.getMinutes());
  const seconds = pad(date.getSeconds());

  return `${day}/${month}/${year} ${hours}:${minutes}:${seconds}`;
}

let anonymouseNames = ['ช้างนิรนาม',
  'สิงโตนิรนาม',
  'เสือนิรนาม',
  'หมีนิรนาม',
  'ยีราฟนิรนาม',
  'ม้าลายนิรนาม',
  'จิงโจ้นิรนาม',
  'โคอาลานิรนาม',
  'ฮิปโปนิรนาม',
  'แรดนิรนาม',
  'แพนด้านิรนาม',
  'กอริลล่านิรนาม',
  'ชิมแพนซีนิรนาม',
  'หมาป่านิรนาม',
  'สุนัขจิ้งจอกนิรนาม',
  'กวางนิรนาม',
  'แรคคูนนิรนาม',
  'กระรอกนิรนาม',
  'กระต่ายนิรนาม',
  'สกังค์นิรนาม',
  'ตัวนากนิรนาม',
  'บีเวอร์นิรนาม',
  'กวางมูสนิรนาม',
  'ไบสันนิรนาม',
  'ตัวนิ่มนิรนาม',
  'ชีตาห์นิรนาม',
  'ไฮยีน่านิรนาม',
  'ลีเมอร์นิรนาม',
  'สลอธนิรนาม',
  'โอพอสซั่มนิรนาม',
  'ตัวตุ่นนิรนาม',
  'แบดเจอร์นิรนาม']

module.exports = { formatDate, anonymouseNames };