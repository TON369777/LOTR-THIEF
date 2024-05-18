/*
Question 9: You are a lowly thief and not very strong (Level 20). However, you desire the most valuable items in land of LOTR.
You are scoping for individual and guild targets to steal from.
Individual wise, who would you target based on your current strength?
Guild wise, which group would you target?
*/
    
SELECT
    CHARACTERS.character_name AS CHARACTER_NAME,
    CHARACTERS.guild AS GUILD,
    SUM(INVENTORY.quantity * ITEM_DETAILS.item_power_level) AS TOTAL_ITEM_POWER,
    SUM(CHARACTERS.level)/COUNT(CHARACTERS.level) AS CHARA_LEVEL
FROM
	lotr.characters AS CHARACTERS
LEFT JOIN 
	lotr.inventory AS INVENTORY ON CHARACTERS.character_id = INVENTORY.character_id
LEFT JOIN
	lotr.item_details AS ITEM_DETAILS ON INVENTORY.item_id = ITEM_DETAILS.item_id
GROUP BY
	CHARACTER_NAME, GUILD
HAVING
	CHARA_LEVEL <= 20
ORDER BY
	TOTAL_ITEM_POWER DESC
LIMIT 5

/*
[
	{
		"CHARACTER_NAME" : Frodo Baggins,
		"TOTAL_ITEM_POWER" : 150,
		"CHARA_LEVEL" : 20.0000
	},
	{
		"CHARACTER_NAME" : Durin VII,
		"TOTAL_ITEM_POWER" : 100,
		"CHARA_LEVEL" : 20.0000
	},
	{
		"CHARACTER_NAME" : Ori,
		"TOTAL_ITEM_POWER" : 90,
		"CHARA_LEVEL" : 20.0000
	},
	{
		"CHARACTER_NAME" : Lobelia Sackville-Baggins,
		"TOTAL_ITEM_POWER" : 85,
		"CHARA_LEVEL" : 12.0000
	},
	{
		"CHARACTER_NAME" : Nori,
		"TOTAL_ITEM_POWER" : 80,
		"CHARA_LEVEL" : 20.0000
        
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
HAVING
	AVG_CHARA_LEVEL <= 20
ORDER BY
	TOTAL_ITEM_POWER DESC, AVG_CHARA_LEVEL ASC
LIMIT 5

/*
[
	{
		"GUILD" : Shire,
		"TOTAL_ITEM_POWER" : 145,
		"AVG_CHARA_LEVEL" : 11.0000
	}
]
*/