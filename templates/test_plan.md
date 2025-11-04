
# Plan de tests – IPSO → Epicor (objet: <à compléter>)

## Jeux d’essai
- Échantillon de 20 `prd_id` couvrant: kits parent/enfant, mfg_code A/S/B, opérations 145 complétées et non complétées.
- Cas limites: `qte_alt` = 0, dates nulles, statuts inattendus.

## Règles de validation
- Concordance des totaux par `prd_id` (requis vs expédié vs stock).
- Champs obligatoires non nuls: JobNum, PartNum, dates requises, statuts.
- Conversions d’unités (si présentes) validées par un tableau de correspondance.

## Procédure
1. Exécuter l’extract dans un environnement de test (lecture seule).
2. Exporter l’échantillon (CSV sécurisé).
3. Comparer avec rapports de référence (Epicor/Tile+).
4. Documenter les écarts et corriger la logique.

## Critères d’acceptation
- 0 champ obligatoire manquant
- Écarts quantitatifs < 0,5 % par `prd_id`
