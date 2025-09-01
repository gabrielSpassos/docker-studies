SET search_path TO public;

SELECT plan(6);

SELECT has_table('users', 'users table exists');
SELECT has_column('users', 'email', 'users.email exists');
SELECT col_is_unique('users', 'email', 'email must be unique');
SELECT has_column('users', 'balance', 'users.balance exists');
SELECT col_not_null('users', 'balance', 'balance column is NOT NULL');
SELECT col_has_default('users', 'balance', 'balance has default value');

SELECT * FROM finish();
