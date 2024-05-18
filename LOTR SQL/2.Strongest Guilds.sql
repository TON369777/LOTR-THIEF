/*
Question 3: If I was looking to join a guild, which one should I join?
Based on highest avg level, experience points
Guild must have at least 2 members
The 'None' entry for guild indicates that the character is not part of a guild
*/

SELECT
	CHARACTERS.guild,
    AVG(CHARACTERS.level) AS AVG_LEVEL,
    AVG(CHARACTERS.experience_points) AS AVG_XP,
    COUNT(guild) AS GUILD_MEMBERS
FROM
	lotr.characters AS CHARACTERS
WHERE
	CHARACTERS.guild != "None"
GROUP BY
	CHARACTERS.guild
HAVING 
	GUILD_MEMBERS > 1
ORDER BY
	AVG_LEVEL DESC, AVG_XP DESC
LIMIT 5

/*[
	{
		"guild" : Angband,
		"AVG_LEVEL" : 54.0000,
		"AVG_XP" : 53500.0000,
		"GUILD_MEMBERS" : 2
	},
	{
		"guild" : Hithlum,
		"AVG_LEVEL" : 50.0000,
		"AVG_XP" : 50000.0000,
		"GUILD_MEMBERS" : 2
	},
	{
		"guild" : Gondolin,
		"AVG_LEVEL" : 37.5000,
		"AVG_XP" : 37500.0000,
		"GUILD_MEMBERS" : 4
	},
	{
		"guild" : Nargothrond,
		"AVG_LEVEL" : 36.5000,
		"AVG_XP" : 36500.0000,
		"GUILD_MEMBERS" : 2
	},
	{
		"guild" : Rivendell,
		"AVG_LEVEL" : 33.3333,
		"AVG_XP" : 33333.3333,
		"GUILD_MEMBERS" : 3
	}
]
*/

/*
Question 4: Which are the weakest guilds and should avoid joining?
Based on avg level, experience points
Guild must have at least 2 members
The 'None' entry for guild indicates that the character is not part of a guild
*/

SELECT
	CHARACTERS.guild,
    AVG(CHARACTERS.level) AS AVG_LEVEL,
    AVG(CHARACTERS.experience_points) AS AVG_XP,
    COUNT(guild) AS GUILD_MEMBERS
FROM
	lotr.characters AS CHARACTERS
WHERE
	CHARACTERS.guild != "None"
GROUP BY
	CHARACTERS.guild
HAVING 
	GUILD_MEMBERS > 1
ORDER BY
	AVG_LEVEL ASC, AVG_XP ASC
LIMIT 5

/*
[
	{
		"guild" : Shire,
		"AVG_LEVEL" : 11.0000,
		"AVG_XP" : 8500.0000,
		"GUILD_MEMBERS" : 2
	},
	{
		"guild" : Rohan,
		"AVG_LEVEL" : 22.7500,
		"AVG_XP" : 21750.0000,
		"GUILD_MEMBERS" : 4
	},
	{
		"guild" : Fellowship,
		"AVG_LEVEL" : 23.5556,
		"AVG_XP" : 21722.2222,
		"GUILD_MEMBERS" : 9
	},
	{
		"guild" : Erebor,
		"AVG_LEVEL" : 28.0526,
		"AVG_XP" : 28052.6316,
		"GUILD_MEMBERS" : 19
	},
	{
		"guild" : Gondor,
		"AVG_LEVEL" : 29.0000,
		"AVG_XP" : 28800.0000,
		"GUILD_MEMBERS" : 5
	}
]

*/