# OVERVIEW

In the real world, you are a data analyst. One day, you are walking home after a long day at work and drinks with the boss but slipped on someone's vomit and hit your head. You fall unconscious however through some unexplainable reason, you have been transported to the world of 'The Lord of the Rings' right when 'The Fellowship of the Ring' has formed. You are allowed to choose a class for yourself. You have decided to follow the path of the 'Thief' (who possesses abilities to steal) as you desire TREASURE!. However, you are only level 20 and considered not very strong in this world. But still you covet the rings, swords and other items of great value in this land. Fortunately, your abilities of data analytics have carried through to this fantasical world and now must scope and decide who to target and relinquish their belongings.

![image](https://github.com/TON369777/LOTR-THIEF/assets/156875448/5c30db60-5ea3-4b1f-8c08-d75085b9f7bf)

# BACKGROUND

To scope for individuals and guilds to target, the following questions were answered through SQL queries:
1) Who are the strongest characters in this universe?
2) If I was looking to join a guild, which one should I join?
3) Who are the strongest characters for each class?
4) Which characters are stronger than the average character in the LOTR universe and also stronger than the average person for their respective race?
5) Which individual characters have the highest valued inventory?
6) Which guilds have the highest combined inventory value?
7) You are scoping for individual and guild targets to steal from.
a) Individual wise, who would you target based on your current strength?
b) Guild wise, which group would you target?

# TOOLS USED
* SQL - to query database and discover insights
* mySQL - database management system used to house data
* matplotlib, seaborn libraries in Python - to visualise insights
* CHATGPT - was used to generate the fictional data on LOTR characters and their inventory

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


