
# Spécification – JobMtl & OpDtl (IPSO → Epicor)

## Objet Epicor
- `JobMtl`: composantes matière
- `OpDtl`: opérations & suivi

## Tables source IPSO
- `PRDBOM` (requis matière)
- `PRDOPS` (opérations, `ops_id=145` point d'expédition, `status='X'` = complété)
- `ENSTOCK` (stock dispo par localisation)
- `INVFIL` (coûts standards)

## Mapping (extrait)
Voir `templates/mapping_template.csv`.

## Règles
- Parent/enfant: conserver la relation (ex: parent 200/300, enfants 201, 202, ...).
- Ne pas attribuer de no de PO aux kits fabriqués.
- `LaborCost` = somme(temps opération) * 210 $/h (paramétrable).
