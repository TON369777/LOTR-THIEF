/*
Question 5: Who are the strongest characters for each class?
Based on level
*/

WITH MAX_LEVEL_CLASS AS(
SELECT
	class,
    MAX(level) AS MAX_LEVEL
FROM
	lotr.characters AS CHARACTERS
GROUP BY
	class
)

SELECT 
	MAX_LEVEL_CLASS.class,
    MAX_LEVEL_CLASS.MAX_LEVEL,
    CHARACTERS.character_name
FROM 
	MAX_LEVEL_CLASS
LEFT JOIN 
	lotr.characters AS CHARACTERS
ON
	MAX_LEVEL_CLASS.class = CHARACTERS.class AND
    MAX_LEVEL_CLASS.MAX_LEVEL = CHARACTERS.level

/*
[
	{
		"class" : "Ring-bearer",
		"MAX_LEVEL" : 20,
		"character_name" : "Frodo Baggins"
	},
	{
		"class" : "Gardener",
		"MAX_LEVEL" : 18,
		"character_name" : "Samwise Gamgee"
	},
	{
		"class" : "Wizard",
		"MAX_LEVEL" : 50,
		"character_name" : "Gandalf"
	},
	{
		"class" : "Ranger",
		"MAX_LEVEL" : 25,
		"character_name" : "Aragorn"
	},
	{
		"class" : "Archer",
		"MAX_LEVEL" : 25,
		"character_name" : "Bard"
	},
	{
		"class" : "Warrior",
		"MAX_LEVEL" : 45,
		"character_name" : "Ecthelion"
	},
	{
		"class" : "Sorceress",
		"MAX_LEVEL" : 50,
		"character_name" : "LÃºthien"
	},
	{
		"class" : "Lord",
		"MAX_LEVEL" : 40,
		"character_name" : "Elrond"
	},
	{
		"class" : "Thief",
		"MAX_LEVEL" : 10,
		"character_name" : "Gollum"
	},
	{
		"class" : "King",
		"MAX_LEVEL" : 50,
		"character_name" : "Durin"
	},
	{
		"class" : "King",
		"MAX_LEVEL" : 50,
		"character_name" : "AzaghÃ¢l"
	},
	{
		"class" : "King",
		"MAX_LEVEL" : 50,
		"character_name" : "Fingon"
	},
	{
		"class" : "King",
		"MAX_LEVEL" : 50,
		"character_name" : "Fingolfin"
	},
	{
		"class" : "Shieldmaiden",
		"MAX_LEVEL" : 18,
		"character_name" : "Ã‰owyn"
	},
	{
		"class" : "Steward",
		"MAX_LEVEL" : 35,
		"character_name" : "Denethor"
	},
	{
		"class" : "Shepherd",
		"MAX_LEVEL" : 40,
		"character_name" : "Treebeard"
	},
	{
		"class" : "Lady",
		"MAX_LEVEL" : 30,
		"character_name" : "Aredhel"
	},
	{
		"class" : "Spy",
		"MAX_LEVEL" : 15,
		"character_name" : "GrÃ­ma Wormtongue"
	},
	{
		"class" : "Adventurer",
		"MAX_LEVEL" : 30,
		"character_name" : "Beren"
	},
	{
		"class" : "Adventurer",
		"MAX_LEVEL" : 30,
		"character_name" : "Bilbo Baggins"
	},
	{
		"class" : "Mariner",
		"MAX_LEVEL" : 40,
		"character_name" : "EÃ¤rendil"
	},
	{
		"class" : "Smith",
		"MAX_LEVEL" : 50,
		"character_name" : "Celebrimbor"
	},
	{
		"class" : "Smith",
		"MAX_LEVEL" : 50,
		"character_name" : "FÃ«anor"
	},
	{
		"class" : "Dark Lord",
		"MAX_LEVEL" : 60,
		"character_name" : "Melkor"
	},
	{
		"class" : "Monster",
		"MAX_LEVEL" : 40,
		"character_name" : "Smaug"
	},
	{
		"class" : "Sorcerer",
		"MAX_LEVEL" : 50,
		"character_name" : "Witch-king"
	},
	{
		"class" : "Demon",
		"MAX_LEVEL" : 48,
		"character_name" : "Gothmog"
	},
	{
		"class" : "Enigma",
		"MAX_LEVEL" : 50,
		"character_name" : "Tom Bombadil"
	},
	{
		"class" : "Peasant",
		"MAX_LEVEL" : 12,
		"character_name" : "Lobelia Sackville-Baggins"
	},
	{
		"class" : "Rider",
		"MAX_LEVEL" : 20,
		"character_name" : "Ã‰othain"
	},
	{
		"class" : "Healer",
		"MAX_LEVEL" : 28,
		"character_name" : "Oin"
	},
	{
		"class" : "Prince",
		"MAX_LEVEL" : 35,
		"character_name" : "AnÃ¡rion"
	},
	{
		"class" : "Princess",
		"MAX_LEVEL" : 35,
		"character_name" : "Idril"
	},
	{
		"class" : "Guardian",
		"MAX_LEVEL" : 40,
		"character_name" : "LÃ³rien"
	},
	{
		"class" : "Shipwright",
		"MAX_LEVEL" : 45,
		"character_name" : "CÃ­rdan"
	},
	{
		"class" : "Warlord",
		"MAX_LEVEL" : 45,
		"character_name" : "Azog"
	},
	{
		"class" : "Scholar",
		"MAX_LEVEL" : 20,
		"character_name" : "Ori"
	}
]
*/

/*
Question 6: Which characters are stronger than the average character in the LOTR universe and also stronger than average person for their respective race?
Based on level
*/

SELECT
	AVG(level)
FROM
	lotr.characters
    
-- 32.51

WITH AVG_LEVEL_RACE AS(
SELECT
	race,
    AVG(level) AS AVG_LEVEL
FROM
	lotr.characters AS CHARACTERS
GROUP BY
	race
)

SELECT
	CHARACTERS.character_name,
    CHARACTERS.guild,
    CHARACTERS.race,
    CHARACTERS.class,
    CHARACTERS.level
FROM
	lotr.characters AS CHARACTERS
INNER JOIN
	AVG_LEVEL_RACE
ON
	CHARACTERS.race = AVG_LEVEL_RACE.race AND
	CHARACTERS.level >= AVG_LEVEL_RACE.AVG_LEVEL
WHERE
	CHARACTERS.level > (SELECT AVG(level) FROM lotr.characters)
    
/*
[
	{
		"character_name" : "Gothmog",
		"guild" : "Angband",
		"race" : "Maia",
		"class" : "Demon",
		"level" : 48
	},
	{
		"character_name" : "Sauron",
		"guild" : "Mordor",
		"race" : "Maia",
		"class" : "Dark Lord",
		"level" : 55
	},
	{
		"character_name" : "Saruman",
		"guild" : "None",
		"race" : "Maia",
		"class" : "Wizard",
		"level" : 48
	},
	{
		"character_name" : "Gandalf",
		"guild" : "Fellowship",
		"race" : "Maia",
		"class" : "Wizard",
		"level" : 50
	},
	{
		"character_name" : "AnÃ¡rion",
		"guild" : "Gondor",
		"race" : "Human",
		"class" : "Prince",
		"level" : 35
	},
	{
		"character_name" : "Witch-king",
		"guild" : "Angmar",
		"race" : "Human",
		"class" : "Sorcerer",
		"level" : 50
	},
	{
		"character_name" : "Isildur",
		"guild" : "Gondor",
		"race" : "Human",
		"class" : "King",
		"level" : 35
	},
	{
		"character_name" : "Denethor",
		"guild" : "Gondor",
		"race" : "Human",
		"class" : "Steward",
		"level" : 35
	},
	{
		"character_name" : "Celebrimbor",
		"guild" : "Eregion",
		"race" : "Elf",
		"class" : "Smith",
		"level" : 50
	},
	{
		"character_name" : "CÃ­rdan",
		"guild" : "Mithlond",
		"race" : "Elf",
		"class" : "Shipwright",
		"level" : 45
	},
	{
		"character_name" : "LÃ³rien",
		"guild" : "LothlÃ³rien",
		"race" : "Elf",
		"class" : "Guardian",
		"level" : 40
	},
	{
		"character_name" : "Ecthelion",
		"guild" : "Gondolin",
		"race" : "Elf",
		"class" : "Warrior",
		"level" : 45
	},
	{
		"character_name" : "Fingon",
		"guild" : "Hithlum",
		"race" : "Elf",
		"class" : "King",
		"level" : 50
	},
	{
		"character_name" : "Finrod",
		"guild" : "Nargothrond",
		"race" : "Elf",
		"class" : "King",
		"level" : 45
	},
	{
		"character_name" : "Thranduil",
		"guild" : "Mirkwood",
		"race" : "Elf",
		"class" : "King",
		"level" : 40
	},
	{
		"character_name" : "FÃ«anor",
		"guild" : "Tirion",
		"race" : "Elf",
		"class" : "Smith",
		"level" : 50
	},
	{
		"character_name" : "Fingolfin",
		"guild" : "Hithlum",
		"race" : "Elf",
		"class" : "King",
		"level" : 50
	},
	{
		"character_name" : "Gil-galad",
		"guild" : "Lindon",
		"race" : "Elf",
		"class" : "King",
		"level" : 45
	},
	{
		"character_name" : "LÃºthien",
		"guild" : "Doriath",
		"race" : "Elf",
		"class" : "Sorceress",
		"level" : 50
	},
	{
		"character_name" : "Glorfindel",
		"guild" : "Rivendell",
		"race" : "Elf",
		"class" : "Warrior",
		"level" : 40
	},
	{
		"character_name" : "Elrond",
		"guild" : "Rivendell",
		"race" : "Elf",
		"class" : "Lord",
		"level" : 40
	},
	{
		"character_name" : "Galadriel",
		"guild" : "None",
		"race" : "Elf",
		"class" : "Sorceress",
		"level" : 45
	},
	{
		"character_name" : "Durin IV",
		"guild" : "Moria",
		"race" : "Dwarf",
		"class" : "King",
		"level" : 35
	},
	{
		"character_name" : "Durin III",
		"guild" : "Moria",
		"race" : "Dwarf",
		"class" : "King",
		"level" : 40
	},
	{
		"character_name" : "Durin II",
		"guild" : "Moria",
		"race" : "Dwarf",
		"class" : "King",
		"level" : 45
	},
	{
		"character_name" : "Durin",
		"guild" : "Moria",
		"race" : "Dwarf",
		"class" : "King",
		"level" : 50
	},
	{
		"character_name" : "ThrÃ³r",
		"guild" : "Erebor",
		"race" : "Dwarf",
		"class" : "King",
		"level" : 35
	},
	{
		"character_name" : "Telchar",
		"guild" : "Nogrod",
		"race" : "Dwarf",
		"class" : "Smith",
		"level" : 45
	},
	{
		"character_name" : "AzaghÃ¢l",
		"guild" : "Belegost",
		"race" : "Dwarf",
		"class" : "King",
		"level" : 50
	},
	{
		"character_name" : "Thorin II",
		"guild" : "Erebor",
		"race" : "Dwarf",
		"class" : "King",
		"level" : 40
	},
	{
		"character_name" : "Balin",
		"guild" : "Erebor",
		"race" : "Dwarf",
		"class" : "Lord",
		"level" : 35
	},
	{
		"character_name" : "Thorin Oakenshield",
		"guild" : "Erebor",
		"race" : "Dwarf",
		"class" : "King",
		"level" : 40
	},
	{
		"character_name" : "Thrain",
		"guild" : "Erebor",
		"race" : "Dwarf",
		"class" : "King",
		"level" : 35
	},
	{
		"character_name" : "Treebeard",
		"guild" : "Ents",
		"race" : "Ent",
		"class" : "Shepherd",
		"level" : 40
	},
	{
		"character_name" : "EÃ¤rendil",
		"guild" : "Gondolin",
		"race" : "Half-Elf",
		"class" : "Mariner",
		"level" : 40
	},
	{
		"character_name" : "Melkor",
		"guild" : "Angband",
		"race" : "Vala",
		"class" : "Dark Lord",
		"level" : 60
	},
	{
		"character_name" : "Smaug",
		"guild" : "Lonely Mountain",
		"race" : "Dragon",
		"class" : "Monster",
		"level" : 40
	},
	{
		"character_name" : "Beorn",
		"guild" : "Beornings",
		"race" : "Skin-changer",
		"class" : "Warrior",
		"level" : 35
	},
	{
		"character_name" : "Tom Bombadil",
		"guild" : "None",
		"race" : "Unknown",
		"class" : "Enigma",
		"level" : 50
	},
	{
		"character_name" : "Bolg",
		"guild" : "Moria",
		"race" : "Orc",
		"class" : "Warrior",
		"level" : 35
	},
	{
		"character_name" : "Azog",
		"guild" : "Moria",
		"race" : "Orc",
		"class" : "Warlord",
		"level" : 45
	}
]
*/