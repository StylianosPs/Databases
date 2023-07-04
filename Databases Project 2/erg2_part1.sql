-- 1
select u.name, u.review_count, u.yelping_since
from user u
where u.name = 'Lisa' and u.review_count > 500
order by u.yelping_since;


-- 2
select r.user_id, u.name, r.business_id, b.name, r.review_id
from reviews r, user u, business b
where u.name = 'Lisa' and u.user_id = r.user_id and r.business_id = b.business_id and b.name = 'Gab & Eat';
 
 -- 3
 select 'YES' as answer
 from reviews r, reviews_pos_neg rpn
 where r.business_id='OmpbTu4deR3ByOo7btTTZw' and r.review_id=rpn.review_id and rpn.positive='1'
 union
 select 'NO' as answer
 where 0=(select count(*)
  	      from reviews r, reviews_pos_neg rpn
		  where r.business_id='OmpbTu4deR3ByOo7btTTZw' and r.review_id=rpn.review_id and rpn.positive='1' );


-- 4
select distinct r.business_id, count(rpn.positive)
from reviews r, reviews_pos_neg rpn 
where r.review_id = rpn.review_id and r.date like '2014%' 
group by r.business_id
having count(rpn.positive) > 10
order by business_id ASC;


-- 5
select r.user_id, count(*)
from user u, reviews r
where r.user_id = u.user_id and r.business_id in	(select b.business_id
						from business_category b, category c
						where b.category_id = c.category_id and c.category = 'Mobile Phones')
group by r.user_id 
order by u.user_id ASC;


-- 6
select r.votes_useful, r.user_id, r.business_id
from reviews r, user u
where r.user_id = u.user_id and r.business_id in (select b.business_id from business b where b.name = 'Midas')
order by r.votes_useful DESC;






