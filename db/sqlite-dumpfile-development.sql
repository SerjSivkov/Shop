BEGIN TRANSACTION;
CREATE TABLE "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
INSERT INTO "schema_migrations" VALUES('20171212194412');
INSERT INTO "schema_migrations" VALUES('20171215101838');
INSERT INTO "schema_migrations" VALUES('20171215103541');
INSERT INTO "schema_migrations" VALUES('20171215145413');
INSERT INTO "schema_migrations" VALUES('20171215151348');
INSERT INTO "schema_migrations" VALUES('20171218182735');
INSERT INTO "schema_migrations" VALUES('20171218182922');
INSERT INTO "schema_migrations" VALUES('20171219185313');
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
INSERT INTO "ar_internal_metadata" VALUES('environment','development','2017-12-22 11:31:27.693915','2017-12-22 11:31:27.693915');
CREATE TABLE "products" ("id" SERIAL PRIMARY KEY NOT NULL, "title" varchar, "description" text, "image_url" varchar, "price" decimal(8,2), "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
CREATE TABLE "carts" ("id" SERIAL PRIMARY KEY NOT NULL, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
INSERT INTO "carts" VALUES(1,'2017-12-22 11:31:32.353840','2017-12-22 11:31:32.353840');
CREATE TABLE "line_items" ("id" SERIAL PRIMARY KEY NOT NULL, "product_id" integer, "cart_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "quantity" integer DEFAULT 1, "order_id" integer, CONSTRAINT "fk_rails_11e15d5c6b"
FOREIGN KEY ("product_id")
  REFERENCES "products" ("id")
, CONSTRAINT "fk_rails_af645e8e5f"
FOREIGN KEY ("cart_id")
  REFERENCES "carts" ("id")
);
CREATE TABLE "orders" ("id" SERIAL PRIMARY KEY NOT NULL, "name" varchar, "address" text, "email" varchar, "pay_type" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
CREATE TABLE "users" ("id" SERIAL PRIMARY KEY NOT NULL, "name" varchar, "password_digest" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
--INSERT INTO "sqlite_sequence" VALUES('carts',1);
CREATE INDEX "index_line_items_on_product_id" ON "line_items" ("product_id");
CREATE INDEX "index_line_items_on_cart_id" ON "line_items" ("cart_id");
CREATE INDEX "index_line_items_on_order_id" ON "line_items" ("order_id");
COMMIT;
