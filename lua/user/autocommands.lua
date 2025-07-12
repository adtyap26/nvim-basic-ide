vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "sql",
--   callback = function()
--     -- Use a custom namespace instead of overriding the global handler
--     local ns = vim.api.nvim_create_namespace "sql_docs_hover"
--
--     -- Create a buffer-local keymap for K that uses our custom function
--     local bufnr = vim.api.nvim_get_current_buf()
--     vim.keymap.set("n", "K", function()
--       local cursor_word = vim.fn.expand "<cword>"
--
--       local sql_docs = {
--         ["SELECT"] = "Retrieves data from one or more tables.\n\nSyntax: `SELECT column1, column2, ... FROM table_name WHERE condition;`\n\nExamples:\n```sql\n-- Select all columns\nSELECT * FROM customers;\n\n-- Select specific columns\nSELECT first_name, last_name FROM customers;\n\n-- Select with condition\nSELECT * FROM customers WHERE country = 'USA';\n```",
--
--         ["FROM"] = "Specifies the table from which to retrieve data.\n\nUsed with SELECT: `SELECT column1, column2, ... FROM table_name;`\n\nExamples:\n```sql\n-- Basic usage\nSELECT * FROM customers;\n\n-- With table alias\nSELECT c.first_name FROM customers c;\n```",
--
--         ["WHERE"] = "Filters records based on a specified condition.\n\nSyntax: `... WHERE condition;`\n\nExamples:\n```sql\n-- Simple condition\nSELECT * FROM customers WHERE country = 'USA';\n\n-- Multiple conditions\nSELECT * FROM products WHERE price > 50 AND category = 'Electronics';\n\n-- IN operator\nSELECT * FROM customers WHERE country IN ('USA', 'Canada', 'Mexico');\n```",
--
--         ["JOIN"] = "Combines rows from two or more tables based on a related column.\n\nTypes of JOINs:\n- INNER JOIN (default)\n- LEFT JOIN / LEFT OUTER JOIN\n- RIGHT JOIN / RIGHT OUTER JOIN\n- FULL JOIN / FULL OUTER JOIN\n\nSyntax: `... FROM table1 JOIN table2 ON table1.column = table2.column;`\n\nExamples:\n```sql\n-- Inner join\nSELECT orders.order_id, customers.name \nFROM orders \nJOIN customers ON orders.customer_id = customers.id;\n\n-- Left join\nSELECT customers.name, orders.order_id \nFROM customers \nLEFT JOIN orders ON customers.id = orders.customer_id;\n```",
--
--         ["GROUP"] = "Groups the result set (used with GROUP BY).\n\nSyntax: `... GROUP BY column1, column2, ...;`\n\nExamples:\n```sql\n-- Count records by group\nSELECT country, COUNT(*) as customer_count \nFROM customers \nGROUP BY country;\n\n-- Multiple columns\nSELECT country, city, COUNT(*) as customer_count \nFROM customers \nGROUP BY country, city;\n```",
--
--         ["HAVING"] = "Filters records after GROUP BY is applied.\n\nSyntax: `... GROUP BY column HAVING condition;`\n\nExamples:\n```sql\n-- Filter after grouping\nSELECT country, COUNT(*) as customer_count \nFROM customers \nGROUP BY country \nHAVING COUNT(*) > 5;\n\n-- With aggregate functions\nSELECT product_category, AVG(price) as avg_price \nFROM products \nGROUP BY product_category \nHAVING AVG(price) > 100;\n```",
--
--         ["ORDER"] = "Sorts the result set (used with ORDER BY).\n\nSyntax: `... ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;`\n\nExamples:\n```sql\n-- Simple ordering\nSELECT * FROM products ORDER BY price DESC;\n\n-- Multiple columns\nSELECT * FROM customers ORDER BY country ASC, last_name ASC;\n```",
--
--         ["INSERT"] = "Adds new records to a table.\n\nSyntax: \n```sql\nINSERT INTO table_name (column1, column2, ...) \nVALUES (value1, value2, ...);\n```\n\nExamples:\n```sql\n-- Insert a single row\nINSERT INTO customers (first_name, last_name, email) \nVALUES ('John', 'Doe', 'john@example.com');\n\n-- Insert multiple rows\nINSERT INTO products (name, price, category) \nVALUES \n  ('Laptop', 999.99, 'Electronics'),\n  ('Desk Chair', 199.99, 'Furniture');\n```",
--
--         ["UPDATE"] = "Modifies existing records in a table.\n\nSyntax: \n```sql\nUPDATE table_name \nSET column1 = value1, column2 = value2, ... \nWHERE condition;\n```\n\nExamples:\n```sql\n-- Update a single column\nUPDATE customers \nSET status = 'Active' \nWHERE id = 1001;\n\n-- Update multiple columns\nUPDATE products \nSET price = 89.99, stock = 50 \nWHERE product_id = 'P-1000';\n```",
--
--         ["DELETE"] = "Removes records from a table.\n\nSyntax: `DELETE FROM table_name WHERE condition;`\n\nExamples:\n```sql\n-- Delete specific records\nDELECT FROM orders WHERE status = 'Cancelled';\n\n-- Delete with join condition\nDELETE FROM order_items \nWHERE order_id IN (SELECT id FROM orders WHERE status = 'Cancelled');\n```",
--
--         ["CREATE"] = "Creates a new database object (table, index, view, etc.).\n\nSyntax for table: \n```sql\nCREATE TABLE table_name (\n  column1 datatype constraints,\n  column2 datatype constraints,\n  ...\n);\n```\n\nExamples:\n```sql\n-- Create table\nCREATE TABLE employees (\n  id INT PRIMARY KEY,\n  name VARCHAR(100) NOT NULL,\n  hire_date DATE,\n  salary DECIMAL(10,2)\n);\n\n-- Create index\nCREATE INDEX idx_employee_name ON employees(name);\n```",
--
--         ["ALTER"] = "Modifies an existing database object.\n\nSyntax: `ALTER TABLE table_name [action];`\n\nExamples:\n```sql\n-- Add a column\nALTER TABLE employees ADD COLUMN department VARCHAR(50);\n\n-- Modify column\nALTER TABLE employees MODIFY COLUMN salary DECIMAL(12,2);\n\n-- Add constraint\nALTER TABLE orders ADD CONSTRAINT fk_customer \nFOREIGN KEY (customer_id) REFERENCES customers(id);\n```",
--
--         ["DROP"] = "Deletes a database object.\n\nSyntax: `DROP [OBJECT] [name];`\n\nExamples:\n```sql\n-- Drop table\nDROP TABLE old_customers;\n\n-- Drop index\nDROP INDEX idx_employee_name;\n\n-- Drop database\nDROP DATABASE test_db;\n```",
--
--         ["CASE"] = "Provides conditional logic in SQL.\n\nSyntax: \n```sql\nCASE \n  WHEN condition1 THEN result1 \n  WHEN condition2 THEN result2 \n  ... \n  ELSE resultN \nEND\n```\n\nExamples:\n```sql\n-- Simple CASE\nSELECT product_name,\n  CASE \n    WHEN price < 50 THEN 'Budget' \n    WHEN price BETWEEN 50 AND 150 THEN 'Mid-range' \n    ELSE 'Premium' \n  END AS price_category \nFROM products;\n```",
--
--         ["DISTINCT"] = "Removes duplicate values from the result set.\n\nSyntax: `SELECT DISTINCT column1, column2, ... FROM table_name;`\n\nExamples:\n```sql\n-- Simple distinct\nSELECT DISTINCT country FROM customers;\n\n-- Multiple columns\nSELECT DISTINCT country, city FROM customers;\n```",
--
--         ["UNION"] = "Combines the results of two or more SELECT statements (removes duplicates).\n\nSyntax: `SELECT ... UNION SELECT ...;`\n\nExamples:\n```sql\n-- Combine customer and employee lists\nSELECT name, email FROM customers \nUNION \nSELECT name, email FROM employees;\n```",
--
--         ["LIKE"] = "Pattern matching operator used with WHERE clause.\n\nWildcards:\n- % (matches any sequence of characters)\n- _ (matches any single character)\n\nSyntax: `column LIKE pattern`\n\nExamples:\n```sql\n-- Names starting with 'J'\nSELECT * FROM customers WHERE first_name LIKE 'J%';\n\n-- Email containing 'gmail'\nSELECT * FROM customers WHERE email LIKE '%gmail%';\n\n-- Names with exactly 5 characters\nSELECT * FROM customers WHERE first_name LIKE '_____';\n```",
--
--         ["BETWEEN"] = "Tests if a value is within a range of values.\n\nSyntax: `column BETWEEN value1 AND value2;`\n\nExamples:\n```sql\n-- Price range\nSELECT * FROM products WHERE price BETWEEN 10 AND 50;\n\n-- Date range\nSELECT * FROM orders WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31';\n```",
--
--         ["IN"] = "Tests if a value matches any value in a list.\n\nSyntax: `column IN (value1, value2, ...);`\n\nExamples:\n```sql\n-- Match multiple countries\nSELECT * FROM customers WHERE country IN ('USA', 'Canada', 'Mexico');\n\n-- With subquery\nSELECT * FROM products WHERE category_id IN (SELECT id FROM categories WHERE parent_id = 5);\n```",
--
--         ["IS NULL"] = "Tests for NULL values.\n\nSyntax: `column IS NULL` or `column IS NOT NULL`\n\nExamples:\n```sql\n-- Find records with missing phone numbers\nSELECT * FROM customers WHERE phone IS NULL;\n\n-- Find completed orders\nSELECT * FROM orders WHERE completed_date IS NOT NULL;\n```",
--
--         ["COUNT"] = "Counts the number of rows or non-NULL values.\n\nSyntax: `COUNT(expression)` or `COUNT(*)`\n\nExamples:\n```sql\n-- Count all rows\nSELECT COUNT(*) FROM customers;\n\n-- Count non-NULL values\nSELECT COUNT(phone) FROM customers;\n\n-- Count with grouping\nSELECT country, COUNT(*) FROM customers GROUP BY country;\n```",
--
--         ["SUM"] = "Calculates the sum of a set of values.\n\nSyntax: `SUM(expression)`\n\nExamples:\n```sql\n-- Total revenue\nSELECT SUM(amount) FROM orders;\n\n-- Sum by category\nSELECT category, SUM(price) FROM products GROUP BY category;\n```",
--
--         ["AVG"] = "Calculates the average of a set of values.\n\nSyntax: `AVG(expression)`\n\nExamples:\n```sql\n-- Average product price\nSELECT AVG(price) FROM products;\n\n-- Average by category\nSELECT category, AVG(price) FROM products GROUP BY category;\n```",
--
--         ["MIN"] = "Returns the minimum value in a set.\n\nSyntax: `MIN(expression)`\n\nExamples:\n```sql\n-- Cheapest product\nSELECT MIN(price) FROM products;\n\n-- Minimum by category\nSELECT category, MIN(price) FROM products GROUP BY category;\n```",
--
--         ["MAX"] = "Returns the maximum value in a set.\n\nSyntax: `MAX(expression)`\n\nExamples:\n```sql\n-- Most expensive product\nSELECT MAX(price) FROM products;\n\n-- Maximum by category\nSELECT category, MAX(price) FROM products GROUP BY category;\n```",
--
--         ["TRIM"] = "Removes leading and/or trailing characters (typically spaces).\n\nSyntax: `TRIM([LEADING|TRAILING|BOTH] [characters] FROM string)`\n\nExamples:\n```sql\n-- Remove spaces\nSELECT TRIM(' Hello World '); -- Returns 'Hello World'\n\n-- Remove specific characters\nSELECT TRIM(BOTH 'x' FROM 'xxxHello Worldxxx'); -- Returns 'Hello World'\n```",
--
--         ["CONCAT"] = "Combines two or more strings.\n\nSyntax: `CONCAT(string1, string2, ...)`\n\nExamples:\n```sql\n-- Combine first and last name\nSELECT CONCAT(first_name, ' ', last_name) AS full_name FROM customers;\n\n-- Create email addresses\nSELECT CONCAT(username, '@example.com') AS email FROM users;\n```",
--
--         ["SUBSTRING"] = "Extracts a portion of a string.\n\nSyntax: `SUBSTRING(string FROM start [FOR length])`\n\nExamples:\n```sql\n-- Extract first 3 characters\nSELECT SUBSTRING(name FROM 1 FOR 3) FROM products;\n\n-- Extract domain from email\nSELECT SUBSTRING(email FROM POSITION('@' IN email) + 1) FROM users;\n```",
--
--         ["UPPER"] = "Converts a string to uppercase.\n\nSyntax: `UPPER(string)`\n\nExamples:\n```sql\n-- Convert to uppercase\nSELECT UPPER(name) FROM products;\n\n-- Case-insensitive comparison\nSELECT * FROM customers WHERE UPPER(country) = 'USA';\n```",
--
--         ["LOWER"] = "Converts a string to lowercase.\n\nSyntax: `LOWER(string)`\n\nExamples:\n```sql\n-- Convert to lowercase\nSELECT LOWER(email) FROM users;\n\n-- Case-insensitive search\nSELECT * FROM products WHERE LOWER(description) LIKE '%laptop%';\n```",
--
--         ["DATE"] = "Represents or extracts date values.\n\nSyntax varies by database system.\n\nExamples:\n```sql\n-- Extract date components\nSELECT EXTRACT(YEAR FROM order_date) AS year,\n       EXTRACT(MONTH FROM order_date) AS month\nFROM orders;\n\n-- Filter by date\nSELECT * FROM orders WHERE DATE(created_at) = CURRENT_DATE;\n```",
--
--         ["CURRENT_DATE"] = "Returns the current date.\n\nSyntax: `CURRENT_DATE`\n\nExamples:\n```sql\n-- Select orders from today\nSELECT * FROM orders WHERE order_date = CURRENT_DATE;\n\n-- Calculate days since order\nSELECT order_id, CURRENT_DATE - order_date AS days_since_order FROM orders;\n```",
--
--         ["CURRENT_TIMESTAMP"] = "Returns the current date and time.\n\nSyntax: `CURRENT_TIMESTAMP`\n\nExamples:\n```sql\n-- Log current time\nINSERT INTO logs (event, timestamp) VALUES ('system_check', CURRENT_TIMESTAMP);\n\n-- Find recent records\nSELECT * FROM activities WHERE created_at > CURRENT_TIMESTAMP - INTERVAL '1 day';\n```",
--
--         ["INTERVAL"] = "Represents a period of time.\n\nSyntax varies by database system.\n\nExamples:\n```sql\n-- Add time to a date\nSELECT order_date + INTERVAL '7 days' AS due_date FROM orders;\n\n-- Find records from last week\nSELECT * FROM logs WHERE log_time > CURRENT_TIMESTAMP - INTERVAL '7 days';\n```",
--
--         ["COALESCE"] = "Returns the first non-NULL expression.\n\nSyntax: `COALESCE(value1, value2, ...)`\n\nExamples:\n```sql\n-- Use default value for NULL\nSELECT name, COALESCE(phone, 'No Phone Listed') FROM customers;\n\n-- Calculate with fallback\nSELECT product_id, COALESCE(discount_price, regular_price) AS final_price FROM products;\n```",
--
--         ["NULLIF"] = "Returns NULL if two expressions are equal, otherwise returns the first expression.\n\nSyntax: `NULLIF(expr1, expr2)`\n\nExamples:\n```sql\n-- Avoid division by zero\nSELECT amount / NULLIF(quantity, 0) AS unit_price FROM order_items;\n\n-- Convert empty strings to NULL\nSELECT NULLIF(notes, '') FROM orders;\n```",
--
--         ["CAST"] = "Converts a value from one data type to another.\n\nSyntax: `CAST(expression AS datatype)`\n\nExamples:\n```sql\n-- Convert string to number\nSELECT CAST('123' AS INTEGER);\n\n-- Convert to date\nSELECT CAST('2023-05-15' AS DATE);\n```",
--
--         ["LIMIT"] = "Limits the number of rows returned.\n\nSyntax: `... LIMIT count [OFFSET offset]`\n\nExamples:\n```sql\n-- Get top 10 products\nSELECT * FROM products ORDER BY price DESC LIMIT 10;\n\n-- Pagination\nSELECT * FROM customers LIMIT 20 OFFSET 40; -- Page 3 with 20 items per page\n```",
--
--         ["OFFSET"] = "Skips a specified number of rows before returning results.\n\nSyntax: `... OFFSET count`\n\nExamples:\n```sql\n-- Skip first 10 rows\nSELECT * FROM products ORDER BY name OFFSET 10;\n\n-- Used with LIMIT for pagination\nSELECT * FROM customers LIMIT 10 OFFSET 30; -- 4th page, 10 per page\n```",
--
--         ["INDEX"] = "Creates an index on a table column for faster queries.\n\nSyntax: `CREATE INDEX index_name ON table_name (column1, column2, ...)`\n\nExamples:\n```sql\n-- Simple index\nCREATE INDEX idx_customer_email ON customers(email);\n\n-- Composite index\nCREATE INDEX idx_order_customer ON orders(customer_id, order_date);\n```",
--
--         ["VIEW"] = "A virtual table based on the result of a SELECT query.\n\nSyntax: `CREATE VIEW view_name AS SELECT ...`\n\nExamples:\n```sql\n-- Simple view\nCREATE VIEW active_customers AS\nSELECT * FROM customers WHERE status = 'active';\n\n-- Complex view\nCREATE VIEW order_summary AS\nSELECT o.id, c.name, o.total_amount, o.status\nFROM orders o\nJOIN customers c ON o.customer_id = c.id;\n```",
--
--         ["TRANSACTION"] = "A sequence of operations performed as a single logical unit of work.\n\nSyntax: \n```sql\nBEGIN [TRANSACTION];\n-- SQL statements\nCOMMIT; -- or ROLLBACK;\n```\n\nExamples:\n```sql\n-- Simple transaction\nBEGIN;\nUPDATE accounts SET balance = balance - 100 WHERE id = 1;\nUPDATE accounts SET balance = balance + 100 WHERE id = 2;\nCOMMIT;\n```",
--
--         ["COMMIT"] = "Saves all changes made in the current transaction.\n\nSyntax: `COMMIT [TRANSACTION]`\n\nExamples:\n```sql\n-- Complete a transaction\nBEGIN;\nINSERT INTO orders (customer_id, amount) VALUES (101, 199.99);\nINSERT INTO order_items (order_id, product_id, quantity) VALUES (LAST_INSERT_ID(), 5001, 2);\nCOMMIT;\n```",
--
--         ["ROLLBACK"] = "Undoes all changes made in the current transaction.\n\nSyntax: `ROLLBACK [TRANSACTION]`\n\nExamples:\n```sql\n-- Abort a transaction on error\nBEGIN;\nUPDATE inventory SET quantity = quantity - 5 WHERE product_id = 1001;\nIF (SELECT quantity FROM inventory WHERE product_id = 1001) < 0 THEN\n  ROLLBACK;\nELSE\n  COMMIT;\nEND IF;\n```",
--
--         ["FOREIGN KEY"] = "A constraint that links a column to a column in another table.\n\nSyntax: `FOREIGN KEY (column) REFERENCES table(column)`\n\nExamples:\n```sql\n-- Add during table creation\nCREATE TABLE orders (\n  id INT PRIMARY KEY,\n  customer_id INT,\n  FOREIGN KEY (customer_id) REFERENCES customers(id)\n);\n\n-- Add to existing table\nALTER TABLE order_items\nADD CONSTRAINT fk_order\nFOREIGN KEY (order_id) REFERENCES orders(id);\n```",
--
--         ["PRIMARY KEY"] = "A constraint that uniquely identifies each record in a table.\n\nSyntax: `PRIMARY KEY (column1, column2, ...)`\n\nExamples:\n```sql\n-- Single column primary key\nCREATE TABLE customers (\n  id INT PRIMARY KEY,\n  name VARCHAR(100)\n);\n\n-- Composite primary key\nCREATE TABLE order_items (\n  order_id INT,\n  product_id INT,\n  quantity INT,\n  PRIMARY KEY (order_id, product_id)\n);\n```",
--
--         ["UNIQUE"] = "A constraint that ensures all values in a column are different.\n\nSyntax: `UNIQUE (column1, column2, ...)`\n\nExamples:\n```sql\n-- Single column unique constraint\nCREATE TABLE users (\n  id INT PRIMARY KEY,\n  email VARCHAR(100) UNIQUE\n);\n\n-- Composite unique constraint\nCREATE TABLE product_locations (\n  product_id INT,\n  warehouse_id INT,\n  quantity INT,\n  UNIQUE (product_id, warehouse_id)\n);\n```",
--
--         ["CHECK"] = "A constraint that ensures values in a column meet a specific condition.\n\nSyntax: `CHECK (condition)`\n\nExamples:\n```sql\n-- Simple check constraint\nCREATE TABLE products (\n  id INT PRIMARY KEY,\n  price DECIMAL(10,2) CHECK (price > 0)\n);\n\n-- Named check constraint\nCREATE TABLE employees (\n  id INT PRIMARY KEY,\n  age INT,\n  CONSTRAINT valid_age CHECK (age >= 18)\n);\n```",
--
--         ["DEFAULT"] = "Specifies a default value for a column when no value is provided.\n\nSyntax: `column_name data_type DEFAULT value`\n\nExamples:\n```sql\n-- Default timestamp\nCREATE TABLE logs (\n  id INT PRIMARY KEY,\n  message TEXT,\n  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\n);\n\n-- Default status\nCREATE TABLE orders (\n  id INT PRIMARY KEY,\n  customer_id INT,\n  status VARCHAR(20) DEFAULT 'Pending'\n);\n```",
--
--         ["INNER"] = "Returns records that have matching values in both tables.\n\nSyntax: `FROM table1 INNER JOIN table2 ON table1.column = table2.column`\n\nExamples:\n```sql\n-- Basic inner join\nSELECT orders.id, customers.name\nFROM orders\nINNER JOIN customers ON orders.customer_id = customers.id;\n\n-- Multiple joins\nSELECT o.id, c.name, p.name\nFROM orders o\nINNER JOIN customers c ON o.customer_id = c.id\nINNER JOIN order_items oi ON o.id = oi.order_id\nINNER JOIN products p ON oi.product_id = p.id;\n```",
--
--         ["LEFT"] = "Returns all records from the left table and matched records from the right table.\n\nSyntax: `FROM table1 LEFT JOIN table2 ON table1.column = table2.column`\n\nExamples:\n```sql\n-- Find all customers and their orders (if any)\nSELECT c.name, o.id\nFROM customers c\nLEFT JOIN orders o ON c.id = o.customer_id;\n\n-- Find customers without orders\nSELECT c.name\nFROM customers c\nLEFT JOIN orders o ON c.id = o.customer_id\nWHERE o.id IS NULL;\n```",
--
--         ["RIGHT"] = "Returns all records from the right table and matched records from the left table.\n\nSyntax: `FROM table1 RIGHT JOIN table2 ON table1.column = table2.column`\n\nExamples:\n```sql\n-- Find all orders and their customers\nSELECT o.id, c.name\nFROM orders o\nRIGHT JOIN customers c ON o.customer_id = c.id;\n\n-- Find orders without a valid customer\nSELECT o.id\nFROM customers c\nRIGHT JOIN orders o ON c.id = o.customer_id\nWHERE c.id IS NULL;\n```",
--
--         ["FULL"] = "Returns all records when there is a match in either the left or right table.\n\nSyntax: `FROM table1 FULL JOIN table2 ON table1.column = table2.column`\n\nExamples:\n```sql\n-- Get all customers and orders, matching where possible\nSELECT c.name, o.id\nFROM customers c\nFULL JOIN orders o ON c.id = o.customer_id;\n\n-- Find mismatches in both directions\nSELECT c.name, o.id\nFROM customers c\nFULL JOIN orders o ON c.id = o.customer_id\nWHERE c.id IS NULL OR o.customer_id IS NULL;\n```",
--
--         ["CROSS"] = "Returns the Cartesian product of two tables (all possible combinations).\n\nSyntax: `FROM table1 CROSS JOIN table2`\n\nExamples:\n```sql\n-- Generate all possible product-color combinations\nSELECT p.name, c.color\nFROM products p\nCROSS JOIN colors c;\n\n-- Create a numbers table\nSELECT tens.n * 10 + units.n AS number\nFROM \n  (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) AS units(n)\nCROSS JOIN\n  (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) AS tens(n);\n```",
--
--         ["UNION ALL"] = "Combines the results of two or more SELECT statements (includes duplicates).\n\nSyntax: `SELECT ... UNION ALL SELECT ...`\n\nExamples:\n```sql\n-- Combine customer and employee lists with duplicates\nSELECT name, email FROM customers\nUNION ALL\nSELECT name, email FROM employees;\n\n-- Combine current and archived records\nSELECT * FROM current_products\nUNION ALL\nSELECT * FROM archived_products;\n```",
--
--         ["INTERSECT"] = "Returns only the rows that appear in both result sets.\n\nSyntax: `SELECT ... INTERSECT SELECT ...`\n\nExamples:\n```sql\n-- Find customers who are also employees\nSELECT name, email FROM customers\nINTERSECT\nSELECT name, email FROM employees;\n\n-- Find products in both warehouses\nSELECT product_id FROM warehouse1_inventory\nINTERSECT\nSELECT product_id FROM warehouse2_inventory;\n```",
--
--         ["EXCEPT"] = "Returns rows from the first query that do not appear in the second query.\n\nSyntax: `SELECT ... EXCEPT SELECT ...`\n\nExamples:\n```sql\n-- Find customers who are not employees\nSELECT name, email FROM customers\nEXCEPT\nSELECT name, email FROM employees;\n\n-- Find products in warehouse1 but not in warehouse2\nSELECT product_id FROM warehouse1_inventory\nEXCEPT\nSELECT product_id FROM warehouse2_inventory;\n```",
--
--         ["WITH"] = "Creates a temporary named result set (Common Table Expression).\n\nSyntax: `WITH cte_name AS (SELECT ...) SELECT ... FROM cte_name`\n\nExamples:\n```sql\n-- Calculate revenue by category\nWITH revenue_by_product AS (\n  SELECT product_id, SUM(quantity * price) AS revenue\n  FROM order_items\n  GROUP BY product_id\n)\nSELECT c.name, SUM(r.revenue) AS total_revenue\nFROM revenue_by_product r\nJOIN products p ON r.product_id = p.id\nJOIN categories c ON p.category_id = c.id\nGROUP BY c.name;\n\n-- Recursive CTE for hierarchical data\nWITH RECURSIVE category_tree AS (\n  SELECT id, name, parent_id, 0 AS level\n  FROM categories\n  WHERE parent_id IS NULL\n  UNION ALL\n  SELECT c.id, c.name, c.parent_id, ct.level + 1\n  FROM categories c\n  JOIN category_tree ct ON c.parent_id = ct.id\n)\nSELECT id, REPEAT('  ', level) || name AS category\nFROM category_tree\nORDER BY level, name;\n```",
--
--         ["WINDOW"] = "Performs calculations across a set of rows related to the current row.\n\nSyntax: `function() OVER ([PARTITION BY column] [ORDER BY column] [frame_clause])`\n\nExamples:\n```sql\n-- Calculate running total\nSELECT \n  order_date,\n  amount,\n  SUM(amount) OVER (ORDER BY order_date) AS running_total\nFROM orders;\n\n-- Rank products by price within categories\nSELECT \n  category,\n  name,\n  price,\n  RANK() OVER (PARTITION BY category ORDER BY price DESC) AS price_rank\nFROM products;\n```",
--
--         ["RANK"] = "Window function that assigns a rank to each row within a partition.\n\nSyntax: `RANK() OVER ([PARTITION BY column] ORDER BY column)`\n\nExamples:\n```sql\n-- Rank employees by salary\nSELECT \n  name,\n  department,\n  salary,\n  RANK() OVER (ORDER BY salary DESC) AS overall_rank,\n  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank\nFROM employees;\n```",
--
--         ["ROW_NUMBER"] = "Window function that assigns a sequential integer to each row.\n\nSyntax: `ROW_NUMBER() OVER ([PARTITION BY column] ORDER BY column)`\n\nExamples:\n```sql\n-- Number results sequentially\nSELECT \n  ROW_NUMBER() OVER (ORDER BY name) AS row_num,\n  name,\n  price\nFROM products;\n\n-- Get top 3 products per category\nSELECT * FROM (\n  SELECT \n    category,\n    name,\n    price,\n    ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) AS price_rank\n  FROM products\n) ranked\nWHERE price_rank <= 3;\n```",
--       }
--       -- Check if the current word is a SQL keyword (convert to uppercase for case-insensitive matching)
--       local docs = sql_docs[cursor_word:upper()]
--
--       -- If we found documentation for this keyword
--       if docs then
--         -- Show the documentation in a floating window
--         local lines = vim.split("```sql\n" .. cursor_word:upper() .. "\n```\n\n" .. docs, "\n")
--         local buf = vim.api.nvim_create_buf(false, true)
--         vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
--         vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
--
--         -- Calculate window dimensions
--         -- Set a fixed width (adjust as needed) and calculate height based on content
--         local width = 80 -- Fixed width of 80 columns
--         local height = math.min(#lines + 2, 30) -- Increased max height to 30 lines
--
--         -- Calculate position to center the window
--         local win_width = vim.api.nvim_win_get_width(0)
--         local win_height = vim.api.nvim_win_get_height(0)
--
--         local row = math.floor((win_height - height) / 2)
--         local col = math.floor((win_width - width) / 2)
--
--         local opts = {
--           relative = "editor", -- Position relative to editor instead of cursor
--           width = width,
--           height = height,
--           row = row,
--           col = col,
--           style = "minimal",
--           border = "rounded",
--           title = " SQL Documentation: " .. cursor_word:upper() .. " ",
--           title_pos = "center",
--         }
--
--         local win = vim.api.nvim_open_win(buf, false, opts)
--
--         -- Add some highlighting for better readability
--         vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal,FloatBorder:Special")
--
--         -- Close the window with 'q' or Escape
--         vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
--         vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
--
--         -- Set the buffer as non-modifiable
--         vim.api.nvim_buf_set_option(buf, "modifiable", false)
--         vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
--
--         -- Create autocmd to close on cursor move
--         local group = vim.api.nvim_create_augroup("SQLDocsClose_" .. bufnr, { clear = true })
--         vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufHidden", "BufLeave", "InsertEnter" }, {
--           buffer = bufnr,
--           group = group,
--           callback = function()
--             if vim.api.nvim_win_is_valid(win) then
--               vim.api.nvim_win_close(win, true)
--             end
--             vim.api.nvim_del_augroup_by_id(group)
--           end,
--         })
--       else
--         -- Try the default hover handler as fallback
--         vim.lsp.buf.hover()
--       end
--     end, { buffer = bufnr, desc = "Show SQL documentation" })
--   end,
-- })
-- optional

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = { "*.ejs" },
--   callback = function()
--     vim.cmd "set filetype=html"
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "*.php" },
--   callback = function()
--     vim.cmd "set ft=php.html"
--   end,
-- })
