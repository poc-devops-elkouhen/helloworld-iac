# helloworld-iac

Manifests GitOps Kubernetes de l'application `helloworld`.

Le dossier `k8s/` contient les `Deployment`, `Service`, `HTTPRoute` et `kustomization.yaml` deployes par ArgoCD.

Le modele attendu reste une branche par environnement :

- `dev`
- `rec`
- `preprod`
- `main` pour la prod
