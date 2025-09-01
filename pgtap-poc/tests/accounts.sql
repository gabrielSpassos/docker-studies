SET search_path TO public;

SELECT plan(3);

SELECT has_table('accounts', 'accounts table exists');
SELECT has_column('accounts', 'user_id', 'users.user_id exists');
SELECT col_not_null('accounts', 'user_id', 'user_id column is NOT NULL');

SELECT * FROM finish();
