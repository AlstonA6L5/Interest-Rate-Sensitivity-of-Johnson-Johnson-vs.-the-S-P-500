{\rtf1\ansi\ansicpg1252\cocoartf2821
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \'97monthly rate compare between sp500, fedfunds, and jaj\
\
WITH\
j AS (\
  SELECT\
    date_trunc('month', date)::date AS month,\
    AVG(close)::double precision AS jnj_close\
  FROM public.jnj_clean\
  GROUP BY 1\
),\
s AS (\
  SELECT\
    date_trunc('month', date)::date AS month,\
    AVG(index_level)::double precision AS spx_level\
  FROM public.sp500\
  GROUP BY 1\
),\
f AS (\
  SELECT\
    date_trunc('month', date)::date AS month,\
    AVG(rate)::double precision AS fedfunds_rate\
  FROM public.fedfunds\
  GROUP BY 1\
),\
base AS (\
  SELECT j.month, j.jnj_close, s.spx_level, f.fedfunds_rate\
  FROM j JOIN s USING (month) JOIN f USING (month)\
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
  month,\
  jnj_ret,\
  spx_ret,\
  rate_change\
FROM calc\
WHERE jnj_ret IS NOT NULL\
  AND spx_ret IS NOT NULL\
  AND rate_change IS NOT NULL\
ORDER BY month;}