-- Se o banco já existir, apenas USE; caso contrário, crie antes:
-- CREATE DATABASE dmt_dataloader CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dmt_dataloader;

-- =========================
-- Tabela: ipso_itmdoc
-- =========================
DROP TABLE IF EXISTS `ipso_itmdoc`;
CREATE TABLE `ipso_itmdoc` (
  `RECNUM`    INT NOT NULL AUTO_INCREMENT,
  `itm_id`    CHAR(25)  NOT NULL DEFAULT '',
  `seq`       SMALLINT  NOT NULL DEFAULT 0,
  `filename`  CHAR(255) NOT NULL DEFAULT '',
  `docs`      CHAR(20)  NOT NULL DEFAULT '',
  `entrydate` DATE      NOT NULL DEFAULT '1000-01-01',
  `entryuser` CHAR(5)   NOT NULL DEFAULT '',
  `print`     SMALLINT  NOT NULL DEFAULT 0,
  `email`     SMALLINT  NOT NULL DEFAULT 0,
  `descr`     CHAR(60)  NOT NULL DEFAULT '',
  PRIMARY KEY (`RECNUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================
-- Tabela: ipso_opsfil
-- =========================
DROP TABLE IF EXISTS `ipso_opsfil`;
CREATE TABLE `ipso_opsfil` (
  `RECNUM`          INT        NOT NULL AUTO_INCREMENT,
  `ops_id`          CHAR(9)    NOT NULL DEFAULT '',
  `descr`           CHAR(40)   NOT NULL DEFAULT '',
  `entrydate`       DATE       NOT NULL DEFAULT '1000-01-01',
  `last_mod`        DATE       NOT NULL DEFAULT '1000-01-01',
  `usager`          CHAR(5)    NOT NULL DEFAULT '',
  `insp1`           CHAR(40)   NOT NULL DEFAULT '',
  `insp2`           CHAR(40)   NOT NULL DEFAULT '',
  `insp3`           CHAR(40)   NOT NULL DEFAULT '',
  `insp4`           CHAR(40)   NOT NULL DEFAULT '',
  `insp5`           CHAR(40)   NOT NULL DEFAULT '',
  `insp_pt1`        CHAR(10)   NOT NULL DEFAULT '',
  `insp_pt2`        CHAR(10)   NOT NULL DEFAULT '',
  `insp_pt3`        CHAR(10)   NOT NULL DEFAULT '',
  `insp_pt4`        CHAR(10)   NOT NULL DEFAULT '',
  `insp_pt5`        CHAR(10)   NOT NULL DEFAULT '',
  `mactyp_id`       CHAR(9)    NOT NULL DEFAULT '',
  `set_up`          DECIMAL(12,4) NOT NULL DEFAULT 0,
  `prod_time`       DECIMAL(12,4) NOT NULL DEFAULT 0,
  `prod_time_per`   DECIMAL(12,4) NOT NULL DEFAULT 0,
  `def_pt1`         CHAR(15)   NOT NULL DEFAULT '',
  `def_pt2`         CHAR(15)   NOT NULL DEFAULT '',
  `def_pt3`         CHAR(15)   NOT NULL DEFAULT '',
  `def_pt4`         CHAR(15)   NOT NULL DEFAULT '',
  `def_pt5`         CHAR(15)   NOT NULL DEFAULT '',
  `print_flag`      CHAR(1)    NOT NULL DEFAULT '',
  `note_id`         INT        NOT NULL DEFAULT 0,
  `insp_pt6`        CHAR(10)   NOT NULL DEFAULT '',
  `def_pt6`         CHAR(15)   NOT NULL DEFAULT '',
  `nb_jrs`          SMALLINT   NOT NULL DEFAULT 0,
  `sum_id`          CHAR(9)    NOT NULL DEFAULT '',
  `insp6`           CHAR(40)   NOT NULL DEFAULT '',
  `insp7`           CHAR(40)   NOT NULL DEFAULT '',
  `insp8`           CHAR(40)   NOT NULL DEFAULT '',
  `insp9`           CHAR(40)   NOT NULL DEFAULT '',
  `norm`            CHAR(40)   NOT NULL DEFAULT '',
  `insp_pt7`        CHAR(10)   NOT NULL DEFAULT '',
  `insp_pt8`        CHAR(10)   NOT NULL DEFAULT '',
  `insp_pt9`        CHAR(10)   NOT NULL DEFAULT '',
  `insp_pt10`       CHAR(10)   NOT NULL DEFAULT '',
  `def_pt7`         CHAR(15)   NOT NULL DEFAULT '',
  `def_pt8`         CHAR(15)   NOT NULL DEFAULT '',
  `def_pt9`         CHAR(15)   NOT NULL DEFAULT '',
  `def_pt10`        CHAR(15)   NOT NULL DEFAULT '',
  `station`         CHAR(4)    NOT NULL DEFAULT '',
  `op_seq`          INT        NOT NULL DEFAULT 0,
  `print_label`     SMALLINT   NOT NULL DEFAULT 0,
  `def_stt_id`      INT        NOT NULL DEFAULT 0,
  `sum_type`        SMALLINT   NOT NULL DEFAULT 0,
  `last_operation`  SMALLINT   NOT NULL DEFAULT 0,
  `close_prec`      SMALLINT   NOT NULL DEFAULT 0,
  `csst_code`       CHAR(9)    NOT NULL DEFAULT '',
  `ops_type`        CHAR(1)    NOT NULL DEFAULT '',
  `charged`         SMALLINT   NOT NULL DEFAULT 0,
  `rejet`           SMALLINT   NOT NULL DEFAULT 0,
  `no_punch`        SMALLINT   NOT NULL DEFAULT 0,
  `hide`            SMALLINT   NOT NULL DEFAULT 0,
  `nb_jrs_prod`     SMALLINT   NOT NULL DEFAULT 0,
  `no_eval_rend`    CHAR(1)    NOT NULL DEFAULT '',
  `consommer_mtl`   SMALLINT   NOT NULL DEFAULT 0,
  `show_soumission` SMALLINT   NOT NULL DEFAULT 0,
  `index_excel`     SMALLINT   NOT NULL DEFAULT 0,
  `rnumber_serial`  SMALLINT   NOT NULL DEFAULT 0,
  `emballage`       SMALLINT   NOT NULL DEFAULT 0,
  `formation_req`   CHAR(9)    NOT NULL DEFAULT '',
  `form_niveaux`    CHAR(15)   NOT NULL DEFAULT '',
  `prototype`       SMALLINT   NOT NULL DEFAULT 0,
  PRIMARY KEY (`ops_id`),
  UNIQUE KEY `uq_ipso_opsfil_recnum` (`RECNUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
