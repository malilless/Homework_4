# Homework_4
## Part 1 — Data Preparation and Parsing
*Check the SQL file provided
Here I uploaded the raw data into the "games_raw" table and structured it a bit.
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/39524fd8-890b-4dc9-b131-eb3f7104f42d" />

The same with "reviews_raw" table.
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/881fbf18-2b7c-4e5b-94e6-f40192688fae" />

Then I filtered the data, chose only the columns I thought I needed, and saved the results as "games_filtered" and "reviews_filtered" tables. 
Game_filtered:
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/3d017b1b-b5b7-4155-a938-f4404a4a3c68" />
Reviews_filtered:
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/0c87351b-cdbe-4a86-be54-8fbde05fb024" />

## Part 2 — Analytical Insights
*Check the SQL file provided
1. Top 20 games by number of reviews:
<img width="1280" height="680" alt="image" src="https://github.com/user-attachments/assets/e4b6304f-1260-414f-89bb-fb0322e3ca5b" />
2. Distribution of game release years:
<img width="1280" height="680" alt="image" src="https://github.com/user-attachments/assets/68caa313-35f8-4900-a669-ab66321de46b" />
3. Average price by genre (after JSON parsing and unnesting):
<img width="1280" height="680" alt="image" src="https://github.com/user-attachments/assets/5c9411be-5c63-4c6f-852a-df1ae61a3d63" />
4. Identify the most common tags across all games:
<img width="1280" height="680" alt="image" src="https://github.com/user-attachments/assets/af091d3c-37d9-4f58-acfa-b304f87904eb" />

## Part 4 — Data Visualization
I decided to visualize the distribution of game tags. I chose a bar chart and filtered only the top-10 most common tags. Coloring by tag type was also used to improve the graph's quality and clarity. All the work was done in Tableau.
<img width="1280" height="720" alt="image" src="https://github.com/user-attachments/assets/a7123fbd-3e5c-4dbf-80ba-178e8a2212f7" />
