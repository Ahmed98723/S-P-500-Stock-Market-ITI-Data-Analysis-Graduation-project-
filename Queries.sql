--Q1 :  top and worst10 stocks of market cap doc
select *from(

select stock_market_fact.symbol,company_dimension.company_name,market_cap,
rank()over(order by market_cap desc) as rnk_comp
from stock_market_fact,company_dimension
where stock_market_fact.symbol=company_dimension.symbol
)
where rnk_comp<=10

union
select *from(

select stock_market_fact.symbol,company_dimension.company_name,market_cap,
rank()over(order by market_cap ASC) as rnk_comp
from stock_market_fact,company_dimension
where stock_market_fact.symbol=company_dimension.symbol
)
where rnk_comp<=10;

--Q3 : comapring diffrent companies in same industry of price earning
select *from(
select c.company_name,c.sector,sm.price_earning,rank()over(partition by c.sector order by nvl(Price_earning,0 )desc )as rnk
from company_dimension c ,stock_market_fact sm
WHERE sm.symbol=c.symbol)
 where rnk<=5;





--Q3 : the ratio of the price of stock and gold market close price doc
select full_date,gol_close,sp500_close
from(
select d.full_date ,g.close as gol_close,sp.close as sp500_close
from date_dimension d, gold_fact g,sp_idndex_fact sp
where g.full_date=d.full_date
and sp.full_date=sp.full_date 
)
order by full_date ;
--Q claculate  sp gold ratio
select full_date,max(sp_gold_ratio)over(partition by full_date order by full_date asc)from(
select distinct d.full_date , round((sp.close/g.close),2) as sp_gold_ratio
from date_dimension d,sp_idndex_fact sp,gold_fact g
where sp.full_date=d.full_date and 
g.full_date=d.full_date
);




/*Q6 highest price per earning 
in this sector and lowest in his sector for each stock
*/
select c.symbol,c.sector,sm.price_earning,
LAST_VALUE(price_earning)over(PARTITION by sector order by price_earning
rows between unbounded preceding and unbounded following )as high_price_eraning

,LAST_VALUE(price_earning)over(PARTITION by sector order by price_earning desc
rows between unbounded preceding and unbounded following )as lowest_price_eraning
from company_dimension c,stock_market_fact sm
where sm.symbol=c.symbol
order by sector,price_earning ;

--Q7 : calculate s&p 500 index perforamnce change per daily doc
select full_date,symbol,high ,low, open,close,volume,
round((close-open)/open *100,2) as "%change_day"
from daily_monitoring_fact;

-- top 10 price compare 52 week high ,52 week low, price _earning per market cap  doc
select * from(
select c.company_name,market_cap,round(avg(price),2),round(avg(price_earning),2), round(avg(year_high),2),
round(avg(year_low),2),rank()over(order by s.market_cap desc)as rnk
from company_dimension c, stock_market_fact s
where s.symbol=c.symbol
group by c.company_name,market_cap)
where rnk<=10;
--Q worest 10 price rice compare 52 week high ,52 week low, price _earning per market cap
select * from(
select c.company_name,market_cap,round(avg(price),2),round(avg(price_earning),2), round(avg(year_high),2),
round(avg(year_low),2),rank()over(order by s.market_cap asc)as rnk
from company_dimension c, stock_market_fact s
where s.symbol=c.symbol
group by c.company_name,market_cap)
where rnk<=10;

--Q9 :top 10 dividend group 
select *from(
select c.company_name,s.dividend_yield, round(s.dividend_yield*price,2 )as Annual_dividend ,
round((s.dividend_yield*s.price)/s.earning_share,2) as payout_ratio,s.market_cap,
rank()over(order by market_cap desc)as top_worst10_devidend_group
from company_dimension c,stock_market_fact s
where s.symbol=c.symbol
)
where top_worst10_devidend_group<=10

union

select *from(
select c.company_name,s.dividend_yield, round(s.dividend_yield*price,2 )as Annual_dividend ,
round((s.dividend_yield*s.price)/s.earning_share,2) as payout_ratio,s.market_cap,
rank()over(order by market_cap )as top_worst10_devidend_group
from company_dimension c,stock_market_fact s
where s.symbol=c.symbol
)
where top_worst10_devidend_group<=10;





