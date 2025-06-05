DROP TABLE IF EXISTS public.app_tasks;

CREATE TABLE IF NOT exists public.app_tasks (
	id SERIAL NOT NULL,
	task text NULL,
	dtime timestamp DEFAULT now() NULL
);
insert into public.app_tasks (task) values ('Задача номер один');
insert into public.app_tasks (task) values ('Давайте жить дружно!');
