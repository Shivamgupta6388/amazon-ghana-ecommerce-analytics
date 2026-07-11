# 🛒 Amazon E-Commerce Sales Analytics Dashboard
### Power BI Capstone Project | Ghana Market (2015–2020)

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-FF9900?style=for-the-badge&logo=microsoft&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

---

## 📌 Project Overview

This end-to-end analytics project transforms **1,13,000 raw e-commerce orders** (2015–2020) from Ghana's Amazon market into a fully interactive 3-tab Power BI dashboard. The goal: help business stakeholders answer 35+ real questions about revenue, customers, products, returns, and regional performance — and walk away with clear, data-backed recommendations.

> *"A 27% return rate that has nothing to do with delivery speed — it's a content problem disguised as a logistics problem."*

---

## 🖥️ Live Dashboard

🔗 **[View Interactive Dashboard on Power BI Service](#)** ← paste your link here

---

## 📊 Key Metrics (All Categories, 2015–2020)

| Metric | Value |
|---|---|
| Total Revenue | ₵107 Million |
| Total Orders | 1,13,000 |
| Total Customers | 1,13,000 |
| Avg Customer Rating | 2.73 / 5 |
| Returned Orders | 31K (27%) |
| Avg Delivery Days | 9.53 days |
| Avg Unit Price | ₵297.04 |

---

## 💡 Key Insights

### 1. Revenue is concentrated in 2 categories
**Phones & Tablets (₵39M)** and **Electronics (₵33M)** together drive **67% of total revenue** despite having fewer customers than Health & Beauty.

### 2. Return rate is a listing problem, not a delivery problem
At **27% return rate**, the top reason across all categories is **"Description Mismatch"** — not late delivery, not defective products. This signals a product listing accuracy issue.

### 3. Greater Accra + Ashanti = 47% of all revenue
These 2 regions dominate sales (₵27M + ₵23M) while 20+ other locations contribute less than ₵1M each.

### 4. High price does not guarantee high satisfaction
Electronics has the highest average sale price (₵3.2K per order) but customer satisfaction stays moderate.

### 5. Order volume accelerating
Orders grew from ~18K/year (2015–18) to **25K in 2020**, with monthly revenue steady at ₵1.3–1.5M.

---

## 🏗️ Project Architecture

```
Raw Excel Data (Orders + Customers)
        ↓
Power Query Editor (Data Cleaning)
        ↓
Data Model (Star Schema: Customers ↔ Orders ↔ Date Table)
        ↓
DAX Measures (15+ measures)
        ↓
3-Tab Interactive Dashboard (Power BI Desktop)
        ↓
Published to Power BI Service (Live Link)
        ↓
SQL File (7 Advanced Queries)
```

---

## 🧹 Data Cleaning (Power Query)

| Issue Found | How Fixed |
|---|---|
| 5 phantom blank columns (Col18–Col22) | Removed via Remove Columns |
| Blank rows (all nulls, no OrderID) | Home → Remove Blank Rows |
| 1 missing Product Category | Identified via SubCategory → filled "Health and beauty" |
| 8 missing Unit Price + Order Quantity | Group By + Merge → product-wise average price, Qty = 1 |
| 1 missing Customer Gender | Labeled "Unknown" to preserve order record |
| Data type mismatches | Dates → Date, IDs → Whole Number, Prices → Decimal |

---

## 📐 Data Model

```
Customers (1) ──────── Orders (Many)
[CustomerID]           [CustomerID]

Date Table (1) ──────── Orders (Many)
[Date]                 [OrderDate]
```

- **Relationship type:** Many-to-One (Orders → Customers)
- **Schema:** Star Schema
- **Cross filter direction:** Single

---

## 📋 Key DAX Measures

```dax
-- Total Revenue
Total Revenue = SUM(Orders[Sale Price])

-- Avg Delivery Days (Delivered orders only)
Avg Delivery Days =
CALCULATE(
    AVERAGEX(Orders, DATEDIFF(Orders[OrderDate], Orders[Delivery Date], DAY)),
    Orders[Status] = "Delivered"
)

-- Return Rate
Return Rate = DIVIDE([Returned Products], [Total Orders], 0)

-- Fashion + Shipped from Abroad Sales
Fashion Abroad Sales =
CALCULATE(
    [Total Revenue],
    Orders[Product Category] = "Fashion",
    Orders[Delivery Type] = "Shipped from Abroad"
)

-- MoM Growth %
MoM Growth % =
VAR CurrentMonth = [Total Revenue]
VAR PrevMonth = CALCULATE([Total Revenue], DATEADD('Date'[Date], -1, MONTH))
RETURN DIVIDE(CurrentMonth - PrevMonth, PrevMonth, 0) * 100
```

---

## 🗄️ SQL Queries (Advanced)

All 7 queries → [`Amazon_Ecommerce_SQL_Queries.sql`](Amazon_Ecommerce_SQL_Queries.sql)

| # | Question | Concepts Used |
|---|---|---|
| Q1 | Top 5 customers by composite score | CTE, Window Functions, Min-Max Normalization |
| Q2 | Month-over-month revenue growth rate | CTE, LAG(), DATE_FORMAT |
| Q3 | Rolling 3-month average revenue by category | ROWS BETWEEN 2 PRECEDING |
| Q4 | 15% discount for customers with ≥10 orders | UPDATE, Subquery JOIN |
| Q5 | Avg days between consecutive orders | LAG(), DATEDIFF, CTE chain |
| Q6 | Customers with revenue >30% above average | CROSS JOIN, percentage calc |
| Q7 | Top 3 categories — highest YoY sales increase | LAG(), YEAR(), ORDER BY growth |

---

## 📂 Repository Structure

```
Amazon-Ecommerce-Analytics/
│
├── README.md
├── Amazon_Ecommerce_Dashboard.pbix
├── Amazon_Ecommerce_SQL_Queries.sql
├── Amazon_Project_Presentation.pptx
│
└── screenshots/
    ├── main_tab.png
    ├── product_tab.png
    └── individual_product_tab.png
```

---

## 🎯 Dashboard Tab Guide

| Tab | POC | Slicers | Key Visuals |
|---|---|---|---|
| Main Dashboard | Senior Leadership | Year, Product Category | Revenue, Orders, Customers, Rating, Returns, Delivery Days, Trend charts |
| Product Analysis | Category Managers | Product, Gender, Delivery Type, Category | Delivery days by category, Satisfaction distribution, Orders by category |
| Individual Product | Product Owners | Product (search) | Revenue, Avg Price, Quantity, Delivery, Rating gauge, Revenue by location |

---

## 📈 Strategic Recommendations

1. **Loyalty Program** — Bronze / Silver / Gold tiers using composite score (SQL Q1)
2. **Targeted Discounts** — High-price, low-rating products (Electronics <2.5 rating first)
3. **Fix 27% Return Rate** — Audit listings, add size guides, detailed spec sheets
4. **Regional Marketing** — Double down on Greater Accra + Ashanti (47% of revenue)

---

## 🛠️ Tools Used

`Power BI Desktop` · `Power Query (M Language)` · `DAX` · `MySQL` · `Power BI Service` · `PowerPoint`

---

## 👨‍💻 About the Author

**Shivam Gupta**
Data Analytics Student @ Newton School | Team Leader @ Experts of Deals

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat&logo=linkedin)](https://linkedin.com/in/your-profile)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github)](https://github.com/Shivamgupta6388)

---

*⭐ If this project helped you, please give it a star!*
