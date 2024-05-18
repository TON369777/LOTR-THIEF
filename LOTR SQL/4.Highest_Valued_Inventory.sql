/*
Question 7: Which individual characters have the highest valued inventory?
Based on item power level
*/

SELECT
    CHARACTERS.character_name AS CHARACTER_NAME,
    SUM(INVENTORY.quantity * ITEM_DETAILS.item_power_level) AS TOTAL_ITEM_POWER,
    SUM(CHARACTERS.level)/COUNT(CHARACTERS.level) AS CHARA_LEVEL
FROM
	lotr.characters AS CHARACTERS
LEFT JOIN 
	lotr.inventory AS INVENTORY ON CHARACTERS.character_id = INVENTORY.character_id
LEFT JOIN
	lotr.item_details AS ITEM_DETAILS ON INVENTORY.item_id = ITEM_DETAILS.item_id
GROUP BY
	CHARACTER_NAME
ORDER BY
	TOTAL_ITEM_POWER DESC
LIMIT 10

/*[[
	{
		"CHARACTER_NAME" : Frodo Baggins,
		"TOTAL_ITEM_POWER" : 150,
		"CHARA_LEVEL" : 20.0000
	},
	{
		"CHARACTER_NAME" : Gandalf,
		"TOTAL_ITEM_POWER" : 150,
		"CHARA_LEVEL" : 50.0000
	},
	{
		"CHARACTER_NAME" : EÃ¤rendil,
		"TOTAL_ITEM_POWER" : 100,
		"CHARA_LEVEL" : 40.0000
	},
	{
		"CHARACTER_NAME" : Ecthelion,
		"TOTAL_ITEM_POWER" : 100,
		"CHARA_LEVEL" : 45.0000
	},
	{
		"CHARACTER_NAME" : AzaghÃ¢l,
		"TOTAL_ITEM_POWER" : 100,
		"CHARA_LEVEL" : 50.0000
	},
	{
		"CHARACTER_NAME" : Gil-galad,
		"TOTAL_ITEM_POWER" : 100,
		"CHARA_LEVEL" : 45.0000
	},
	{
		"CHARACTER_NAME" : Durin VII,
		"TOTAL_ITEM_POWER" : 100,
		"CHARA_LEVEL" : 20.0000
	},
	{
		"CHARACTER_NAME" : Fingolfin,
		"TOTAL_ITEM_POWER" : 100,
		"CHARA_LEVEL" : 50.0000
	},
	{
		"CHARACTER_NAME" : Durin VI,
		"TOTAL_ITEM_POWER" : 95,
		"CHARA_LEVEL" : 25.0000
	},
	{
		"CHARACTER_NAME" : Celebrimbor,
		"TOTAL_ITEM_POWER" : 90,
		"CHARA_LEVEL" : 50.0000
	}
]

*/

/*
Question 8: Which guilds have the highest inventory value?
Based on item power level
*/

SELECT
    CHARACTERS.guild AS GUILD,
    SUM(INVENTORY.quantity * ITEM_DETAILS.item_power_level) AS TOTAL_ITEM_POWER,
    AVG(CHARACTERS.level) AS AVG_CHARA_LEVEL
FROM
	lotr.characters AS CHARACTERS
LEFT JOIN 
	lotr.inventory AS INVENTORY ON CHARACTERS.character_id = INVENTORY.character_id
LEFT JOIN
	lotr.item_details AS ITEM_DETAILS ON INVENTORY.item_id = ITEM_DETAILS.item_id
WHERE
	CHARACTERS.guild != "None"
GROUP BY
	GUILD
ORDER BY
	TOTAL_ITEM_POWER DESC, AVG_CHARA_LEVEL ASC
LIMIT 10

/*
[
	{
		"GUILD" : Erebor,
		"TOTAL_ITEM_POWER" : 1425,
		"AVG_CHARA_LEVEL" : 28.0526
	},
	{
		"GUILD" : Moria,
		"TOTAL_ITEM_POWER" : 1200,
		"AVG_CHARA_LEVEL" : 32.4000
	},
	{
		"GUILD" : Fellowship,
		"TOTAL_ITEM_POWER" : 635,
		"AVG_CHARA_LEVEL" : 25.6364
	},
	{
		"GUILD" : Gondolin,
		"TOTAL_ITEM_POWER" : 355,
		"AVG_CHARA_LEVEL" : 37.5000
	},
	{
		"GUILD" : Gondor,
		"TOTAL_ITEM_POWER" : 340,
		"AVG_CHARA_LEVEL" : 29.0000
	},
	{
		"GUILD" : Rohan,
		"TOTAL_ITEM_POWER" : 260,
		"AVG_CHARA_LEVEL" : 22.7500
	},
	{
		"GUILD" : Mordor,
		"TOTAL_ITEM_POWER" : 220,
		"AVG_CHARA_LEVEL" : 32.6667
	},
	{
		"GUILD" : Rivendell,
		"TOTAL_ITEM_POWER" : 190,
		"AVG_CHARA_LEVEL" : 33.3333
	},
	{
		"GUILD" : Hithlum,
		"TOTAL_ITEM_POWER" : 175,
		"AVG_CHARA_LEVEL" : 50.0000
	},
	{
		"GUILD" : Angband,
		"TOTAL_ITEM_POWER" : 165,
		"AVG_CHARA_LEVEL" : 54.0000
	}
]
*/

/* BASE QUERY
*/

SELECT
	CHARACTERS.character_id,
    CHARACTERS.character_name,
    CHARACTERS.guild,
    CHARACTERS.race,
    CHARACTERS.class,
    CHARACTERS.level,
    INVENTORY.item_id,
    INVENTORY.quantity AS ITEM_QUANTITY,
    ITEM_DETAILS.item_name AS ITEM_NAME,
    ITEM_DETAILS.item_power_level,
    INVENTORY.quantity * ITEM_DETAILS.item_power_level AS SUMMED_ITEM_POWER
FROM
	lotr.characters AS CHARACTERS
LEFT JOIN 
	lotr.inventory AS INVENTORY ON CHARACTERS.character_id = INVENTORY.character_id
LEFT JOIN
	lotr.item_details AS ITEM_DETAILS ON INVENTORY.item_id = ITEM_DETAILS.item_id