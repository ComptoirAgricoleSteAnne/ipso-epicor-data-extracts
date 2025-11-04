
/*
 Nom: EXTRACT_production__PRDBOM_PRDOPS__to__Epicor_JobMtl_OpDtl.sql
 Auteur: Équipe Données
 Objectif: Extraire les requis de matière (PRDBOM) et le statut opération (PRDOPS) pour alimenter JobMtl/OpDtl dans Epicor.
 Contexte métier: Assurer cohérence entre requis, avancement d'opérations et coûts pour l'OTIF et la planification.
 Tables source: PRDBOM, PRDOPS, ENSTOCK, INVFIL/INFVIL
 Cibles Epicor: JobMtl, OpDtl
 Transformations clés: Trim part, consolidation stock, statut expédition via ops_id=145 et status='X', coût main d'oeuvre via tarif interne.
 Dépendances: scripts/utils/formatting.sql
 Hypothèses: ops_id=145 = contrôle expédition; kits parent/enfant conservés.
 Dernière mise à jour: 2025-11-04
*/
-- Paramètres
DECLARE @TarifHoraire DECIMAL(10,2) = 210.00;

WITH base AS (
    SELECT
        b.prd_id,
        b.prd_seq,
        b.itm_id,
        dbo.fn_NormalizePartNum(b.itm_id) AS PartNum,
        b.date_req,
        b.qte_alt AS ReqQty,
        o.ops_id,
        o.status AS OpsStatus,
        CASE WHEN o.ops_id = 145 AND o.status = 'X' THEN 1 ELSE 0 END AS ShipReadyFlag
    FROM dbo.PRDBOM b
    LEFT JOIN dbo.PRDOPS o
        ON o.prd_id = b.prd_id AND o.prd_seq = b.prd_seq
),
stock AS (
    SELECT itm_id, SUM(COALESCE(qte_alt,0)) AS OnHandQty
    FROM dbo.ENSTOCK
    GROUP BY itm_id
),
cost AS (
    SELECT
        i.itm_id,
        COALESCE(i.std_mtl_cost, 0) AS StdMtlCost,
        COALESCE(i.std_lab_cost, 0) AS StdLabCost, -- coût standard si disponible
        COALESCE(i.last_price, NULL) AS LastPrice,
        i.cout_date
    FROM dbo.INVFIL i
)
SELECT
    a.prd_id                                   AS JobNum,         -- Epicor JobHead.JobNum
    a.prd_seq                                  AS AssemblySeq,    -- si applicable
    a.PartNum                                  AS JobMtl_PartNum, -- Epicor JobMtl.PartNum
    a.ReqQty                                   AS JobMtl_RequiredQty,
    s.OnHandQty                                 AS PartWhse_OnHandQty,
    a.ShipReadyFlag                             AS OpDtl_UD_ShipReady_c,
    c.StdMtlCost                                AS JobMtl_MaterialCost_Std,
    -- Exemple de coût de main d'oeuvre basé sur temps opération (si vous avez une colonne TempsMin)
    CASE WHEN a.OpsStatus = 'X' THEN (@TarifHoraire * 1.0 /*TempsHeures à remplacer*/) ELSE 0 END AS OpDtl_LaborCost_Calc,
    c.LastPrice,
    c.cout_date
FROM base a
LEFT JOIN stock s ON s.itm_id = a.itm_id
LEFT JOIN cost c  ON c.itm_id = a.itm_id
WHERE 1=1
;
