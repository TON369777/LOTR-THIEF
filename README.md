# OVERVIEW - WIP

In the real world, you are a data analyst. One day, you are walking home after a long day at work and drinks with the boss but slipped on someone's vomit and hit your head. You fall unconscious however through some unexplainable reason, you have been transported to the world of 'The Lord of the Rings' right when 'The Fellowship of the Ring' has formed. You are allowed to choose a class for yourself. You have decided to follow the path of the 'Thief' (who possesses abilities to steal) as you desire TREASURE!. However, you are only level 20 and considered not very strong in this world. But still you covet the rings, swords and other items of great value in this land. Fortunately, your abilities of data analytics have carried through to this fantasical world and now must scope and decide who to target and relinquish their belongings.

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/5c30db60-5ea3-4b1f-8c08-d75085b9f7bf)

# BACKGROUND

To scope for individuals and guilds to target, the following questions were answered through SQL queries which will help us with deciding who our target/s should be:
1) Who are the strongest characters in this universe?
2) If I was looking to join a guild, which one should I join?
3) Who are the strongest characters for each class?
4) Which characters are stronger than the average character in the LOTR universe and also stronger than the average person for their respective race?
5) Which individual characters have the highest valued inventory?
6) Which guilds have the highest combined inventory value?
7) You are scoping for individual and guild targets to steal from:
a) Individual wise, who would you target based on your current strength?
b) Guild wise, which group would you target?

# TOOLS USED
* CHATGPT - was used to generate the fictional data on LOTR characters and their inventory
* SQL - to query database and discover insights
* mySQL - database management system used to house data
* matplotlib, seaborn libraries in Python - to visualise insights

### 1. Who are the strongest characters in this universe?

The idenitfy the strongest characters in this universe, characters were filtered based on their level, experience points and health points

```sql
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
LIMIT 5;
```
![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/7b28bfa0-6bb4-4fad-9555-c52bd9488f88)

* The strongest individuals in this universe are Dark Lords, Melkor and Sauron at level 60 and 55 respectively. Not even Gandalf stands a chance despite being level 50. At this point of the story, the forces of evil are very strong.

### 2) If I was looking to join a guild, which one should I join?

In the world of LOTR, most individuals act in groups or guilds, examining the various guilds can paint a different perspective. Guilds' average power level with at least 2 members were examined.

```sql
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
```

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/4ac087c1-a8e4-48db-9394-0128eeb40dc8)

* The top 5 guilds are at least level 33 (average), clearly a level 20 Thief would be no match but these guilds would be perfect groups to ally with.

### 3) Who are the strongest characters for each class?

```sql
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
```

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/b484c309-5664-4aea-9e13-0f13d7222206)

### 4) Which characters are stronger than the average character in the LOTR universe and also stronger than the average person for their respective race?

```sql
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
```

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/2c133b43-0af6-416c-b429-9f3e74eb8a37)

### 5) Which individual characters have the highest valued inventory?

```sql
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
```

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/57ddea50-6f9f-4bcd-b7bd-306f0a04c485)

### 6) Which guilds have the highest combined inventory value?

```sql
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
```

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/385f21d4-514c-4230-b639-71ca36cd604f)

### 7) You are scoping for individual and guild targets to steal from:
**a) Individual wise, who would you target based on your current strength?**

```sql
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
```

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/ee8b9842-9756-4b45-b025-6f6a552dec9a)

**b) Guild wise, which group would you target?**

```sql
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
```

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/f1a2c03b-a3dd-4591-b65b-af513171292d)

# INSIGHTS and CONCLUSION

Through the process of exploring the data avaliable at hand, our goal would be ultimately met if we followed in the lore accurate path of Gollum through targeting Frodo as he yields a combined item value of 150 whilst being only level 20 which is great since we wouldn't have to worry about combat too much if the stealing goes wrong. After taking his possession of the 'One Ring' + 'Sting', we would move to the Shire as they are below level 20 and have a combined item value of 140 amongst their dwellers. 

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/8de27af5-cad5-45de-a63f-662fa960daca)

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/8c7d8bab-bd0a-4f64-b58e-0a041e64a6da)
