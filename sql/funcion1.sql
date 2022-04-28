CREATE OR REPLACE FUNCTION public.create_sale(
		IN param_beer_ids integer[],
		IN param_account_id integer,
        IN param_sale_id uuid,
		IN param_sale_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
	)
	RETURNS sale
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	out_sale sale;
    var_beer_id integer;
    var_beer_price numeric;
	var_sale_price_amount numeric := 0;
BEGIN

    -- Checking account exists
	IF NOT EXISTS(SELECT * FROM accounts WHERE account_id=param_account_id) THEN
		out_sale.out_status := 'account_id_not_found';
		RETURN out_sale;
	END IF;

    -- Creates a sale
    INSERT INTO sales(sale_id,sale_date) VALUES(param_sale_id, param_sale_date);

    -- Stores all the beer sales in one
    FOREACH var_beer_id IN ARRAY param_beer_ids
    LOOP
        SELECT price INTO var_beer_price FROM beers WHERE beer_id=var_beer_id;
        IF var_beer_price IS NULL THEN
            out_sale.out_status := 'beer_not_found';
			RETURN out_sale;
        ELSE
            var_sale_price_amount := var_sale_price_amount + var_beer_price;
            INSERT INTO bills(sale_id,beer_id) VALUES(param_sale_id,var_beer_id);
        END IF;
    END LOOP;

    -- Updating account capital
    UPDATE accounts SET capital = capital + var_sale_price_amount WHERE account_id = param_account_id;
	
    out_sale.sale_id := param_sale_id;
    out_sale.sale_date := param_sale_date;
    out_sale.account_id := param_account_id;
	out_sale.out_status := 'succeed';
	RETURN out_sale;
END