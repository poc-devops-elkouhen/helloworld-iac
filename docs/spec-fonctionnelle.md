# Spec fonctionnelle

## Rôle GitOps

Le dépôt représente l'état désiré de `helloworld` dans Kubernetes. Les
utilisateurs ne déploient pas directement avec `kubectl` : ils modifient Git,
puis ArgoCD applique l'état déclaré.

## Environnements

Le modèle fonctionnel est une branche par environnement :

- `dev` pour les merges continus de `main` côté code ;
- `rec` pour le premier environnement de release ;
- `preprod` pour le gate intermédiaire ;
- `main` pour la production.

Chaque branche contient la même structure de manifests, avec des tags d'image
potentiellement différents.

## Ressources applicatives

Le dépôt déclare deux services :

- `helloworld-svc`, API backend ;
- `helloworld-gui`, frontend statique.

Chaque service dispose d'un `Deployment` et d'un `Service`. Les entrées HTTP
sont décrites avec `HTTPRoute`, conformément à la cible Gateway API du POC.

## Mise à jour des versions

Les tags d'image ne sont pas modifiés à la main dans les `Deployment`. La CI
applicative met à jour `k8s/kustomization.yaml`, puis pousse un commit sur la
branche d'environnement cible.

## Rollback

Le rollback fonctionnel de production consiste à revenir sur un commit de la
branche `main` de ce dépôt. Le pipeline partagé fournit un job de revert gated
côté dépôt applicatif.
