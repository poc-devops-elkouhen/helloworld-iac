# Spec technique

## Structure

Le répertoire `k8s/` contient :

- `helloworld-svc-deployment.yaml` ;
- `helloworld-svc-service.yaml` ;
- `helloworld-svc-route.yaml` ;
- `helloworld-gui-deployment.yaml` ;
- `helloworld-gui-service.yaml` ;
- `helloworld-gui-route.yaml` ;
- `kustomization.yaml`.

## Kustomize

`k8s/kustomization.yaml` référence les manifests et le bloc `images`. Ce bloc
est le point d'édition unique pour les promotions CI/CD.

Le script `deploy.py` du template CI charge ce fichier avec PyYAML, met à jour
`newTag` pour chaque image déclarée dans `SERVICES`, puis commite le résultat.

## Routage

Les expositions HTTP sont décrites par des `HTTPRoute`. Elles s'appuient sur
la Gateway partagée installée par `cluster` et consommée par
`platform-cicd`.

## Branches

La correspondance technique attendue est :

- `dev` vers le namespace `helloworld-dev` ;
- `rec` vers `helloworld-rec` ;
- `preprod` vers `helloworld-preprod` ;
- `main` vers `helloworld` (pas de suffixe `-prod` : c'est le namespace de
  production, voir `AGENTS.md`).

Les `Application` ArgoCD générées par la plateforme pointent chacune vers la
branche et le namespace correspondants.

## Sécurité et limites

Le dépôt est modifié par un token CI configuré dans GitLab. Les protections de
branches et limites associées sont celles documentées dans le PRD plateforme.
Dans ce POC mono-opérateur, les branches d'environnement restent volontairement
simples.
