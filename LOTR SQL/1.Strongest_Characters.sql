/*
Question 1: Who are the strongest characters in the LOTR universe
Based on character level, health and experience points
*/

SELECT
	character_name,
    guild,
    race,
    class,
    level,
    experience_points,
    health
FROM
	lotr.characters
ORDER BY level DESC, experience_points DESC, health DESC
LIMIT 5

/*
[
	{
		"character_name" : "Melkor",
		"guild" : "Angband",
		"race" : "Vala",
		"class" : "Dark Lord",
		"level" : 60,
		"experience_points" : 60000,
		"health" : 400
	},
	{
		"character_name" : "Sauron",
		"guild" : "Mordor",
		"race" : "Maia",
		"class" : "Dark Lord",
		"level" : 55,
		"experience_points" : 55000,
		"health" : 350
	},
	{
		"character_name" : "FÃ«anor",
		"guild" : "Tirion",
		"race" : "Elf",
		"class" : "Smith",
		"level" : 50,
		"experience_points" : 50000,
		"health" : 300
	},
	{
		"character_name" : "Gandalf",
		"guild" : "Fellowship",
		"race" : "Maia",
		"class" : "Wizard",
		"level" : 50,
		"experience_points" : 50000,
		"health" : 300
	},
	{
		"character_name" : "Tom Bombadil",
		"guild" : "None",
		"race" : "Unknown",
		"class" : "Enigma",
		"level" : 50,
		"experience_points" : 50000,
		"health" : 300
	}
]
*/

/*
Question 2: Who are the weakest characters in the LOTR universe
Based on character level, health and experience points
*/

SELECT
	character_name,
    guild,
    race,
    class,
    level,
    experience_points,
    health
FROM
	lotr.characters
ORDER BY level ASC, experience_points ASC, health ASC
LIMIT 5

/*
[
	{
		"character_name" : "Gollum",
		"guild" : "None",
		"race" : "Hobbit",
		"class" : "Thief",
		"level" : 10,
		"experience_points" : 8000,
		"health" : 60
	},
	{
		"character_name" : "Rosie Cotton",
		"guild" : "Shire",
		"race" : "Hobbit",
		"class" : "Peasant",
		"level" : 10,
		"experience_points" : 8000,
		"health" : 60
	},
	{
		"character_name" : "Lobelia Sackville-Baggins",
		"guild" : "Shire",
		"race" : "Hobbit",
		"class" : "Peasant",
		"level" : 12,
		"experience_points" : 9000,
		"health" : 70
	},
	{
		"character_name" : "GrÃ­ma Wormtongue",
		"guild" : "None",
		"race" : "Human",
		"class" : "Spy",
		"level" : 15,
		"experience_points" : 12000,
		"health" : 90
	},
	{
		"character_name" : "Peregrin Took",
		"guild" : "Fellowship",
		"race" : "Hobbit",
		"class" : "Warrior",
		"level" : 16,
		"experience_points" : 12500,
		"health" : 95
	}
]
*/