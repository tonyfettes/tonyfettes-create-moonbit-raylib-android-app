///|
/// Decode a base64 string to bytes, skipping whitespace
fn base64_decode(input : String) -> Bytes {
  let table : FixedArray[Int] = FixedArray::make(256, -1)
  let chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  for i, ch in chars {
    table[ch.to_int()] = i
  }
  table['='.to_int()] = 0
  // First pass: count valid base64 characters
  let mut count = 0
  for ch in input {
    if table[ch.to_int()] >= 0 || ch == '=' {
      count += 1
    }
  }
  // Allocate output buffer
  let out_len = count / 4 * 3
  let out = FixedArray::make(out_len, b'\x00')
  let mut buf : UInt = 0U
  let mut bits = 0
  let mut pos = 0
  let mut padding = 0
  for ch in input {
    let val = table[ch.to_int()]
    if ch == '=' {
      padding += 1
      buf = buf << 6
      bits += 6
    } else if val >= 0 {
      buf = (buf << 6) | val.reinterpret_as_uint()
      bits += 6
    } else {
      continue
    }
    if bits == 24 {
      out[pos] = ((buf >> 16) & 0xFFU).to_byte()
      out[pos + 1] = ((buf >> 8) & 0xFFU).to_byte()
      out[pos + 2] = (buf & 0xFFU).to_byte()
      pos += 3
      buf = 0U
      bits = 0
    }
  }
  let final_len = pos - padding
  let result = FixedArray::make(final_len, b'\x00')
  for i in 0..<final_len {
    result[i] = out[i]
  }
  Bytes::from_array(result)
}
