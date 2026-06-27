# PRD

## Intention du projet

`helloworld-iac` est le dépôt GitOps de l'application `helloworld`. Il porte
l'état Kubernetes attendu par ArgoCD pour les environnements applicatifs du
POC.

La vision globale de la plateforme et le rôle des dépôts manifests sont
décrits dans `../../poc-devops-platform/docs/prd.md`.

## Produit attendu

Le dépôt doit fournir une source de vérité déclarative pour déployer
`helloworld` :

- un backend `helloworld-svc` ;
- un frontend `helloworld-gui` ;
- les Services Kubernetes associés ;
- les routes HTTP via Gateway API ;
- les références d'images gérées par Kustomize.

## Critères d'acceptation

- Le dossier `k8s/` contient tous les manifests nécessaires au déploiement.
- `k8s/kustomization.yaml` référence tous les manifests et les images.
- Les branches `dev`, `rec`, `preprod` et `main` représentent les
  environnements.
- Les mises à jour d'image sont faites par la CI de `helloworld`.
- ArgoCD peut synchroniser chaque branche vers son namespace cible.

## Non-objectifs

- Construire les images applicatives.
- Porter la logique de promotion.
- Contenir des secrets applicatifs non chiffrés.
