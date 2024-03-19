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

module.exports = formatDate