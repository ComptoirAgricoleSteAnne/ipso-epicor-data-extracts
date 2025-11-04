# IPSO → Epicor Data Extracts

Requêtes SQL et documentation pour **l’extraction, le nettoyage et le mapping des données IPSO vers Epicor (Kinetic)**.  
Ce dépôt centralise les scripts d’intégration utilisés pour la migration et la synchronisation entre les deux systèmes.

---

## 📁 Structure du dépôt

```
docs/                  # Documentation fonctionnelle & technique
  specs/               # Spécifications de mapping par objet Epicor
scripts/
  extracts/
    ipso_to_epicor/
      production/      # Extractions liées à PRD*, OPS*, etc.
      logistics/       # Extractions shipments, transport
      finance/         # Coûts, inventaire, valorisation
  utils/               # Fonctions SQL réutilisables (formatage, nettoyage)
templates/             # Modèles (SQL, mapping CSV, test plan)
.github/ISSUE_TEMPLATE # Modèles de suivi des changements et anomalies
```

---

## 🧩 Conventions de nommage

**Fichiers SQL**  
```
EXTRACT_<domaine>__<source_table>__to__<epicor_object>.sql
```
**Exemple :**
```
EXTRACT_production__PRDBOM_PRDOPS__to__Epicor_JobMtl_OpDtl.sql
```

**Branche Git**
- `feature/<objet>` : ajout d’un nouvel extract ou d’une transformation
- `fix/<objet>` : correction ou ajustement d’un extract existant

---

## 🧠 Tables IPSO courantes

| Table | Description | Champs clés |
|--------|--------------|-------------|
| PRDBOM | Besoins de production (BOM) | `prd_id`, `itm_id`, `date_req`, `qte_alt` |
| PRDOPS | Opérations de production | `prd_id`, `prd_seq`, `ops_id`, `status` |
| ENSTOCK | Inventaire par localisation | `itm_id`, `loc_id`, `qte_alt` |
| INVFIL / INFVIL | Coûts standards | `std_mtl_cost`, `std_lab_cost`, `last_price`, `cout_date` |
| PRJSHP | Expéditions | `prd_id`, `prd_seq`, `itm_id`, `qte_alt` |

---

## 🧱 Exemple d’entête SQL standard

```sql
/*
 Nom : EXTRACT_production__PRDBOM_PRDOPS__to__Epicor_JobMtl_OpDtl.sql
 Auteur : Équipe Données
 Objectif : Extraire les requis de matière (PRDBOM) et le statut opération (PRDOPS) pour alimenter JobMtl/OpDtl dans Epicor.
 Contexte métier : Assurer la cohérence entre requis, avancement d'opérations et coûts pour les KPI de planification et OTIF.
 Tables source : PRDBOM, PRDOPS, ENSTOCK, INVFIL/INFVIL
 Cibles Epicor : JobMtl, OpDtl
 Transformations clés : Trim PartNum, consolidation de stock, statut expédition via ops_id=145 et status='X', coût MO via tarif interne.
 Dernière mise à jour : 2025-11-04
*/
```

---

## 🧪 Tests & validation

- Comparer les totaux par `prd_id` entre IPSO et Epicor (quantités, statuts).
- Vérifier les coûts standards et la cohérence parent/enfant.
- Contrôler la présence des champs obligatoires (dates, statuts, identifiants).
- Documenter les écarts dans le template `templates/test_plan.md`.

---

## ⚙️ Bonnes pratiques

- **Ne pas commiter de secrets** (connexions DB, credentials).
- **Commenter** chaque transformation non triviale.
- **Documenter** les mappings dans `docs/specs/` et les tests dans `templates/`.
- **Créer une issue** (Change Request ou Bug) pour toute modification structurelle.

---

## 📜 Licence

Projet sous licence MIT — utilisation et modification libre pour tout usage interne à CASA.

---

## 👥 Contact

**Équipe Données – CASA / Projet Epicor**  
📧 fdesrochers@comptoiragricole.com  
📦 Dossier GitHub : `ipso-epicor-data-extracts`
