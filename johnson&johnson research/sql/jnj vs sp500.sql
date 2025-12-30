{\rtf1\ansi\ansicpg1252\cocoartf2821
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
-- Builds monthly returns for JNJ and S&P 500\
-- and joins them with 10Y Treasury rate changes\
\
WITH jnj_m AS (\
  SELECT\
    date_trunc('month', date)::date AS month,\
    AVG(close) AS jnj_level\
  FROM jnj\
  GROUP BY 1\
),\
spx_m AS (\
  SELECT\
    date_trunc('month', date)::date AS month,\
    AVG(sp500) AS spx_level\
  FROM sp500\
  GROUP BY 1\
),\
fed_m AS (\
  SELECT\
    date_trunc('month', date)::date AS month,\
    AVG(fedfunds) AS fedfunds_rate\
  FROM fedfunds\
  GROUP BY 1\
),\
base AS (\
  SELECT\
    j.month,\
    j.jnj_level,\
    s.spx_level,\
    f.fedfunds_rate\
  FROM jnj_m j\
  JOIN spx_m s ON s.month = j.month\
  JOIN fed_m f ON f.month = j.month\
),\
calc AS (\
  SELECT\
    month,\
    (jnj_level / LAG(jnj_level) OVER (ORDER BY month) - 1) AS jnj_ret,\
    (spx_level / LAG(spx_level) OVER (ORDER BY month) - 1) AS spx_ret,\
    (fedfunds_rate - LAG(fedfunds_rate) OVER (ORDER BY month)) AS rate_change\
  FROM base\
)\
SELECT\
  CASE\
    WHEN rate_change > 0 THEN 'Rate Hike'\
    WHEN rate_change < 0 THEN 'Rate Cut'\
    ELSE 'No Change'\
  END AS rate_regime,\
  COUNT(*) AS observations,\
  AVG(jnj_ret) AS avg_jnj_return,\
  AVG(spx_ret) AS avg_spx_return,\
  AVG(jnj_ret - spx_ret) AS avg_jnj_minus_spx\
FROM calc\
WHERE jnj_ret IS NOT NULL\
  AND spx_ret IS NOT NULL\
  AND rate_change IS NOT NULL\
GROUP BY 1\
ORDER BY 1;}