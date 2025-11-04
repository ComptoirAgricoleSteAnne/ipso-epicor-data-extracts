
/*
 Nom: EXTRACT_<domaine>__<source_table>__to__<epicor_object>.sql
 Auteur: <Votre nom>
 Objectif: Décrire l’extraction IPSO vers l’objet Epicor ciblé
 Contexte métier: <résumé>
 Tables source: <EX: PRDBOM, PRDOPS, ENSTOCK, INFVIL, INVFIL, PRJSHP>
 Cibles Epicor: <EX: JobHead, JobMtl, OpDtl, PartTran, CustomerShipment>
 Transformations clés: <ex: mapping unités, conversions, statut, dates>
 Dépendances: <vues/fonctions>
 Hypothèses: <ex: status='X' = complété; ops_id=145 = OK expédition>
 Dernière mise à jour: <YYYY-MM-DD>
*/
-- PARAMÈTRES (si applicable)
-- DECLARE @DateFrom date = '2025-01-01';
-- DECLARE @DateTo   date = '2025-12-31';

-- TODO: Remplacer par la logique d’extraction spécifique et alignée à docs/specs/<objet>.md
SELECT TOP (100)
    <cols...>
FROM <schema>.PRDBOM b
LEFT JOIN <schema>.PRDOPS o
    ON o.prd_id = b.prd_id AND o.prd_seq = b.prd_seq
LEFT JOIN <schema>.ENSTOCK s
    ON s.itm_id = b.itm_id
WHERE 1=1
  -- AND b.date_req BETWEEN @DateFrom AND @DateTo
  -- AND o.ops_id = 145
  -- AND o.status = 'X'
;
