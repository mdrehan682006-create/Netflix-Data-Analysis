🎬 Netflix Content Catalog Analysis
An end-to-end exploratory data analysis (EDA) of the Netflix global content catalog — 8,807 titles spanning movies and TV shows released between 1925 and 2021 — built using a multi-tool analytics pipeline: Python, SQL (PostgreSQL), and Power BI.

Prepared by Mohammad Rehan | B.C.A. (Data Science) | Aspiring Data Analyst


📌 Project Overview
This project analyzes Netflix's content strategy across four key lenses:

Content composition — Movies vs. TV Shows
Geographic distribution — where content is produced globally
Genre & rating trends — audience maturity and genre popularity
Catalog growth over time — release trends vs. platform addition trends

The goal is to simulate a real-world, business-ready analytics workflow — from raw data cleaning to stakeholder-facing dashboards — that supports decisions around content acquisition, regional investment, and catalog expansion.


📊 Key Findings
Metric
Value
Total Titles
8,807
Movies Share
69.6% (6,131 titles)
TV Shows Share
30.4% (2,676 titles)
Countries Represented
125+
Top Content Country
United States (3,689 titles)
Peak Release Year
2018 (1,147 titles)
Peak Addition Year
2019 (2,016 titles added)
Most Common Rating
TV-MA (3,207 titles)
Top Genre
International Movies (2,752 titles)
Most Prolific Director
Rajiv Chilaka (22 titles)


Highlights:

Movies outnumber TV shows nearly 2.3:1, reflecting a historically film-first acquisition strategy.
The US and India are the two dominant content markets.
South Korea (73.6%) and Japan (62.6%) lean heavily toward TV-show content — strong drama/anime markets.
Platform additions peaked in 2019 and have since declined, suggesting a pivot from volume growth to curation and originals.
72 countries have fewer than 10 titles — potential white space for regional content investment.


🛠️ Tools & Tech Stack
Tool
Purpose
Python (Pandas, Matplotlib)
Data cleaning, EDA, and visualization across 29 business questions
PostgreSQL
Set-based aggregations, window functions (RANK, LAG), YoY growth analysis
Power BI
Interactive, stakeholder-facing dashboard with filtering and drill-down



📁 Repository Structure
├── netflix_titles_0.xlsx                    # Source dataset (8,807 titles × 12 attributes)

├── netflix_Analysis_1.ipynb                 # EDA Q1–10: content mix, countries, genres, ratings, directors

├── Netflix_Analysis_2.ipynb                 # EDA Q11–20: trends, genre growth, country specialization

├── Netflix_Analysis_3.ipynb                 # EDA Q21–29 + PostgreSQL data load via SQLAlchemy

├── netflix_SQL.sql                          # 10 core SQL business questions incl. window functions

├── netflix_dashboard.pbix                   # Power BI interactive dashboard

├── Netflix_Content_Analysis_Report.pdf      # Full written analysis report

├── Netflix-Content-Catalog-Analysis.pptx    # Presentation summary of findings

└── README.md                                # Project documentation (this file)


🧹 Data Cleaning Steps
Parsed the duration field — stripped " min" and converted to numeric minutes for movies.
Exploded multi-value fields (country, cast, director, listed_in) from comma-separated strings into individual rows for accurate counting.
Converted date_added to a proper datetime type.
Standardized and trimmed whitespace from categorical fields (e.g., country names) prior to grouping.


🐍 Python Analysis (Jupyter Notebooks)
Split across three notebooks covering 29 structured business questions:

Notebook 1 — Content mix, top countries, top genres, rating distribution, top directors
Notebook 2 — Time-based trends, decade-over-decade genre shifts, country content-type specialization
Notebook 3 — Advanced questions + loading the cleaned dataset into PostgreSQL via SQLAlchemy


🗄️ SQL Analysis (PostgreSQL)
netflix_SQL.sql contains 10 core business questions demonstrating relational/set-based analysis:

#
Business Question
SQL Technique
1
Top 10 directors by movie count
GROUP BY, COUNT, ORDER BY, LIMIT
2
Country ranking by title volume
UNNEST array split, RANK() OVER()
3
Longest movie in the catalog
CAST + ORDER BY DESC, LIMIT 1
4
Movies released after 2020
Filtering + ORDER BY
5
Directors active in both formats
HAVING COUNT(DISTINCT type) = 2
6
Title count by rating
GROUP BY, COUNT
7
Duplicate title detection
GROUP BY + HAVING COUNT(*) > 1
8
Average movie duration by country
UNNEST, AVG, ROUND
9
Top 5 genres
UNNEST array split, GROUP BY
10
Year-over-year growth (count & %)
LAG() OVER(), percentage calculation


Setup: Load netflix_titles_0.xlsx into a PostgreSQL table named netflix_analysis, then run the queries in netflix_SQL.sql sequentially.


📈 Power BI Dashboard
netflix_dashboard.pbix consolidates the key metrics — content mix, country distribution, genre popularity, and yearly growth — into an interactive, filterable dashboard for non-technical stakeholders to explore by year, country, or content type.


💡 Recommendations
Continue investment in Indian and South Korean original productions given their strong representation and TV engagement.
Evaluate the 72 underrepresented markets (<10 titles each) for regional content-acquisition opportunities.
Balance the movie-heavy catalog with further TV-series investment, especially in declining genres (Dramas, Documentaries).
Use the PostgreSQL + Power BI layers as a recurring reporting pipeline, refreshed as new titles are added.


📄 Full Report
For the complete written analysis with all charts and figures, see Netflix_Content_Analysis_Report.pdf. A condensed visual summary is available in Netflix-Content-Catalog-Analysis.pptx.


👤 Author
Mohammad Rehan B.C.A. (Data Science) Student | Aspiring Data Analyst Bilaspur, Chhattisgarh, India
