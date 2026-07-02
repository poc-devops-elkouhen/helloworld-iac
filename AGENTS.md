# AGENTS.md — helloworld-iac

## Rôle du dépôt

`helloworld-iac` est le dépôt GitOps de l'application `helloworld`. ArgoCD
surveille ses branches directement pour synchroniser l'état du cluster.

## Branches et environnements

| Branche | Environnement | Namespace K8s |
|---------|---------------|---------------|
| `dev`     | dev           | `helloworld-dev` |
| `rec`     | rec           | `helloworld-rec` |
| `preprod` | preprod       | `helloworld-preprod` |
| `main`    | prod          | `helloworld` |

## Structure `k8s/`

```
kustomization.yaml          Références de ressources + overrides d'images
helloworld-svc-deployment.yaml
helloworld-svc-service.yaml
helloworld-svc-route.yaml   HTTPRoute Gateway API
helloworld-gui-deployment.yaml
helloworld-gui-service.yaml
helloworld-gui-route.yaml   HTTPRoute Gateway API
```

## Règles critiques

- **Ne pas éditer `kustomization.yaml` manuellement** pour les champs `images`.
  Ces valeurs sont mises à jour automatiquement par `scripts/deploy.py` de
  `ci-templates` à chaque déploiement CI.
- **Les hostnames des HTTPRoutes** sont aussi mis à jour par `deploy.py`.
  Les valeurs dans `main` représentent l'état prod (`helloworld-svc.192.168.33.100.nip.io`).
- **Le nom d'image dans les Deployments** doit correspondre exactement au champ
  `name` dans `kustomization.yaml` pour que l'override Kustomize s'applique.
  Convention : utiliser l'image GHCR complète (`ghcr.io/poc-devops-elkouhen/<svc>`).

## Ce qu'il ne faut pas faire

- Ne pas committer de secrets dans ce dépôt.
- Ne pas pousser directement sur les branches d'environnement (`dev`, `rec`,
  `preprod`) — ces branches sont alimentées par la CI via `deploy.py`.
- Ne pas construire d'images depuis ce dépôt.
