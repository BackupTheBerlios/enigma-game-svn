
-- LotM standing data
-- (no need to change these)

lotm_archive_data = {}

lotm_archive_data[1] = {
  date           = { month = 3, year = 2007 },
  chronological  = 1,
  name           = "Island Labyrinth",
  author         = "Jacob Scott",
  position       = "V/100",
  position_num   = "5100"
}

lotm_archive_data[2] = {
  date           = { month = 4, year = 2007 },
  chronological  = 2,
  name           = "Pneumatic Delivery",
  author         = "Manuel K&ouml;nig",
  position       = "V/59",
  position_num   = "5059"
}

lotm_archive_data[3] = {
  date           = { month = 5, year = 2007 },
  chronological  = 3,
  name           = "The Aztec Temple",
  author         = "Dominik Lehmann",
  position       = "VI/100",
  position_num   = "6100"
}

lotm_archive_data[4] = {
  date           = { month = 6, year = 2007 },
  chronological  = 4,
  name           = "Labyrinth of Puzzles",
  author         = "Jacob Scott",
  position       = "IV/19",
  position_num   = "4019"
}

lotm_archive_data[5] = {
  date           = { month = 7, year = 2007 },
  chronological  = 5,
  name           = "Elaborate",
  author         = "Jacob Scott",
  position       = "V/65",
  position_num   = "5065"
}

lotm_archive_data[6] = {
  date           = { month = 8, year = 2007 },
  chronological  = 6,
  name           = "Houdini",
  author         = "Ronald Lamprecht",
  position       = "VI/74",
  position_num   = "6074"
}

lotm_archive_data[7] = {
  date           = { month = 9, year = 2007 },
  chronological  = 7,
  name           = "Tool Time",
  author         = "Barry &amp; Lori Mead",
  position       = "II/97",
  position_num   = "2097"
}

lotm_archive_data[8] = {
  date           = { month = 10, year = 2007 },
  chronological  = 8,
  name           = "Quadropolis",
  author         = "J.Laire, J.Scott, R.Bourquin, A.Lochmann",
  position       = "VI/79",
  position_num   = "6079"
}

-- LotM variable data
-- format: Level Title, current_rating, current_votes, additional text

lotm_rating(    "Island Labyrinth",  9.25,   8,  "(1 up)")
lotm_rating(  "Pneumatic Delivery",  7.58,  12,  "")
lotm_rating(    "The Aztec Temple",  9.14,   7,  "(1 down)")
lotm_rating("Labyrinth of Puzzles",  8.92,  13,  "(1 up)")
lotm_rating(           "Elaborate",  8.50,   8,  "")
lotm_rating(             "Houdini",  8.86,  10,  "(1 down)")
lotm_rating(           "Tool Time",  8.43,  14,  "")
lotm_rating(         "Quadropolis",  9.40,   5,  "<b>(newcomer)</b>")

-- Don't forget to adjust the archive dates:

lotm_archive_data_from = { month = 8, year = 2007 }

lotm_current = lotm_archive_data[table.getn(lotm_archive_data)]


