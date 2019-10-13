module qr

import math

struct QR {
pub: mut:
  mode Mode
  raw_data string
  ecl ErrorCorrectionLevel
  version Version 
}

enum ErrorCorrectionLevel {
  L M Q H
}

enum CCIRange {
  one_to_nine ten_to_26th t27_to_40 zero
}

const (
    binaries = ['0', '1']
    bit_table = {
      'numeric': [10, 12, 14],
      'alphanumeric': [9, 11, 13],
      'binary': [8, 16, 16],
      'kanji': [8, 10, 12]
    }
    table = {
      'numeric': [
        [
          41,
          77,
          127,
          187,
          255,
          322,
          370,
          461,
          552,
          652,
          772,
          883,
          1022,
          1101,
          1250,
          1408,
          1548,
          1725,
          1903,
          2061,
          2232,
          2409,
          2620,
          2812,
          3057,
          3283,
          3517,
          3669,
          3909,
          4158,
          4417,
          4686,
          4965,
          5253,
          5529,
          5836,
          6153,
          6479,
          6743,
          7089
        ],
        [
          34,
          63,
          101,
          149,
          202,
          255,
          293,
          365,
          432,
          513,
          604,
          691,
          796,
          871,
          991,
          1082,
          1212,
          1346,
          1500,
          1600,
          1708,
          1872,
          2059,
          2188,
          2395,
          2544,
          2701,
          2857,
          3035,
          3289,
          3486,
          3693,
          3909,
          4134,
          4343,
          4588,
          4775,
          5039,
          5313,
          5596
        ],
        [
          27,
          48,
          77,
          111,
          144,
          178,
          207,
          259,
          312,
          364,
          427,
          489,
          580,
          621,
          703,
          775,
          876,
          948,
          1063,
          1159,
          1224,
          1358,
          1468,
          1588,
          1718,
          1804,
          1933,
          2085,
          2181,
          2358,
          2473,
          2670,
          2805,
          2949,
          3081,
          3244,
          3417,
          3599,
          3791,
          3993
        ]
      ],
      'alphanumeric': [
        [
          25,
          47,
          77,
          114,
          154,
          195,
          224,
          279,
          335,
          395,
          468,
          535,
          619,
          667,
          758,
          854,
          938,
          1046,
          1153,
          1249,
          1352,
          1460,
          1588,
          1704,
          1853,
          1990,
          2132,
          2223,
          2369,
          2520,
          2677,
          2840,
          3009,
          3183,
          3351,
          3537,
          3729,
          3927,
          4087,
          4296
        ],
        [
          20,
          38,
          61,
          90,
          122,
          154,
          178,
          221,
          262,
          311,
          366,
          419,
          483,
          528,
          600,
          656,
          734,
          816,
          909,
          970,
          1035,
          1134,
          1248,
          1326,
          1451,
          1542,
          1637,
          1732,
          1839,
          1994,
          2113,
          2238,
          2369,
          2506,
          2632,
          2780,
          2894,
          3054,
          3220,
          3391
        ],
        [
          16,
          29,
          47,
          67,
          87,
          108,
          125,
          157,
          189,
          221,
          259,
          296,
          352,
          376,
          426,
          470,
          531,
          574,
          644,
          702,
          742,
          823,
          890,
          963,
          1041,
          1094,
          1172,
          1263,
          1322,
          1429,
          1499,
          1618,
          1700,
          1787,
          1867,
          1966,
          2071,
          2181,
          2298,
          2420
        ],
        [
          10,
          20,
          35,
          50,
          64,
          84,
          93,
          122,
          143,
          174,
          200,
          227,
          259,
          283,
          321,
          365,
          408,
          452,
          493,
          557,
          587,
          640,
          672,
          744,
          779,
          864,
          910,
          958,
          1016,
          1080,
          1150,
          1226,
          1307,
          1394,
          1431,
          1530,
          1591,
          1658,
          1774,
          1852
        ]
      ],
      'binary': [
        [
          17,
          32,
          53,
          78,
          106,
          134,
          154,
          192,
          230,
          271,
          321,
          367,
          425,
          458,
          520,
          586,
          644,
          718,
          792,
          858,
          929,
          1003,
          1091,
          1171,
          1273,
          1367,
          1465,
          1528,
          1628,
          1732,
          1840,
          1952,
          2068,
          2188,
          2303,
          2431,
          2563,
          2699,
          2809,
          2953
        ],
        [
          14,
          26,
          42,
          62,
          84,
          106,
          122,
          152,
          180,
          213,
          251,
          287,
          331,
          362,
          412,
          450,
          504,
          560,
          624,
          666,
          711,
          779,
          857,
          911,
          997,
          1059,
          1125,
          1190,
          1264,
          1370,
          1452,
          1538,
          1628,
          1722,
          1809,
          1911,
          1989,
          2099,
          2213,
          2331
        ],
        [
          11,
          20,
          32,
          46,
          60,
          74,
          86,
          108,
          130,
          151,
          177,
          203,
          241,
          258,
          292,
          322,
          364,
          394,
          442,
          482,
          509,
          565,
          611,
          661,
          715,
          751,
          805,
          868,
          908,
          982,
          1030,
          1112,
          1168,
          1228,
          1283,
          1351,
          1423,
          1499,
          1579,
          1663
        ],
        [
          7,
          14,
          24,
          34,
          44,
          58,
          64,
          84,
          98,
          119,
          137,
          155,
          177,
          194,
          220,
          250,
          280,
          310,
          338,
          382,
          403,
          439,
          461,
          511,
          535,
          593,
          625,
          658,
          698,
          742,
          790,
          842,
          898,
          958,
          983,
          1051,
          1093,
          1139,
          1219,
          1273
        ]
      ],
      'kanji': [
        [
          10,
          20,
          32,
          48,
          65,
          82,
          95,
          118,
          141,
          167,
          198,
          226,
          262,
          282,
          320,
          361,
          397,
          442,
          488,
          528,
          572,
          618,
          672,
          721,
          784,
          842,
          902,
          940,
          1002,
          1066,
          1132,
          1201,
          1273,
          1347,
          1417,
          1496,
          1577,
          1661,
          1729,
          1817
        ],
        [
          8,
          16,
          26,
          38,
          52,
          65,
          75,
          93,
          111,
          131,
          155,
          177,
          204,
          223,
          254,
          277,
          310,
          345,
          384,
          410,
          438,
          480,
          528,
          561,
          614,
          652,
          692,
          732,
          778,
          843,
          894,
          947,
          1002,
          1060,
          1113,
          1176,
          1224,
          1292,
          1362,
          1435
        ],
        [
          7,
          12,
          20,
          28,
          37,
          45,
          53,
          66,
          80,
          93,
          109,
          125,
          149,
          159,
          180,
          198,
          224,
          243,
          272,
          297,
          314,
          348,
          376,
          407,
          440,
          462,
          496,
          534,
          559,
          604,
          634,
          684,
          719,
          756,
          790,
          832,
          876,
          923,
          972,
          1024
        ],
        [
          4,
          8,
          15,
          21,
          27,
          36,
          39,
          52,
          60,
          74,
          85,
          96,
          109,
          120,
          136,
          154,
          173,
          191,
          208,
          235,
          248,
          270,
          284,
          315,
          330,
          365,
          385,
          405,
          430,
          457,
          486,
          518,
          553,
          590,
          605,
          647,
          673,
          701,
          750,
          784
        ]
      ],
      'eci': [[0]],
      'empty': [[0]]

    }
    alpha_encode_table = {
      '0': 0,
      '1': 1,
      '2': 2,
      '3': 3,
      '4': 4,
      '5': 5,
      '6': 6,
      '7': 7,
      '8': 8,
      '9': 9,
      'A': 10,
      'B': 11,
      'C': 12,
      'D': 13,
      'E': 14,
      'F': 15,
      'G': 16,
      'H': 17,
      'I': 18,
      'J': 19,
      'K': 20,
      'L': 21,
      'M': 22,
      'N': 23,
      'O': 24,
      'P': 25,
      'Q': 26,
      'R': 27,
      'S': 28,
      'T': 29,
      'U': 30,
      'V': 31,
      'W': 32,
      'X': 33,
      'Y': 34,
      'Z': 35,
      ' ': 36,
      '$': 37,
      '%': 38,
      '*': 39,
      '+': 40,
      '-': 41,
      '.': 42,
      '/': 43,
      ':': 44
    }
    total_data_codewords_table =[
      [0],
      [
        20,
        16,
        13,
        9
      ],
      [
        34,
        28,
        22,
        16
      ],
      [
        55,
        44,
        34,
        26
      ],
      [
        80,
        64,
        48,
        36
      ],
      [
        108,
        86,
        62,
        46
      ],
      [
        136,
        108,
        76,
        60
      ],
      [
        156,
        124,
        88,
        66
      ],
      [
        194,
        154,
        110,
        86
      ],
      [
        232,
        182,
        132,
        100
      ],
      [
        274,
        216,
        154,
        122
      ],
      [
        324,
        254,
        180,
        140
      ],
      [
        370,
        290,
        206,
        158
      ],
      [
        428,
        334,
        244,
        180
      ],
      [
        461,
        365,
        261,
        197
      ],
      [
        523,
        415,
        295,
        223
      ],
      [
        589,
        453,
        325,
        253
      ],
      [
        647,
        507,
        367,
        283
      ],
      [
        721,
        563,
        397,
        313
      ],
      [
        795,
        627,
        445,
        341
      ],
      [
        861,
        669,
        485,
        385
      ],
      [
        932,
        714,
        512,
        406
      ],
      [
        1006,
        0,
        782,
        568
      ],
      [
        442,
        1094,
        860,
        614
      ],
      [
        464,
        1174,
        914,
        664
      ],
      [
        514,
        1276,
        1000,
        718
      ],
      [
        538,
        1370,
        1062,
        754
      ],
      [
        596,
        1468,
        1128,
        808
      ],
      [
        628,
        1531,
        1193,
        871
      ],
      [
        661,
        1631,
        1267,
        911
      ],
      [
        701,
        1735,
        1373,
        985
      ],
      [
        745,
        1843,
        1455,
        1033
      ],
      [
        793,
        1955,
        1541,
        1115
      ],
      [
        845,
        2071,
        1631,
        1171
      ],
      [
        901,
        2191,
        1725,
        1231
      ],
      [
        961,
        2306,
        1812,
        1286
      ],
      [
        986,
        2434,
        1914,
        1354
      ],
      [
        1054,
        2566,
        1992,
        1426
      ],
      [
        1096,
        2702,
        2102,
        1502
      ],
      [
        1142,
        2812,
        2216,
        1582
      ],
      [
        1222,
        2956,
        2334,
        1666
      ]
    ]
)

fn new_qr(raw_data string, ecl ErrorCorrectionLevel) QR {
  return QR{
    raw_data:raw_data,
    ecl: ecl
    }
}

fn (q mut QR) create_qr(s string) string{
  if s.len > 0 {
    q.raw_data = s
  }
  q.analyze_data()
  
  q.encode_data()

  return ""
}

fn (q mut QR) analyze_data() ?Mode {
  mode := get_optimal(q.raw_data) or {
    return error(err)
  }
  q.mode = mode
  return mode
}

fn (q mut QR) encode_data() string {
  l := q.raw_data.ustring().len
  q.set_version(l)

  mut acc := []string
  mi := q.get_mode_indicator()
  acc << [mi]
  cci := q.get_character_count_indicator(l)
  acc << [cci]
  encoded := q.encode()
  acc << encoded
  joined := join(acc)
  termed := joined + q.get_terminator(joined.len)
  mult8bitted := pad_to_mult8bit(termed)
  raw_data_bits := q.pad_to_max(mult8bitted)
  return ""
}

fn (q mut QR) set_version(length int) Version {
  q.version = get_smallest_version(length, q.mode, q.ecl)
  return q.version
}

fn get_smallest_version(count int, mode Mode, level ErrorCorrectionLevel) Version {

  row := table[mode.str()][level]
  for i,c in row {
    if c >= count {
      return Version{i + 1}
    }
  }
  return Version{0}
}

fn (q QR) get_character_count_indicator(count int) string {
  b := get_bit(q.version.num, q.mode)
  return pad_bit(b, decimal_to_binary(count))
}

fn (q QR) get_mode_indicator() string {
  return pad_bit(4, decimal_to_binary(indicator(q.mode)))
}

fn get_bit(version int, mode Mode) int {
  return bit_table[mode.str()][version_to_ccirange(version)]
}

fn version_to_ccirange(version int) CCIRange {
  if 1 <= version && version <= 9 {
    return CCIRange.one_to_nine
  }
  if 10 <= version && version <= 26 {
    return CCIRange.ten_to_26th
  }
  if 27 <= version && version <= 40 {
    return CCIRange.t27_to_40
  }
  return CCIRange.zero
}

fn (q QR) encode() []string {
  match q.mode {
    .numeric => {return encode_numeric(q.raw_data)}
    .alphanumeric => {return encode_alpha(q.raw_data)}
  }
  return [q.raw_data]
}

fn encode_numeric(s string) []string {
  return encode_inner(3, a_to_bin, s)
}

fn a_to_bin(s string) string {
  return decimal_to_binary(s.int())
}

fn encode_alpha(s string) []string {
  return encode_inner(2, pair_to_bin, s)
}

fn pair_to_bin(s string) string {
  n := encode_alpha_c(s.substr(0,1))
  match s.len {
    0 => {return ""}
    1 => {return pad_bit(6, decimal_to_binary(n))}
    else => {return pad_bit(11, decimal_to_binary(45 * n + encode_alpha_c(s.substr(1,2))))}
  }
}

fn encode_alpha_c(s string) int {
  return alpha_encode_table[s]
}

fn encode_bit(s string) []string {
  return encode_inner(1, latin_to_bin, s)
}

fn latin_to_bin(s string) string {
  return pad_bit(8, qr.decimal_to_binary(s[0]))
}

fn encode_inner(step int, str_to_bin fn(string)string, s string) []string {
  mut acc := []string
  for i := 0; i < s.len; i = i + step {
    e := math.ceil(math.min(s.len, i + step))
    acc << s.substr(i, e)
  }
  mut res := []string
  for x in acc {
    res << str_to_bin(x)
  }
  return res
}

fn (q QR) get_required_capacity() int {
  return total_data_codewords_table[q.version.num][q.ecl] * 8
}
 
fn (q QR) get_terminator(data_length int) string {
   d := q.get_required_capacity() - data_length
   match d {
     0 => {return ""}
     1 => {return "0"}
     2 => {return "0".repeat(d)}
     3 => {return "0".repeat(d)}
     else => {return "0".repeat(4)}
   }
}

fn pad_to_mult8bit(s string) string {
  removed := remove(" ", s)
  match removed.len % 8 {
    0 => {return removed}
    else => {return pad_bit_r((removed.len / 8 + 1) * 8, removed)}
  }
}

fn (q QR) pad_to_max(s string) string {
  return s + take_n_pad((q.get_required_capacity() - s.len) / 8)
}

fn take_n_pad(n int) string {
  return '1110110000010001'.repeat(n + 1 / 2).substr(0, n * 8)
}
