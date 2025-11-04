
# Dictionnaire de données – IPSO (extrait à compléter)

| Table | Champ | Type | Description | Notes |
|------|-------|------|-------------|-------|
| PRDBOM | prd_id | NVARCHAR | Identifiant projet |  |
| PRDBOM | itm_id | NVARCHAR | Identifiant article |  |
| PRDBOM | date_req | DATE | Date requise |  |
| PRDBOM | qte_alt | DECIMAL | Quantité requise |  |
| PRDOPS | prd_seq | INT | Séquence |  |
| PRDOPS | ops_id | INT | Identifiant opération | 145 = contrôle expédition |
| PRDOPS | status | CHAR(1) | Statut opération | 'X' = complété |
| ENSTOCK | loc_id | NVARCHAR | Localisation |  |
| ENSTOCK | qte_alt | DECIMAL | Quantité | Somme par itm_id/loc_id |
| INVFIL | std_mtl_cost | DECIMAL | Coût standard matière |  |
| INVFIL | std_lab_cost | DECIMAL | Coût standard main d'oeuvre |  |
| INVFIL | last_price | DECIMAL | Dernier coût d'achat |  |
| INVFIL | cout_date | DATE | Date du coût |  |
