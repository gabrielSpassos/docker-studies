create table if not exists account (
    id              uuid not null primary key default gen_random_uuid(),
    user_id         varchar(50) not null,
    account_number  varchar(50) not null,
    created_at      timestamptz not null,
    updated_at      timestamptz not null
);

insert into account (user_id, account_number, created_at, updated_at)
values
('2b0a0a4e-dd36-46c0-a7ed-a324c7b88dce', '1234', now(), now()),
('36d8a7b3-8573-427b-a964-959a0fc0d23c', '5678', now(), now()),
('f3f742fc-e1e5-4b70-b703-e4ad37cfe612', '9876', now(), now());

-- duplicating first two above inserts
insert into account (user_id, account_number, created_at, updated_at)
values
('2b0a0a4e-dd36-46c0-a7ed-a324c7b88dce', '1234', now(), now()),
('36d8a7b3-8573-427b-a964-959a0fc0d23c', '5678', now(), now());

-- triplicating last insert
insert into account (user_id, account_number, created_at, updated_at)
values
('36d8a7b3-8573-427b-a964-959a0fc0d23c', '5678', now(), now());
