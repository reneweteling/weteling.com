/*
 Navicat Premium Data Transfer

 Source Server         : locahost
 Source Server Type    : PostgreSQL
 Source Server Version : 90601
 Source Host           : localhost
 Source Database       : weteling-dev
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 90601
 File Encoding         : utf-8

 Date: 08/30/2017 11:12:46 AM
*/

-- ----------------------------
--  Table structure for active_admin_comments
-- ----------------------------
DROP TABLE IF EXISTS "public"."active_admin_comments";
CREATE TABLE "public"."active_admin_comments" (
	"id" int8 NOT NULL,
	"namespace" varchar(255) COLLATE "default",
	"body" text COLLATE "default",
	"resource_id" varchar(255) NOT NULL COLLATE "default",
	"resource_type" varchar(255) NOT NULL COLLATE "default",
	"author_type" varchar(255) COLLATE "default",
	"author_id" int8,
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."active_admin_comments" OWNER TO "postgres";

-- ----------------------------
--  Table structure for ar_internal_metadata
-- ----------------------------
DROP TABLE IF EXISTS "public"."ar_internal_metadata";
CREATE TABLE "public"."ar_internal_metadata" (
	"key" varchar(255) NOT NULL COLLATE "default",
	"value" varchar(255) COLLATE "default",
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."ar_internal_metadata" OWNER TO "postgres";

-- ----------------------------
--  Records of ar_internal_metadata
-- ----------------------------
BEGIN;
INSERT INTO "public"."ar_internal_metadata" VALUES ('environment', 'production', '2017-05-29 10:45:18', '2017-05-29 10:45:18');
COMMIT;

-- ----------------------------
--  Table structure for rates
-- ----------------------------
DROP TABLE IF EXISTS "public"."rates";
CREATE TABLE "public"."rates" (
	"id" int4 NOT NULL,
	"user_id" int4 NOT NULL,
	"name" varchar(255) NOT NULL COLLATE "default",
	"description" text COLLATE "default",
	"rate" numeric(5,2),
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."rates" OWNER TO "postgres";

-- ----------------------------
--  Records of rates
-- ----------------------------
BEGIN;
INSERT INTO "public"."rates" VALUES ('1', '1', 'Normaal', null, '75.00', '2017-05-29 10:45:19', '2017-05-29 10:45:19');
INSERT INTO "public"."rates" VALUES ('2', '1', 'Dagstaffel', null, '62.50', '2017-05-29 10:45:19', '2017-05-29 10:45:19');
COMMIT;

-- ----------------------------
--  Table structure for projects
-- ----------------------------
DROP TABLE IF EXISTS "public"."projects";
CREATE TABLE "public"."projects" (
	"id" int4 NOT NULL,
	"client_id" int4 NOT NULL,
	"name" varchar(255) NOT NULL COLLATE "default",
	"description" text COLLATE "default",
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."projects" OWNER TO "postgres";

-- ----------------------------
--  Records of projects
-- ----------------------------
BEGIN;
INSERT INTO "public"."projects" VALUES ('1', '1', 'Horyon app', 'Het maken en updaten de bedrijfs app', '2017-05-29 10:45:19', '2017-07-19 18:30:18');
INSERT INTO "public"."projects" VALUES ('2', '2', 'Intrim CTO', 'Team aansturen, projecten managen, lastige vraagstukken zelf oplossen', '2017-05-29 10:45:19', '2017-05-30 07:05:30');
INSERT INTO "public"."projects" VALUES ('3', '3', 'Skonne tapijt app', 'Een web-app geschreven in react die een polygoon uitsnijd van een tapijt en deze naar een worker server stuurt om uit te bouwen', '2017-05-29 10:45:19', '2017-05-30 07:06:28');
INSERT INTO "public"."projects" VALUES ('4', '4', 'RiR App', 'Bedrijfs process app met LAVS koppelvlak', '2017-05-29 10:45:19', '2017-07-19 18:30:29');
INSERT INTO "public"."projects" VALUES ('9', '3', 'AEF', '', '2017-07-19 05:52:07', '2017-07-19 05:52:07');
COMMIT;

-- ----------------------------
--  Table structure for projects_users
-- ----------------------------
DROP TABLE IF EXISTS "public"."projects_users";
CREATE TABLE "public"."projects_users" (
	"id" int8 NOT NULL,
	"project_id" int8 NOT NULL,
	"user_id" int8 NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."projects_users" OWNER TO "postgres";

-- ----------------------------
--  Records of projects_users
-- ----------------------------
BEGIN;
INSERT INTO "public"."projects_users" VALUES ('1', '3', '2');
INSERT INTO "public"."projects_users" VALUES ('2', '9', '2');
INSERT INTO "public"."projects_users" VALUES ('3', '3', '3');
INSERT INTO "public"."projects_users" VALUES ('4', '9', '3');
INSERT INTO "public"."projects_users" VALUES ('5', '3', '4');
INSERT INTO "public"."projects_users" VALUES ('6', '9', '4');
COMMIT;

-- ----------------------------
--  Table structure for schema_migrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."schema_migrations";
CREATE TABLE "public"."schema_migrations" (
	"version" varchar(255) NOT NULL COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."schema_migrations" OWNER TO "postgres";

-- ----------------------------
--  Records of schema_migrations
-- ----------------------------
BEGIN;
INSERT INTO "public"."schema_migrations" VALUES ('20170227192956');
INSERT INTO "public"."schema_migrations" VALUES ('20170227193111');
INSERT INTO "public"."schema_migrations" VALUES ('20170228073118');
INSERT INTO "public"."schema_migrations" VALUES ('20170612152421');
INSERT INTO "public"."schema_migrations" VALUES ('20170719183321');
COMMIT;

-- ----------------------------
--  Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
	"id" int4 NOT NULL,
	"name" varchar(255) NOT NULL COLLATE "default",
	"first_name" varchar(255) COLLATE "default",
	"last_name" varchar(255) COLLATE "default",
	"department" varchar(255) COLLATE "default",
	"address" varchar(255) COLLATE "default",
	"postalcode" varchar(255) COLLATE "default",
	"city" varchar(255) COLLATE "default",
	"country" varchar(255) COLLATE "default",
	"email" varchar(255) NOT NULL COLLATE "default",
	"iban" varchar(255) COLLATE "default",
	"bic" varchar(255) COLLATE "default",
	"iban_name" varchar(255) COLLATE "default",
	"coc_no" varchar(255) COLLATE "default",
	"tax_no" varchar(255) COLLATE "default",
	"encrypted_password" varchar(255) NOT NULL COLLATE "default",
	"reset_password_token" varchar(255) COLLATE "default",
	"reset_password_sent_at" timestamp(6) NULL,
	"remember_created_at" timestamp(6) NULL,
	"sign_in_count" int4 NOT NULL,
	"current_sign_in_at" timestamp(6) NULL,
	"last_sign_in_at" timestamp(6) NULL,
	"current_sign_in_ip" varchar(255) COLLATE "default",
	"last_sign_in_ip" varchar(255) COLLATE "default",
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL,
	"role" int4
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."users" OWNER TO "postgres";

-- ----------------------------
--  Records of users
-- ----------------------------
BEGIN;
INSERT INTO "public"."users" VALUES ('1', 'Rene Weteling', 'René', 'Weteling', '', 'Herengracht 504', '1017CB', 'Amsterdam', 'NL', 'rene@weteling.com', 'NL38 KBAV 0723 0772 82', 'KNABNL2H', 'Weteling Support, R.M. Weteling', '24403159', 'NL1997.22.286.B02', '$2a$11$SPhTFnB3QeIJRWXgEJQn8uAkbk3YIBLH35c8aQgfUv3w281fqJaxu', null, null, '2017-08-11 11:58:10', '34', '2017-08-28 09:59:30', '2017-08-24 15:30:22', '213.206.222.106', '213.206.222.106', '2017-05-29 10:45:19', '2017-08-28 09:59:30', '0');
INSERT INTO "public"."users" VALUES ('2', 'Femke', 'Femke', 'Tiessen', '', '', '', 'Amsterdam', 'NL', 'femke@van-ons.nl', '', '', '', '', '', '$2a$11$Gr/cYt2MgrwFN7pfcaZzbe40jXaFsV53JS4KOreKWp1P8mEsDzd36', null, null, null, '1', '2017-07-21 13:34:56', '2017-07-21 13:34:56', '213.127.182.58', '213.127.182.58', '2017-07-20 06:28:57', '2017-07-21 13:34:56', '1');
INSERT INTO "public"."users" VALUES ('3', 'Gauke', 'Gauke', 'Tijssen', '', '', '', 'Amsterdam', 'NL', 'gauke@van-ons.nl', '', '', '', '', '', '$2a$11$avJiS5bgb.mu5D2C/MDIs.ftapfi.l8ERW11OcnzTgi831baRPcHW', null, null, null, '1', '2017-07-20 06:30:39', '2017-07-20 06:30:39', '213.127.91.85', '213.127.91.85', '2017-07-20 06:30:29', '2017-07-20 06:30:39', '1');
INSERT INTO "public"."users" VALUES ('4', 'Robert van Eekhout', 'Robert', 'Van Eekhout', '', '', '', '', 'NL', 'robert@van-ons.nl', '', '', '', '', '', '$2a$11$JNpvzhVGb3nXNN4.8giQMepH6mzikh/z3dPZqz5p4eBTpzbFcuG.O', null, null, null, '1', '2017-07-31 19:24:53', '2017-07-31 19:24:53', '62.194.68.121', '62.194.68.121', '2017-07-31 19:24:42', '2017-07-31 19:24:53', '1');
COMMIT;

-- ----------------------------
--  Table structure for clients
-- ----------------------------
DROP TABLE IF EXISTS "public"."clients";
CREATE TABLE "public"."clients" (
	"id" int4 NOT NULL,
	"user_id" int4 NOT NULL,
	"name" varchar(255) NOT NULL COLLATE "default",
	"first_name" varchar(255) COLLATE "default",
	"last_name" varchar(255) COLLATE "default",
	"department" varchar(255) COLLATE "default",
	"address" varchar(255) COLLATE "default",
	"postalcode" varchar(255) COLLATE "default",
	"city" varchar(255) COLLATE "default",
	"country" varchar(255) COLLATE "default",
	"email" varchar(255) COLLATE "default",
	"iban" varchar(255) COLLATE "default",
	"bic" varchar(255) COLLATE "default",
	"iban_name" varchar(255) COLLATE "default",
	"coc_no" varchar(255) COLLATE "default",
	"tax_no" varchar(255) COLLATE "default",
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL,
	"default_rate_id" int8
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."clients" OWNER TO "postgres";

-- ----------------------------
--  Records of clients
-- ----------------------------
BEGIN;
INSERT INTO "public"."clients" VALUES ('1', '1', 'Horyon innovaties B.V.', 'Jan', 'Horyon', '', '', '', '', 'NL', 'jan@horyon-innovaties.nl', '', '', '', '', '', '2017-05-29 10:45:19', '2017-06-12 16:03:56', '2');
INSERT INTO "public"."clients" VALUES ('2', '1', 'Revolve Music B.V.', 'Marthijn', 'Graafland', '', 'Singel 60', '', 'Amsterdam', 'NL', 'marthijn@revolve-music.com', '', '', '', '', '', '2017-05-29 10:45:19', '2017-06-12 16:03:47', '2');
INSERT INTO "public"."clients" VALUES ('3', '1', 'Van Ons B.V.', 'Gauke', 'Thijssen', '', '', '', '', 'NL', 'gauke@van-ons.nl', '', '', '', '', '', '2017-05-29 10:45:19', '2017-06-12 16:03:38', '1');
INSERT INTO "public"."clients" VALUES ('4', '1', 'RIR Nederland B.V.', 'Gerwin', 'Lensink', '', 'Boerenstraat 24', '6961 KC', 'Eerbeek', 'NL', 'gerwin@rirnl.eu', '', '', '', '', '', '2017-05-30 07:04:00', '2017-06-12 16:03:29', '1');
COMMIT;

-- ----------------------------
--  Table structure for hours
-- ----------------------------
DROP TABLE IF EXISTS "public"."hours";
CREATE TABLE "public"."hours" (
	"id" int4 NOT NULL,
	"project_id" int4 NOT NULL,
	"rate_id" int4 NOT NULL,
	"date" date NOT NULL,
	"total_hours" numeric(4,2) NOT NULL,
	"description" text NOT NULL COLLATE "default",
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL,
	"total_sno_hours" numeric(4,2) NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."hours" OWNER TO "postgres";

-- ----------------------------
--  Records of hours
-- ----------------------------
BEGIN;
INSERT INTO "public"."hours" VALUES ('1', '2', '2', '2017-06-01', '5.00', 'Jira issues, logging aangepst, Paypal uitgezocht', '2017-06-01 09:53:44', '2017-06-01 09:53:44', '0.00');
INSERT INTO "public"."hours" VALUES ('2', '3', '1', '2017-06-02', '2.50', 'Op locatie Lex geholpen en het eea omgebouwd. Op kantoor verder met de hex berekening', '2017-06-02 13:54:42', '2017-06-06 07:04:45', '0.00');
INSERT INTO "public"."hours" VALUES ('3', '1', '2', '2017-06-06', '0.50', 'Bellen / mailen voor het PKI cert, inboeken afspraak en uitzoeken welke je moet hebben', '2017-06-06 18:59:52', '2017-06-06 18:59:52', '0.00');
INSERT INTO "public"."hours" VALUES ('4', '2', '2', '2017-06-06', '8.00', 'Ability toegevoegd, onboarding aangepast, sorting gefixt voor de homepage', '2017-06-06 19:01:19', '2017-06-06 19:01:19', '0.00');
INSERT INTO "public"."hours" VALUES ('5', '2', '2', '2017-06-07', '8.00', 'Begonnen aan press page, gregor en jelle op weggeholpen pc mariana versneld, uitzoeken hoe je pdf''s kunt maken vanuit rails', '2017-06-07 15:53:53', '2017-06-07 15:53:53', '2.00');
INSERT INTO "public"."hours" VALUES ('6', '2', '2', '2017-06-08', '7.00', 'Ver gekomen met multi columns
Pdf afgerond
Wktohtml op de server gezet
Jelle, Mariana en Greg bijgestaan', '2017-06-08 14:47:42', '2017-06-08 14:47:42', '0.00');
INSERT INTO "public"."hours" VALUES ('7', '3', '1', '2017-06-09', '6.00', 'Gewerkt aan de font-end, met name een react router toegepast, modals makkelijker gemaakt, de designs als subverzie van de huidige gemaakt en bezig om de designs op de server te plaatsen', '2017-06-09 14:14:40', '2017-06-09 14:14:40', '0.00');
INSERT INTO "public"."hours" VALUES ('8', '2', '2', '2017-06-12', '0.50', 'Servers down', '2017-06-12 06:51:25', '2017-06-12 06:51:25', '0.00');
INSERT INTO "public"."hours" VALUES ('9', '3', '1', '2017-06-12', '4.00', 'Modals omgebouwd, http client toegevoegd, mobx toegevoegd voor universal state, begonnen aan api documentatie', '2017-06-12 10:36:52', '2017-06-12 10:36:52', '0.00');
INSERT INTO "public"."hours" VALUES ('10', '4', '1', '2017-06-12', '3.00', 'Op en neer naar den haag voor een face2face verificatie bij Digidentity', '2017-06-12 13:54:32', '2017-06-12 13:54:32', '0.00');
INSERT INTO "public"."hours" VALUES ('11', '2', '2', '2017-06-13', '8.00', 'Uizoeken en inlezen over GC compiling voor memory bloats binnen rails.
paypal nabellen
activeadmin updaten
', '2017-06-13 14:32:36', '2017-06-13 14:32:36', '3.00');
INSERT INTO "public"."hours" VALUES ('12', '2', '2', '2017-06-14', '8.00', 'Multiple uploads
Losse issues jira
Multi column migratie', '2017-06-14 15:20:33', '2017-06-14 15:20:33', '0.00');
INSERT INTO "public"."hours" VALUES ('13', '2', '2', '2017-06-15', '8.00', 'Jira issues', '2017-06-15 15:26:56', '2017-06-15 15:26:56', '0.00');
INSERT INTO "public"."hours" VALUES ('14', '4', '1', '2017-06-16', '2.00', 'Bezig houden met LAVS ', '2017-06-16 09:54:17', '2017-06-16 09:54:17', '0.00');
INSERT INTO "public"."hours" VALUES ('15', '1', '2', '2017-06-16', '3.50', 'Dagboek + update rails 5.01 --> rails 5.1.1 en ruby 2.3.1 --> 2.4.1,  depencency wkhtml2pdf is down. Zelf even een mirror gemaakt', '2017-06-16 09:55:14', '2017-06-16 14:11:35', '0.00');
INSERT INTO "public"."hours" VALUES ('16', '9', '1', '2017-06-16', '3.00', 'Aef wijzigingen doorgevoerd
Verder met de Skonne app
', '2017-06-16 14:12:37', '2017-07-19 05:52:25', '0.00');
INSERT INTO "public"."hours" VALUES ('17', '1', '2', '2017-06-19', '1.50', 'Export aangepast, nieuwe verzie live, PDFkit geupdate uitzoeken pdf --> word converzie', '2017-06-19 08:02:18', '2017-06-19 08:02:18', '0.00');
INSERT INTO "public"."hours" VALUES ('18', '4', '1', '2017-06-19', '1.00', 'Aanpassingen LAVS, certificaat live, veranderingen in regel tov productie en live gezet', '2017-06-19 13:06:43', '2017-06-19 13:06:43', '0.00');
INSERT INTO "public"."hours" VALUES ('19', '3', '1', '2017-06-19', '7.50', '- Api koppeling gemaakt in de app
- Pixel coordiaten omgezet naar google maps coordinaten
- Begonnen met het installeren van software op de server
- S''avonds server afgemaakt, rails draait + passenger en de api draaien. Nu nog kijken naar Gdal en opencv', '2017-06-19 15:22:07', '2017-06-19 21:00:13', '0.00');
INSERT INTO "public"."hours" VALUES ('20', '2', '2', '2017-06-20', '8.00', '- Theme dir change
- AA uitgebreid met finance overview
- Server problemen opgelost
- Verticals over ssl
- Thumbs re-render
- DE domain
- Loader', '2017-06-20 14:41:49', '2017-06-20 14:41:49', '0.00');
INSERT INTO "public"."hours" VALUES ('21', '2', '2', '2017-06-21', '8.00', 'Jira issues, accounts', '2017-06-22 12:45:24', '2017-06-22 12:45:24', '0.00');
INSERT INTO "public"."hours" VALUES ('22', '2', '2', '2017-06-22', '8.00', '- Uitzoeken hoe je soundcloud kunt cachen
- Uitzoeken hoe je facbook kunt cachen
- Uitzoeken hoe je instagram kunt cahcen
cache inbouwen', '2017-06-22 12:46:14', '2017-06-22 12:46:14', '5.00');
INSERT INTO "public"."hours" VALUES ('23', '3', '1', '2017-06-22', '6.50', 'Software op de server installeren, zorgen dat het renderen gaat werken
Horizontaal repeat probleem getackeld met Gauke ', '2017-06-26 20:47:54', '2017-06-26 20:47:54', '0.00');
INSERT INTO "public"."hours" VALUES ('24', '2', '2', '2017-06-22', '1.50', 'Issues met multi column opgelost en wat andere kritische errors verholpen', '2017-06-26 20:48:23', '2017-06-26 20:48:23', '0.00');
INSERT INTO "public"."hours" VALUES ('25', '2', '2', '2017-06-26', '8.00', 'Jira issues
Soundcloud
Circle ci ', '2017-06-26 20:48:47', '2017-06-26 20:48:47', '0.00');
INSERT INTO "public"."hours" VALUES ('26', '3', '1', '2017-06-26', '3.00', 'Eerste werkende verzie van het voorbereiden van een patroon op de server :) het horizontaal herhalend', '2017-06-26 20:49:28', '2017-06-26 20:49:28', '0.00');
INSERT INTO "public"."hours" VALUES ('27', '3', '1', '2017-06-27', '2.00', 'Patroon 2 uitrenderenen
Delayed job op de server gezet
Troubleshooten', '2017-06-27 07:09:42', '2017-06-27 07:09:42', '0.00');
INSERT INTO "public"."hours" VALUES ('28', '2', '2', '2017-06-27', '8.00', 'Punten jira
Circle ci optimaliseren', '2017-06-27 07:10:06', '2017-06-27 07:10:06', '0.00');
INSERT INTO "public"."hours" VALUES ('29', '2', '2', '2017-07-06', '8.00', 'Punten jira, nakijken betalingen jelle, mariana assisteren', '2017-07-06 08:36:03', '2017-07-06 08:36:03', '0.00');
INSERT INTO "public"."hours" VALUES ('30', '3', '1', '2017-07-06', '1.50', 'Delayed job op de server gezet, draait nog niet', '2017-07-07 10:45:15', '2017-07-07 10:45:15', '0.00');
INSERT INTO "public"."hours" VALUES ('31', '3', '1', '2017-07-07', '1.00', 'Delayed job werkend, re-render van alle assests.', '2017-07-07 10:45:33', '2017-07-07 10:45:33', '0.00');
INSERT INTO "public"."hours" VALUES ('32', '2', '2', '2017-07-07', '5.50', '- Systeem bedenken om translaties makkelijk aanpasbaar te maken, kijken naar xray, kijken naar extendingen van translatie functies

- Jira issues
- Jelle / gregor assisteren', '2017-07-07 10:46:00', '2017-07-07 12:25:30', '3.00');
INSERT INTO "public"."hours" VALUES ('33', '3', '1', '2017-07-10', '6.00', '3 uur op kantoor met tristan gekeken naar alle losse issues, mails van Femke afgerond etc
3 uur thuis gewerkt aan het uitsnijden van een afbeelding', '2017-07-11 06:25:42', '2017-07-11 06:25:42', '0.00');
INSERT INTO "public"."hours" VALUES ('34', '1', '2', '2017-07-10', '1.50', 'Android 7.1.1 emulator geinstalleerd om uit te zoeken wat er nu mis is met de pdf''s', '2017-07-11 06:26:29', '2017-07-11 06:26:29', '0.00');
INSERT INTO "public"."hours" VALUES ('35', '2', '2', '2017-07-11', '8.00', 'Jira issues', '2017-07-12 06:37:10', '2017-07-12 06:37:32', '0.00');
INSERT INTO "public"."hours" VALUES ('36', '2', '2', '2017-07-12', '8.00', 'Jira issues', '2017-07-12 06:37:23', '2017-07-12 06:37:23', '0.00');
INSERT INTO "public"."hours" VALUES ('37', '2', '2', '2017-07-13', '8.00', 'Uitzoeken en onderzoeken hoe je nu een sessie kunt delen over meerdere domeinen', '2017-07-13 14:32:36', '2017-07-13 14:32:36', '8.00');
INSERT INTO "public"."hours" VALUES ('38', '1', '2', '2017-07-14', '3.50', 'Api 7.0 upgrade en nieuwe verzie live zetten (kostte nog al wat tijd)', '2017-07-14 15:25:21', '2017-07-14 15:25:21', '0.00');
INSERT INTO "public"."hours" VALUES ('39', '3', '1', '2017-07-14', '4.50', 'Api calls gekoppeld
Forgot password toegoevoegd
Issues opgelost
Trello ingedeeld', '2017-07-14 15:26:11', '2017-07-14 15:26:11', '0.00');
INSERT INTO "public"."hours" VALUES ('40', '3', '1', '2017-07-17', '7.00', 'Laatste puntjes app afgerond
Met Tristan verder gekeken naar de api', '2017-07-18 06:19:07', '2017-07-18 06:19:07', '0.00');
INSERT INTO "public"."hours" VALUES ('41', '3', '1', '2017-07-18', '4.50', '3 uur gewerkt aan de worker server
1,5 uur gewerkt in de avond aan de app, laatste punten van trello opgepakt', '2017-07-19 05:50:13', '2017-07-19 05:50:13', '0.00');
INSERT INTO "public"."hours" VALUES ('42', '2', '2', '2017-07-18', '8.00', 'onderzoek gedaan naar het draaien van multiple ssl certificaten over een AWS lb
jira issues', '2017-07-19 05:50:47', '2017-07-19 05:50:47', '4.00');
INSERT INTO "public"."hours" VALUES ('43', '3', '1', '2017-04-25', '9.50', '19-4-2017	Uitzoeken geospacing naar tiles	2
23-4-2017	Eerste opzet Rails api	2
24-4-2017	Crop script maken	1
25-4-2017	Script vertaald naar native systemcalls voor imagemagich met stream functie voor large files	4,5', '2017-07-19 05:54:17', '2017-07-19 05:54:25', '0.00');
INSERT INTO "public"."hours" VALUES ('44', '3', '1', '2017-05-29', '37.50', '12-5-2017	Onderzoek naar omzetten afbeeldingen imagemagic en vips 	11
15-5-2017	Betere manier voor compressie middels Lib Vips + bellen / uitzoeken gauke telefoon, kantoor 	5
16-5-2017	Polygoon omzetten van ImageMagick naar OpenCV	3
19-5-2017	Eerste verzie gemaak react front-end	9
22-5-2017	kleuren, zoom knoppen, modal window, iconen, beter uitlijnen, smooth menu	5
26-5-2017	LZW comressie + aftikken losse punten met Robert	1
29-5-2017	Begonnen omschrijven test scripts naar library''s. Active job toegevoegd etc	3,5', '2017-07-19 05:55:18', '2017-07-19 05:55:18', '0.00');
INSERT INTO "public"."hours" VALUES ('45', '3', '1', '2017-07-19', '1.50', 'Issues trello en project nalopen', '2017-07-19 18:29:06', '2017-07-19 18:29:06', '0.00');
INSERT INTO "public"."hours" VALUES ('46', '2', '2', '2017-07-19', '8.00', 'Iframe fix
downloadgate', '2017-07-19 18:29:33', '2017-07-19 18:29:33', '0.00');
INSERT INTO "public"."hours" VALUES ('47', '2', '2', '2017-07-20', '8.00', 'Trello issues, Download gate', '2017-07-24 07:44:23', '2017-07-24 07:44:23', '0.00');
INSERT INTO "public"."hours" VALUES ('48', '9', '1', '2017-07-21', '0.50', 'aanpassing koppelen van berichten', '2017-07-24 07:44:52', '2017-07-24 07:44:52', '0.00');
INSERT INTO "public"."hours" VALUES ('49', '3', '1', '2017-07-21', '7.50', 'Bezig geweest met de worker server. Loop een beetje vast met het ometten van gewrapte coordinaten naar platte coordinaten.', '2017-07-24 07:45:34', '2017-07-24 07:45:46', '0.00');
INSERT INTO "public"."hours" VALUES ('50', '3', '1', '2017-07-24', '5.00', 'Skonne - app:
    - Save issue opgelost
    - Positionering polygoon
    - Juist renderen van de previews (copy paste van lex herschreven naar react)
    - endpoints aangepast
Skonne - worker
    - Verder met het omzetten van coordinaten
    - Google maps er uit gehaald + deepzoom er in gezet, worker server aangepaast om DZ te genereren ipv tile

11,5 uur gewerkt. 5 uur berekend ivm verkeerde inschatting ', '2017-07-24 07:47:24', '2017-07-24 19:02:40', '0.00');
INSERT INTO "public"."hours" VALUES ('51', '2', '2', '2017-07-25', '8.00', '- Fixed failed transactions
- Fixed uploading to design editor, 
- Fixed www link in redirect
- Fixed typekit for tibbaa', '2017-07-26 07:11:36', '2017-07-26 07:11:36', '0.00');
INSERT INTO "public"."hours" VALUES ('52', '3', '1', '2017-07-25', '2.50', 'Worker server ingericht en alle designs laten renderen', '2017-07-26 07:12:01', '2017-07-26 07:12:01', '0.00');
INSERT INTO "public"."hours" VALUES ('53', '3', '1', '2017-07-26', '0.50', 'Design 8 laten renderen
Overzicht pagina gemaakt
Communicate slack', '2017-07-26 15:10:02', '2017-07-26 15:10:02', '0.00');
INSERT INTO "public"."hours" VALUES ('54', '2', '2', '2017-07-26', '8.00', 'Adyen payments
Www link
Download gate
Instagram issue', '2017-07-26 15:11:19', '2017-07-26 15:11:19', '0.00');
INSERT INTO "public"."hours" VALUES ('55', '2', '2', '2017-07-27', '8.00', 'Instagram fix
Admin SPEEEEEED
Mp3 download
Jira issues', '2017-07-27 15:06:07', '2017-07-27 15:06:27', '0.00');
INSERT INTO "public"."hours" VALUES ('56', '3', '1', '2017-07-28', '8.00', 'Preview render werkend gemaakt server ingericht 
Issues app trello', '2017-07-31 18:06:56', '2017-07-31 18:06:56', '0.00');
INSERT INTO "public"."hours" VALUES ('57', '3', '1', '2017-07-31', '7.50', 'Worker server voor de preview afgerond, ellipse, hexagon en 4 kant werken nu
Met tristan gezorgd dat de koppeling goed ligt
Verder met front-end issues ', '2017-07-31 18:07:59', '2017-07-31 18:07:59', '0.00');
INSERT INTO "public"."hours" VALUES ('58', '2', '2', '2017-08-01', '6.00', 'Later begonnen ivm Aannemer
- Issue met subscription terug zetten
- Jira issues', '2017-08-01 09:58:03', '2017-08-01 09:58:03', '0.00');
INSERT INTO "public"."hours" VALUES ('59', '3', '1', '2017-08-01', '2.50', '- Eerste werkende verzie van de definitieve render online gezet
- Canvas 90 graden draainen wanneer de breedte groter is dan 400 cm
- Pixel calculator gemaakt voor de definieve formaat
- Percentage calculator gemaakt om snel te kunnen renderen', '2017-08-01 19:26:35', '2017-08-01 19:26:35', '0.00');
INSERT INTO "public"."hours" VALUES ('60', '3', '1', '2017-08-02', '2.00', 'Bezig geweest met de final render, er zit een mem allocatie probleem op de server', '2017-08-02 19:41:52', '2017-08-02 19:41:52', '0.00');
INSERT INTO "public"."hours" VALUES ('61', '2', '2', '2017-08-02', '8.00', 'Jira issues
Gezocht naar probleem het het inactief zetten van de accounts
Issues met de theme picker', '2017-08-02 19:49:49', '2017-08-02 19:49:49', '0.00');
INSERT INTO "public"."hours" VALUES ('62', '2', '2', '2017-08-03', '5.50', 'Jira issues (eerder weg trouwlocatie route)', '2017-08-03 13:15:35', '2017-08-03 13:15:35', '0.00');
INSERT INTO "public"."hours" VALUES ('63', '3', '1', '2017-08-03', '2.00', 'Uitzoeken memory probleem IplImage vs CvMat
Mem issue opgelost en server live gezet kanteling aangepast', '2017-08-03 13:16:19', '2017-08-03 18:08:18', '0.00');
INSERT INTO "public"."hours" VALUES ('64', '2', '2', '2017-08-04', '0.50', 'Alles lag er uit', '2017-08-04 07:40:48', '2017-08-04 07:40:48', '0.00');
INSERT INTO "public"."hours" VALUES ('65', '9', '1', '2017-08-04', '0.50', '- Footer aanpassen
- Subtitles hiden', '2017-08-04 08:14:38', '2017-08-04 12:07:11', '0.00');
INSERT INTO "public"."hours" VALUES ('66', '3', '1', '2017-08-04', '2.50', 'Whooohooooo Beta time  :)', '2017-08-04 08:49:20', '2017-08-04 08:49:20', '0.00');
INSERT INTO "public"."hours" VALUES ('67', '3', '1', '2017-08-04', '-6.75', 'Begrorting met 1000 overschreven. Met Gauke afgesproken deze te middelen en alle overige uren worden gewoon geschreven', '2017-08-04 11:54:03', '2017-08-04 11:54:03', '0.00');
INSERT INTO "public"."hours" VALUES ('68', '3', '1', '2017-08-07', '1.00', 'Tristan gehlpen met wat kleine dingen +/- 10 min
uurtje zitten puzzelen met die uitvoer, die in photoshop niet uitgenseden was en in preview en chrome wel, blijft raar', '2017-08-07 18:53:47', '2017-08-07 18:53:47', '0.00');
INSERT INTO "public"."hours" VALUES ('69', '2', '2', '2017-08-07', '1.00', 'Black hawk down. alle servers lagen er uit, onderzoek doen en fix live zetten', '2017-08-08 15:24:44', '2017-08-08 15:24:44', '0.00');
INSERT INTO "public"."hours" VALUES ('70', '2', '2', '2017-08-08', '8.00', '- Onderzoek doen naar logische dunning mongenlijkheiden
- Subscription bug gefixt
- Currency bug gefixt
- Verder met presspage', '2017-08-08 15:25:24', '2017-08-08 15:25:24', '4.00');
INSERT INTO "public"."hours" VALUES ('71', '3', '1', '2017-08-09', '1.00', '- Issue met schalen opgelost
- Issue met verbergen shape bij foutieve invoer', '2017-08-09 07:57:55', '2017-08-09 07:57:55', '0.00');
INSERT INTO "public"."hours" VALUES ('72', '2', '2', '2017-08-09', '8.00', 'Jira issues, press page', '2017-08-10 15:48:29', '2017-08-10 15:48:29', '0.00');
INSERT INTO "public"."hours" VALUES ('73', '2', '2', '2017-08-10', '7.00', 'Jira issues, design editor , wbso', '2017-08-10 15:48:50', '2017-08-10 15:48:50', '0.00');
INSERT INTO "public"."hours" VALUES ('74', '3', '1', '2017-08-11', '1.00', 'App:
- preview button disabled bij errors
- zoom niveau tonen in console
- shape niet tonen tijdens error calculatie
Worker:
- script geschreven om alles automatisch te downloaden en verwerken', '2017-08-11 11:59:26', '2017-08-11 11:59:26', '0.00');
INSERT INTO "public"."hours" VALUES ('75', '2', '2', '2017-08-15', '7.50', 'Jira issues
Spinnin oAuth probleem 
iets korter gewerkt, brillen winkel met lotte', '2017-08-15 15:25:09', '2017-08-15 15:25:09', '0.00');
INSERT INTO "public"."hours" VALUES ('77', '2', '2', '2017-08-16', '8.00', '- Tld''s per partner
- spinnin oauth gedoe
- Action bar
- jira issues', '2017-08-16 15:51:12', '2017-08-16 15:51:12', '0.00');
INSERT INTO "public"."hours" VALUES ('78', '2', '2', '2017-08-17', '8.00', 'Jira issues
Theme templates', '2017-08-17 16:05:03', '2017-08-17 16:05:03', '0.00');
INSERT INTO "public"."hours" VALUES ('79', '3', '1', '2017-08-19', '0.50', 'Filename toepassen bij filenames, trello doorwerken uitleg geven aan femke', '2017-08-19 13:02:57', '2017-08-19 13:02:57', '0.00');
INSERT INTO "public"."hours" VALUES ('80', '2', '2', '2017-08-22', '8.00', 'Jira issues, gregor helpen en voornamlijk met de pages tittles bezig geweest', '2017-08-22 16:03:58', '2017-08-22 16:03:58', '0.00');
INSERT INTO "public"."hours" VALUES ('81', '4', '1', '2017-08-23', '5.00', '- Hosting opgezet
- Eerste verzie active admin', '2017-08-24 14:01:26', '2017-08-24 14:01:26', '0.00');
INSERT INTO "public"."hours" VALUES ('82', '4', '1', '2017-08-24', '6.00', '- Cms opzet gemaakt 
- Activiteiten + projecten etc online gezet', '2017-08-24 14:02:17', '2017-08-24 14:02:17', '0.00');
INSERT INTO "public"."hours" VALUES ('83', '1', '2', '2017-08-24', '1.50', '- Tablet installeren met andoid 7.0
- Issue debuggen', '2017-08-24 14:03:49', '2017-08-24 15:30:34', '0.00');
INSERT INTO "public"."hours" VALUES ('84', '3', '1', '2017-08-28', '0.50', 'Nakijken SSL
Tristan helpen met paden
Worker aanzetten nieuwe designs, oude wissen etc', '2017-08-28 10:00:19', '2017-08-30 07:47:05', '0.00');
INSERT INTO "public"."hours" VALUES ('85', '4', '1', '2017-08-28', '2.00', 'Begonnen met checklisten', '2017-08-28 10:00:38', '2017-08-28 10:00:38', '0.00');
INSERT INTO "public"."hours" VALUES ('86', '3', '1', '2017-08-29', '0.50', 'Kleine aanpassing aan de app', '2017-08-30 07:45:56', '2017-08-30 07:45:56', '0.00');
INSERT INTO "public"."hours" VALUES ('87', '2', '2', '2017-08-30', '1.00', 'memory issues oplossgen en debuggen', '2017-08-30 07:46:19', '2017-08-30 07:46:19', '0.00');
INSERT INTO "public"."hours" VALUES ('88', '3', '1', '2017-08-30', '0.50', 'issue debuggen lijntjes safari / firefox', '2017-08-30 08:09:45', '2017-08-30 08:09:45', '0.00');
COMMIT;

-- ----------------------------
--  Primary key structure for table active_admin_comments
-- ----------------------------
ALTER TABLE "public"."active_admin_comments" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table active_admin_comments
-- ----------------------------
CREATE INDEX  "index_active_admin_comments_on_author_type_and_author_id" ON "public"."active_admin_comments" USING btree(author_type COLLATE "default" "pg_catalog"."text_ops" ASC NULLS LAST, author_id "pg_catalog"."int8_ops" ASC NULLS LAST);
CREATE INDEX  "index_active_admin_comments_on_namespace" ON "public"."active_admin_comments" USING btree("namespace" COLLATE "default" "pg_catalog"."text_ops" ASC NULLS LAST);
CREATE INDEX  "index_active_admin_comments_on_resource_type_and_resource_id" ON "public"."active_admin_comments" USING btree(resource_type COLLATE "default" "pg_catalog"."text_ops" ASC NULLS LAST, resource_id COLLATE "default" "pg_catalog"."text_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table ar_internal_metadata
-- ----------------------------
ALTER TABLE "public"."ar_internal_metadata" ADD PRIMARY KEY ("key") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table rates
-- ----------------------------
ALTER TABLE "public"."rates" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table rates
-- ----------------------------
CREATE INDEX  "index_rates_on_user_id" ON "public"."rates" USING btree(user_id "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table projects
-- ----------------------------
ALTER TABLE "public"."projects" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table projects
-- ----------------------------
CREATE INDEX  "index_projects_on_client_id" ON "public"."projects" USING btree(client_id "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table projects_users
-- ----------------------------
ALTER TABLE "public"."projects_users" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table projects_users
-- ----------------------------
CREATE INDEX  "index_projects_users_on_project_id" ON "public"."projects_users" USING btree(project_id "pg_catalog"."int8_ops" ASC NULLS LAST);
CREATE INDEX  "index_projects_users_on_user_id" ON "public"."projects_users" USING btree(user_id "pg_catalog"."int8_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table schema_migrations
-- ----------------------------
ALTER TABLE "public"."schema_migrations" ADD PRIMARY KEY ("version") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table users
-- ----------------------------
CREATE UNIQUE INDEX  "index_users_on_email" ON "public"."users" USING btree(email COLLATE "default" "pg_catalog"."text_ops" ASC NULLS LAST);
CREATE UNIQUE INDEX  "index_users_on_reset_password_token" ON "public"."users" USING btree(reset_password_token COLLATE "default" "pg_catalog"."text_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table clients
-- ----------------------------
ALTER TABLE "public"."clients" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table clients
-- ----------------------------
CREATE INDEX  "index_clients_on_default_rate_id" ON "public"."clients" USING btree(default_rate_id "pg_catalog"."int8_ops" ASC NULLS LAST);
CREATE INDEX  "index_clients_on_user_id" ON "public"."clients" USING btree(user_id "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table hours
-- ----------------------------
ALTER TABLE "public"."hours" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table hours
-- ----------------------------
CREATE INDEX  "index_hours_on_project_id" ON "public"."hours" USING btree(project_id "pg_catalog"."int4_ops" ASC NULLS LAST);
CREATE INDEX  "index_hours_on_rate_id" ON "public"."hours" USING btree(rate_id "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Foreign keys structure for table rates
-- ----------------------------
ALTER TABLE "public"."rates" ADD CONSTRAINT "fk_rails_4a29085ce0" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table projects
-- ----------------------------
ALTER TABLE "public"."projects" ADD CONSTRAINT "fk_rails_8d9657cec3" FOREIGN KEY ("client_id") REFERENCES "public"."clients" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table clients
-- ----------------------------
ALTER TABLE "public"."clients" ADD CONSTRAINT "fk_rails_21c421fd41" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table hours
-- ----------------------------
ALTER TABLE "public"."hours" ADD CONSTRAINT "fk_rails_8cec964587" FOREIGN KEY ("project_id") REFERENCES "public"."projects" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."hours" ADD CONSTRAINT "fk_rails_03024eadcf" FOREIGN KEY ("rate_id") REFERENCES "public"."rates" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

