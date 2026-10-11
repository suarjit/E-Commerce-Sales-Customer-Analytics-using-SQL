# E-Commerce-Sales-Customer-Analytics-using-SQL
# E-Commerce Sales & Customer Behavior Analysis using Python

## 1. Project Objective

The objective of this project is to analyze e-commerce sales data and customer purchasing behavior using Python. The project aims to identify top-performing products, high-revenue countries, valuable customers, sales trends, cancellation patterns, and changes in product demand.

The analysis helps understand business performance, discover sales opportunities, and support data-driven decisions related to inventory management, marketing strategies, and customer retention.

## 2. Dataset

**Dataset Name:** Online Retail

**File Name:** `Online Retail.csv`

The dataset contains transactional records from an online retail business. Each row represents a product line within an invoice.

The analysis uses the following columns:

- **InvoiceNo:** Unique invoice number used to identify transactions.
- **StockCode:** Product identification code.
- **Description:** Name or description of the product.
- **Quantity:** Number of units purchased.
- **InvoiceDate:** Date and time of the transaction.
- **UnitPrice:** Price per unit in pounds sterling (£).
- **CustomerID:** Unique identifier of the customer.
- **Country:** Country associated with the transaction.

Two additional columns are created during data preparation:

- **IsCancelled:** Identifies invoices whose invoice numbers begin with the letter `C`.
- **Revenue:** Calculates the revenue for each product line by multiplying quantity by unit price.

## 3. Analysis Performed

### A. Data Cleaning and Preparation

- Checked for missing values and duplicate records.
- Removed exact duplicate rows.
- Standardized text columns by removing unnecessary spaces.
- Converted invoice dates and numerical columns to appropriate data types.
- Identified cancelled invoices.
- Calculated revenue for each transaction line.
- Filtered out cancelled invoices, non-positive quantities, non-positive prices, invalid dates, and rows without product descriptions.

### B. Product Sales Analysis

- Identified the top 10 products by total revenue.
- Calculated the total quantity sold and number of invoices for each product.
- Identified the products with the highest sales quantities.
- Visualized product performance using bar charts.

### C. Country-Wise Sales Analysis

- Calculated total revenue for each country.
- Compared the number of orders and unique customers across countries.
- Identified the top 10 countries by revenue.
- Used bar charts to compare country-level sales performance.

### D. Monthly and Weekly Sales Trends

- Calculated monthly revenue, quantity sold, and order counts.
- Analyzed weekly revenue trends.
- Created line charts to observe changes in sales over time.
- Examined trends that can support inventory planning and seasonal business decisions.

### E. Average Order Value Analysis

- Calculated the total value of each invoice.
- Measured the average and median order values.
- Examined the distribution of order values using a histogram.
- Used the results to understand typical order sizes and variations in customer spending.

### F. Customer Analysis

- Calculated total spending, number of orders, total quantity purchased, and last purchase date for each customer.
- Identified the top 10 customers by total spending.
- Visualized the highest-spending customers using a bar chart.

### G. Outlier and Unusual Transaction Analysis

- Applied the Interquartile Range (IQR) method to identify potential outliers in quantity, unit price, line revenue, and order value.
- Displayed the highest-revenue transaction lines.
- Used box plots to visualize unusual values.
- Highlighted transactions that may require further investigation.

### H. Invoice Cancellation Analysis

- Identified cancelled invoices using invoice numbers beginning with `C`.
- Calculated the total number of unique invoices.
- Measured the number and percentage of cancelled invoices.
- Compared cancelled and non-cancelled invoices using a bar chart.

### I. Product Demand Analysis

- Compared product quantities sold during the first and second halves of the available monthly periods.
- Identified products with the largest increases and decreases in demand.
- Calculated absolute and percentage changes in quantity sold.
- Visualized products with significant demand changes.

### J. Price and Quantity Relationship

- Examined the relationship between product unit prices and quantities purchased.
- Calculated Pearson and Spearman correlation coefficients.
- Used a scatter plot to visualize the relationship between price and quantity.
- Evaluated whether the variables showed a positive or negative association.

### K. Exploratory Data Analysis (EDA)

- Generated descriptive statistics for quantity, unit price, and revenue.
- Created a country-by-month revenue summary using a pivot table.
- Constructed a correlation heatmap to examine relationships among quantity, unit price, and revenue.
- Used statistical summaries and visualizations to understand the overall sales distribution.

## 4. Key Findings

The following findings are generated dynamically when the notebook runs on the dataset:

1. **Top-Performing Products:** The analysis identifies the products generating the highest total revenue and the products selling in the largest quantities.
2. **Leading Countries:** Country-wise comparisons reveal which countries contribute the most revenue, along with their order and customer counts.
3. **Sales Trends:** Monthly and weekly analysis highlights changes in revenue and sales volume over time.
4. **Customer Spending:** Customer-level analysis identifies the highest-spending customers and summarizes their purchasing activity.
5. **Order Value:** Average and median order values help describe customer spending patterns.
6. **Cancellations:** The cancellation analysis measures the proportion of unique invoices classified as cancelled.
7. **Demand Changes:** Comparing two time periods reveals products with increasing or decreasing sales quantities.
8. **Unusual Transactions:** The IQR method identifies potential outliers that may represent exceptional transactions or records requiring review.
9. **Price–Quantity Relationship:** Pearson and Spearman correlations measure the strength and direction of the association between unit price and quantity purchased.

*Note: Exact numerical findings and product or country names should be taken from the notebook outputs after executing the analysis. They are not hard-coded in this README.*

## 5. Important Insights

The analysis can help the business make the following decisions:

- **Inventory Management:** Maintain adequate stock of products that generate high revenue or have strong demand.
- **Marketing Strategy:** Focus marketing efforts on countries with strong sales potential, using revenue, order counts, and customer counts together.
- **Sales Planning:** Use monthly and weekly sales trends to improve stock planning and prepare for changes in demand.
- **Customer Retention:** Develop loyalty programs and targeted campaigns for high-value customers.
- **Order Value Improvement:** Explore suitable product bundles and complementary product recommendations to encourage additional purchases.
- **Cancellation Monitoring:** Investigate cancellation patterns to identify possible operational or customer-service issues.
- **Demand Forecasting:** Monitor products with rising or declining sales quantities to support purchasing and promotional decisions.
- **Transaction Review:** Investigate unusually large quantities, prices, revenues, or order values instead of automatically treating outliers as errors.
- **Pricing Decisions:** Use correlation results as supporting evidence when reviewing pricing strategies. Correlation alone does not establish causation.

## 6. Tools and Technologies Used

- **Python:** Core programming language.
- **Pandas:** Data cleaning, transformation, grouping, and aggregation.
- **NumPy:** Numerical operations and calculations.
- **Matplotlib:** Data visualization.
- **Seaborn:** Statistical charts and visualizations.
- **Google Colab / Jupyter Notebook:** Development and execution environment.

## 7. Project Outcome

This project demonstrates how Python can be used to clean, analyze, and visualize e-commerce transaction data. It combines sales performance analysis, customer behavior analysis, time-series exploration, cancellation monitoring, and outlier detection to produce useful business insights.

The results provide a foundation for more informed decisions about inventory, marketing, customer retention, and sales planning.

## 8. Conclusion

The E-Commerce Sales & Customer Behavior Analysis project transforms raw retail transaction data into meaningful business information through data cleaning, exploratory data analysis, statistical calculations, and visualizations.

By examining product performance, country-wise revenue, customer spending, order values, sales trends, and demand changes, the project helps identify opportunities for improving business performance and making data-driven decisions.