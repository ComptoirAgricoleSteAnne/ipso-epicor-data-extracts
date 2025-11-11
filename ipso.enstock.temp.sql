-- Optionnel : créer et utiliser la base (ajuster le nom/casse si nécessaire)
CREATE DATABASE IF NOT EXISTS dmt_dataloader
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dmt_dataloader;

DROP TABLE IF EXISTS ipso_enstock_temp;

CREATE TABLE ipso_enstock_temp (
  RECNUM           INT NOT NULL AUTO_INCREMENT,         -- IDENTITY(1,1) → AUTO_INCREMENT
  itm_id           CHAR(25)  NOT NULL DEFAULT '',       -- DEFAULT en ligne (SQL Server faisait ALTER TABLE)
  loc_id           CHAR(15)  NOT NULL DEFAULT '',
  lot              CHAR(40)  NOT NULL DEFAULT '',
  act_cost         DECIMAL(12,4) NOT NULL DEFAULT 0,    -- NUMERIC → DECIMAL
  qte_std          DECIMAL(12,4) NOT NULL DEFAULT 0,
  unite_std        CHAR(8)   NOT NULL DEFAULT '',
  std_over_alt     DECIMAL(16,8) NOT NULL DEFAULT 0,
  `date`           DATE NOT NULL DEFAULT '1000-01-01',  -- '0001-01-01' (SQL Server) → min MySQL '1000-01-01'
  unite_alt        CHAR(8)   NOT NULL DEFAULT '',
  unite_str        CHAR(21)  NOT NULL DEFAULT '',
  `reference`      CHAR(20)  NOT NULL DEFAULT '',       -- mot proche de mot-clé → protégé par backticks
  qte_pre_inv      DECIMAL(12,4) NOT NULL DEFAULT 0,
  `status`         CHAR(1)   NOT NULL DEFAULT '',       -- peut entrer en conflit avec SHOW STATUS → backticks
  boite            INT       NOT NULL DEFAULT 0,
  prod_seq         SMALLINT  NOT NULL DEFAULT 0,
  net_kg           DECIMAL(10,4) NOT NULL DEFAULT 0,
  brut_kg          DECIMAL(10,4) NOT NULL DEFAULT 0,
  nb_un            INT       NOT NULL DEFAULT 0,
  `release`        CHAR(10)  NOT NULL DEFAULT '',       -- mot réservé MySQL → backticks obligatoires
  qte_alt          DECIMAL(12,4) NOT NULL DEFAULT 0,
  act_lab_cost     DECIMAL(12,4) NOT NULL DEFAULT 0,
  act_stt_cost     DECIMAL(12,4) NOT NULL DEFAULT 0,
  revision         CHAR(8)   NOT NULL DEFAULT '',
  po_id            CHAR(8)   NOT NULL DEFAULT '',
  date_expiration  DATE NOT NULL DEFAULT '1000-01-01',  -- même ajustement de date minimale
  prj_id           INT       NOT NULL DEFAULT 0,
  unite_cutrite    CHAR(21)  NOT NULL DEFAULT '',
  std_id           CHAR(15)  NOT NULL DEFAULT '',
  stk_note1        CHAR(100) NOT NULL DEFAULT '',
  stk_note2        CHAR(80)  NOT NULL DEFAULT '',

  -- Clé primaire composée (mêmes colonnes que la PK clusterisée de SQL Server)
  PRIMARY KEY (itm_id, loc_id, lot, unite_str, boite, prj_id, `status`),

  -- RECNUM était IDENTITY mais pas PK → on le garde en clé unique
  UNIQUE KEY uq_enstock_recnum (RECNUM)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;
