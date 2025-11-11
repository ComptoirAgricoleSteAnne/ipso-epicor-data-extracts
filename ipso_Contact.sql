USE dmt_dataloader;

DROP TABLE IF EXISTS ipso_contact;

CREATE TABLE ipso_contact (
  RECNUM       INT NOT NULL AUTO_INCREMENT,         -- était IDENTITY(1,1)
  ctc_id       INT NOT NULL DEFAULT 0,
  cie_id       CHAR(15)  NOT NULL DEFAULT '',
  lastname     CHAR(20)  NOT NULL DEFAULT '',
  firstname    CHAR(20)  NOT NULL DEFAULT '',
  tel          CHAR(20)  NOT NULL DEFAULT '',
  fax          CHAR(20)  NOT NULL DEFAULT '',
  tel_ext      CHAR(6)   NOT NULL DEFAULT '',
  titre        CHAR(20)  NOT NULL DEFAULT '',
  boss         INT       NOT NULL DEFAULT 0,
  dept         CHAR(6)   NOT NULL DEFAULT '',
  prompt       CHAR(4)   NOT NULL DEFAULT '',
  lng_id       CHAR(3)   NOT NULL DEFAULT '',
  -- SQL Server utilisait 0001-01-01 ; dans MySQL le minimum est 1000-01-01
  date_naiss   DATE      NOT NULL DEFAULT '1000-01-01',
  note_id      INT       NOT NULL DEFAULT 0,
  name         CHAR(40)  NOT NULL DEFAULT '',
  email        CHAR(80)  NOT NULL DEFAULT '',
  note         LONGTEXT  NOT NULL,                  -- TEXT/LONGTEXT n’acceptent pas de DEFAULT dans MySQL
  add1         CHAR(40)  NOT NULL DEFAULT '',
  add2         CHAR(40)  NOT NULL DEFAULT '',
  add3         CHAR(40)  NOT NULL DEFAULT '',
  add4         CHAR(40)  NOT NULL DEFAULT '',
  tel_home     CHAR(20)  NOT NULL DEFAULT '',
  tel_cell     CHAR(20)  NOT NULL DEFAULT '',
  mass_email   CHAR(1)   NOT NULL DEFAULT '',
  active       CHAR(1)   NOT NULL DEFAULT '',
  vendor_id    CHAR(9)   NOT NULL DEFAULT '',
  ccdocs       CHAR(20)  NOT NULL DEFAULT '',

  -- PK composée (identique à SQL Server)
  PRIMARY KEY (cie_id, name, firstname, lastname),

  -- RECNUM était IDENTITY mais pas PK ; défini comme UNIQUE pour préserver l’usage
  UNIQUE KEY uq_ipso_contact_recnum (RECNUM)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;
