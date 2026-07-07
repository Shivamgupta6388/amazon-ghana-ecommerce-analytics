<div align="center">

# 🛒 Amazon Ghana E-Commerce Analytics Dashboard

### End-to-End Data Analytics Project | Power BI · SQL · DAX · Power Query

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Power Query](https://img.shields.io/badge/Power%20Query-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)

**[🔗 Live Dashboard →](https://app.powerbi.com/YOUR_LINK_HERE)**&nbsp;&nbsp;&nbsp;
**[📄 View Document →](docs/E-Commerce_Document_by_Shivam_Gupta.docx)**

</div>

---

## 📸 Dashboard Preview

### 1️⃣ Main Dashboard
![Main Dashboard](assets/main_dashboard.png)

### 2️⃣ Product Analysis
![Product Analysis](assets/product_analysis.png)

### 3️⃣ Individual Product
![Individual Product](assets/individual_product.png)

---

## 📌 Project Summary

> Analyzed **113,000+ orders** across **6 years (2015–2020)** from Ghana's e-commerce market to uncover revenue patterns, customer behavior, product performance, and delivery inefficiencies — built as a 3-tab interactive Power BI dashboard with Amazon's signature dark theme.

| Metric | Value |
|--------|-------|
| 💰 Total Revenue | **₵107.24 Million** |
| 📦 Total Orders | **113,000+** |
| 🔁 Return Rate | **27.01%** |
| ⭐ Avg Product Rating | **2.73 / 5** |
| 🚚 Avg Delivery Days | **9.53 days** |
| 🛍️ Unique Products | **44** |
| 📍 Locations Covered | **26 (across Ghana)** |
| 👥 Customers (2020) | **25,179** (highest ever) |

---

## 🎯 Business Questions Answered

- Which product categories drive the most revenue — and which disappoint customers?
- Why is the return rate 27%? What are the top return reasons?
- How do customer segments (Bronze → Platinum) compare in revenue contribution?
- How does delivery type (Express / Standard / Shipped from Abroad) affect customer satisfaction?
- What is the total sales for Fashion category shipped from Abroad?
- How does revenue compare month-over-month vs previous year?

---

## 🗂️ Dashboard Pages

### 1️⃣ Main Dashboard — Executive Overview
High-level KPI summary for leadership — total revenue, orders, return rate, ratings, and trends.

**Key Visuals:**
- 4 KPI Cards → Total Revenue · Total Orders · Return Rate % · Avg Rating
- Revenue by Year (Bar Chart)
- Total Orders by Product Category (Donut Chart)
- Revenue by Month (Line Chart)
- Orders by Zone (Horizontal Bar Chart)
- Top 5 Products Table

**Slicers:** Year · Zone · Delivery Type · Product Category · Customer Gender

---

### 2️⃣ Product Analysis — Category Deep Dive
Analyze all product categories side by side — performance, delivery, and customer satisfaction.

**Key Visuals:**
- Revenue by Category
- Customer Satisfaction by Category
- Avg Delivery Days by Category
- Delivery Type wise Orders (Donut)

**Slicers:** Year · Product Category · Delivery Type

---

### 3️⃣ Individual Product — Product Drill-Down
Select any single product and see all its metrics update instantly.

**Key Visuals:**
- Product Selector (Dropdown Slicer)
- KPI Cards → Revenue · Orders · Returns · Avg Rating
- Revenue by Month (Line Chart)
- Rating Distribution

---

## 🛠️ Tools & Technologies

| Layer | Tool | Purpose |
|-------|------|---------|
| **Data Storage** | MySQL 8.0 | Raw data + 7 advanced SQL queries |
| **Data Cleaning** | Power Query (M Language) | Null handling, type fixes, Group By merge |
| **Data Model** | Power BI Desktop | Star schema — Orders ↔ Customers ↔ Calendar |
| **Calculations** | DAX | 10+ measures: Time Intelligence, CALCULATE, FILTER |
| **Visualization** | Power BI Service | 3-tab interactive dashboard, published online |

---

## 🗃️ Data Model

```
┌─────────────┐         ┌──────────────────┐         ┌──────────────┐
│  Customers  │────────▶│      Orders      │◀────────│   Calendar   │
│─────────────│  1:Many │──────────────────│  1:Many │──────────────│
│ CustomerID  │         │ OrderID (PK)     │         │ Date (PK)    │
│ Customer Age│         │ CustomerID (FK)  │         │ Year         │
│ Customer    │         │ OrderDate        │         │ Month        │
│   Gender    │         │ Delivery Date    │         │ Quarter      │
└─────────────┘         │ Product Category │         └──────────────┘
                        │ SubCategory      │
                        │ Product          │
                        │ Unit Price       │
                        │ Sale Price       │
                        │ Order Quantity   │
                        │ Shipping Fee     │
                        │ Delivery Type    │
                        │ Zone / Location  │
                        │ Status           │
                        │ Reason           │
                        │ Rating           │
                        │ Delivery Days ✦  │
                        └──────────────────┘
✦ = Calculated Column (DAX)
```

---

## 📐 DAX Measures Used

```dax
-- Total Revenue
Total Revenue = SUM(Orders[Sale Price])

-- Total Orders
Total Orders = DISTINCTCOUNT(Orders[OrderID])

-- Return Rate %
Return Rate % =
DIVIDE(
    COUNTROWS(FILTER(Orders, Orders[Status] = "Returned")),
    DISTINCTCOUNT(Orders[OrderID]),
    0
) * 100

-- Avg Rating
Avg Rating = AVERAGE(Orders[Rating])

-- Avg Order Value
Avg Order Value = DIVIDE([Total Revenue], [Total Orders], 0)

-- Avg Delivery Days (Delivered orders only)
Avg Delivery Days =
CALCULATE(
    AVERAGE(Orders[Delivery Days]),
    Orders[Status] = "Delivered"
)

-- Unique Customers
Unique Customers = DISTINCTCOUNT(Orders[CustomerID])

-- Fashion + Shipped from Abroad Sales
Fashion Abroad Sales =
CALCULATE(
    [Total Revenue],
    FILTER(Orders, Orders[Product Category] = "Fashion"),
    FILTER(Orders, Orders[Delivery Type] = "Shipped from Abroad")
)
-- Result: ₵4 Million

-- Previous Year Sales (Time Intelligence)
Previous Year Sales =
CALCULATE(
    [Total Revenue],
    SAMEPERIODLASTYEAR(Calendar[Date])
)
```

---

## 📊 Calculated Columns

```dax
-- Delivery Duration
Delivery Days = DATEDIFF(Orders[OrderDate], Orders[Delivery Date], DAY)

-- Customer Loyalty Tier
Customer Category =
IF(Orders[Revenue per Customer] >= 5000, "Platinum",
IF(Orders[Revenue per Customer] >= 2000, "Gold",
IF(Orders[Revenue per Customer] >= 500, "Silver", "Bronze")))
```

---

## 💡 Key Insights

### 1. Return Rate is a Description Problem
> 27% of all orders are returned. The #1 reason is **"Description Mismatch"** — not delivery delays or defects. This is a product listing accuracy issue.

### 2. 2020 Was a Breakout Year
> Unique customers jumped to **25,179 in 2020** — the highest in 6 years — indicating strong market growth.

### 3. Platinum Customers = Hidden Revenue Engine
> Only **~3K Platinum customers** generate revenue comparable to **87K Bronze customers**. Retaining high-value customers is priority #1.

### 4. Express Delivery = Higher Satisfaction
> Express delivery = **3.5 days avg**. Standard delivery = **10 days**, same cost. Customers are dissatisfied — pricing strategy needs review.

### 5. Fashion + Shipped from Abroad = ₵4M Revenue
> This niche cross-segment generates significant revenue and deserves targeted promotions.

---

## 📁 Repository Structure

```
amazon-ghana-ecommerce-analytics/
│
├── 📊 dashboard/
│   └── Amazon_Ecommerce_Dashboard_Shivam_Gupta.pbix
│
├── 🗄️ sql/
│   └── queries.sql
│
├── 📂 data/
│   └── Ecommerce Dataset.xlsx
│
├── 📑 docs/
│   ├── E-Commerce_Document_by_Shivam_Gupta.docx
│   └── E-COMMERCE_ANALYSIS_by_Shivam_Gupta.pptx
│
├── 🖼️ assets/
│   ├── main_dashboard.png
│   ├── product_analysis.png
│   └── individual_product.png
│
└── 📄 README.md
```

---

## 🚀 How to Use

### View the Live Dashboard
Click **[🔗 Live Dashboard](https://app.powerbi.com/YOUR_LINK_HERE)** — no login required.

### Run Locally in Power BI Desktop
1. Download `dashboard/Amazon_Ecommerce_Dashboard_Shivam_Gupta.pbix`
2. Open with **Power BI Desktop** (free — download from Microsoft)
3. If data doesn't load → `Transform Data → Data Source Settings` → update file path

### Explore the SQL Queries
```sql
CREATE DATABASE amazon_ecommerce;
USE amazon_ecommerce;
-- Import via MySQL Workbench → Table Data Import Wizard
-- Then run sql/queries.sql
```

---

## 📊 Recommendations

| Priority | Area | Recommendation |
|----------|------|----------------|
| 🔴 High | Returns | Fix product descriptions — 27% return rate from mismatch |
| 🔴 High | Customers | Convert Bronze → Silver with targeted discounts |
| 🟡 Medium | Delivery | Differentiate pricing: Express vs Standard (same cost, 3x speed difference) |
| 🟡 Medium | High-Value | Retention program for 3K Platinum customers |
| 🟢 Low | International | Promote Fashion + Shipped from Abroad (₵4M opportunity) |

---

## 👤 About

**Shivam Gupta**
Data Analyst | Power BI · SQL · DAX · Power Query

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/shivam-gupta-6b72b5238)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)](https://github.com/Shivamgupta6388)

---

<div align="center">

*Built as part of Newton School — Data Science Professional Certificate*

⭐ **Star this repo if you found it helpful!**

</div>
