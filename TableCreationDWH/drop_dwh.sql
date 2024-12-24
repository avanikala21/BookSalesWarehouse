DO $$ 
DECLARE
  r RECORD;
BEGIN
  FOR r IN (SELECT conname, conrelid::regclass FROM pg_constraint WHERE contype = 'f') 
  LOOP
    EXECUTE 'ALTER TABLE ' || r.conrelid || ' DROP CONSTRAINT ' || r.conname;
  END LOOP;
END $$;


DO $$ 
DECLARE
  r RECORD;
BEGIN
  FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
  LOOP
    EXECUTE 'DROP TABLE IF EXISTS public.' || r.tablename || ' CASCADE';
  END LOOP;
END $$;


DO $$ 
DECLARE
  r RECORD;
BEGIN
  FOR r IN (SELECT sequencename FROM pg_sequences WHERE schemaname = 'public') 
  LOOP
    EXECUTE 'DROP SEQUENCE IF EXISTS public.' || r.sequencename;
  END LOOP;
END $$;


DO $$ 
DECLARE
  r RECORD;
BEGIN
  FOR r IN (SELECT viewname FROM pg_views WHERE schemaname = 'public') 
  LOOP
    EXECUTE 'DROP VIEW IF EXISTS public.' || r.viewname || ' CASCADE';
  END LOOP;
END $$;


DO $$ 
DECLARE
  r RECORD;
BEGIN
  FOR r IN (SELECT indexname FROM pg_indexes WHERE schemaname = 'public') 
  LOOP
    EXECUTE 'DROP INDEX IF EXISTS public.' || r.indexname;
  END LOOP;
END $$;
