# Interest-Rate-Sensitivity-of-Johnson-Johnson-vs.-the-S-P-500
When the Federal Reserve raises interest rates, the stock market often reacts fast and sometimes violently. But does a massive healthcare company like Johnson & Johnson move the same way as the broader S&P 500, or does it behave differently?

## Project Description
This project explores whether Johnson & Johnson reacts differently to U.S. interest rate changes than the broader stock market. We use historical data on U.S. interest rates along with monthly returns for Johnson & Johnson and the S&P 500 to directly compare how each responds when interest rates rise or fall. This question matters because interest rate increases often create uncertainty for investors, and understanding whether a large healthcare company like Johnson & Johnson is less affected can explain why some stocks are viewed as safer during tightening cycles. 
## Research Question
How does Johnson & Johnson’s stock respond to U.S. Federal Reserve interest rate changes compared to the overall S&P 500?

<img width="1524" height="684" alt="65321fadc28038b7e1354b6a_Johnson   Johnson" src="https://github.com/user-attachments/assets/11235f8f-d72c-4b6b-a2b1-021b9082f741" />

## Hypothesis
Johnson & Johnson’s stock is less sensitive to U.S. interest rate increases than the S&P 500 due to its stable cash flows, diversified business model, and defensive role within the healthcare sector.

## Data Sources
- U.S. Treasury interest rate data (Federal Reserve Economic Data – FRED)
- Monthly adjusted closing prices for:
  - Johnson & Johnson (JNJ)
  - S&P 500 Index
- Data sourced via Yahoo Finance

## Methodology
1. Collected historical U.S. interest rate data and monthly stock price data.
2. Calculated monthly returns for Johnson & Johnson and the S&P 500.
3. Joined interest rate data with equity returns using SQL.
4. Analyzed correlations between interest rate changes and stock returns.
5. Compared performance across rising and falling interest rate environments.
6. Visualized trends and relationships using charts.


## Key Findings
- 	•	Johnson & Johnson’s monthly returns generally track the S&P 500, but with noticeably lower volatility, indicating its defensive characteristics relative to the broader market.
  
	•	Changes in the federal funds rate do not contemporaneously drive stock returns for either Johnson & Johnson or the S&P 500, as evidenced by weak scatter relationships.

	•	Major adjustments in the federal funds rate tend to occur after periods of significant market volatility, particularly during early 2020, suggesting that monetary policy reacts to market stress rather than leading it.

	•	During the COVID-19 shock, equity returns declined sharply before the Federal Reserve implemented aggressive rate cuts, reinforcing the presence of a policy response lag.

	•	Comparative analysis shows that Johnson & Johnson’s sensitivity to interest rate changes is similar to or weaker than that of the overall market, consistent with its classification as a large-cap, defensive healthcare stock.

## Tools & Technologies
- SQL (PostgreSQL)
- EXCEL 
- CSV DATA
- Relational databases (FEDERAL RESERVE BANK of ST.LOUIS)
- Git & GitHub








