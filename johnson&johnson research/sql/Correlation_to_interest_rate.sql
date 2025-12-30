{\rtf1\ansi\ansicpg1252\cocoartf2821
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
\'97FINDs the correlation coefficient of JNJ returns to changes in interest rate \
-FINDS the correlation coefficient of SP500 returns to changes in interest rate\
\
WITH j AS (\
  SELECT\
    date_trunc('month', date)::date AS month,\
    close\
  FROM jnj\
),\
s AS (\
  SELECT\
    date_trunc('month', date)::date AS month,\
    sp500\
  FROM sp500\
),\
f AS (\
  SELECT\
    date_trunc('month', date)::date AS month,\
    fedfunds\
  FROM fedfunds\
),\
base AS (\
  SELECT\
    j.month,\
    j.close AS jnj_close,\
    s.sp500 AS spx_level,\
    f.fedfunds AS fedfunds_rate\
  FROM j\
  JOIN s ON s.month = j.month\
  JOIN f ON f.month = j.month\
),\
calc AS (\
  SELECT\
    month,\
    (jnj_close / LAG(jnj_close) OVER (ORDER BY month) - 1) AS jnj_ret,\
    (spx_level / LAG(spx_level) OVER (ORDER BY month) - 1) AS spx_ret,\
    (fedfunds_rate - LAG(fedfunds_rate) OVER (ORDER BY month)) AS rate_change\
  FROM base\
)\
SELECT\
  COUNT(*) FILTER (\
    WHERE jnj_ret IS NOT NULL\
      AND spx_ret IS NOT NULL\
      AND rate_change IS NOT NULL\
  ) AS usable_rows,\
  corr(jnj_ret, rate_change) AS corr_jnj_vs_ratechg,\
  corr(spx_ret, rate_change) AS corr_spx_vs_ratechg\
FROM calc;\
}