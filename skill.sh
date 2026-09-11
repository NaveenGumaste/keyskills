#!/usr/bin/env bash

# Local skill registry. The CLI lists five suite names; each name
# resolves to the suite router plus every nested SKILL.md so install
# copies the whole folder. Nested skills stay in the tree but are
# shadowed in `npx skills add --list` by the parent SKILL.md.

git_paths="skills/git-skill/SKILL.md skills/git-skill/git-init/SKILL.md skills/git-skill/git-commit/SKILL.md skills/git-skill/git-pr/SKILL.md"
seo_paths="skills/seo-setup/SKILL.md skills/seo-setup/seo-meta/SKILL.md skills/seo-setup/seo-crawl/SKILL.md skills/seo-setup/seo-schema/SKILL.md skills/seo-setup/seo-aeo/SKILL.md"
cleanup_paths="skills/codebase-cleanup/SKILL.md skills/codebase-cleanup/cleanup-files/SKILL.md skills/codebase-cleanup/cleanup-deps/SKILL.md skills/codebase-cleanup/cleanup-tidy/SKILL.md skills/codebase-cleanup/cleanup-lint/SKILL.md skills/codebase-cleanup/cleanup-secrets/SKILL.md skills/codebase-cleanup/cleanup-a11y/SKILL.md"
devops_paths="skills/devops-skill/SKILL.md skills/devops-skill/devops-inspect/SKILL.md skills/devops-skill/devops-env/SKILL.md skills/devops-skill/devops-ci/SKILL.md skills/devops-skill/devops-docker/SKILL.md skills/devops-skill/devops-terraform/SKILL.md skills/devops-skill/devops-observe/SKILL.md skills/devops-skill/devops-deploy/SKILL.md"
design_paths="skills/design-skill/SKILL.md"

case "$1" in
  git-skill|git)                     echo "$git_paths" ;;
  seo-setup|seo)                     echo "$seo_paths" ;;
  codebase-cleanup|cleanup)          echo "$cleanup_paths" ;;
  devops-skill|devops)               echo "$devops_paths" ;;
  design-skill|design)               echo "$design_paths" ;;

  # Nested files (not listed in usage; parent install already includes them)
  git-init)        echo "skills/git-skill/git-init/SKILL.md" ;;
  git-commit)      echo "skills/git-skill/git-commit/SKILL.md" ;;
  git-pr)          echo "skills/git-skill/git-pr/SKILL.md" ;;
  seo-meta)        echo "skills/seo-setup/seo-meta/SKILL.md" ;;
  seo-crawl)       echo "skills/seo-setup/seo-crawl/SKILL.md" ;;
  seo-schema)      echo "skills/seo-setup/seo-schema/SKILL.md" ;;
  seo-aeo)         echo "skills/seo-setup/seo-aeo/SKILL.md" ;;
  cleanup-files)   echo "skills/codebase-cleanup/cleanup-files/SKILL.md" ;;
  cleanup-deps)    echo "skills/codebase-cleanup/cleanup-deps/SKILL.md" ;;
  cleanup-tidy)    echo "skills/codebase-cleanup/cleanup-tidy/SKILL.md" ;;
  cleanup-lint)    echo "skills/codebase-cleanup/cleanup-lint/SKILL.md" ;;
  cleanup-secrets) echo "skills/codebase-cleanup/cleanup-secrets/SKILL.md" ;;
  cleanup-a11y)    echo "skills/codebase-cleanup/cleanup-a11y/SKILL.md" ;;
  devops-inspect)   echo "skills/devops-skill/devops-inspect/SKILL.md" ;;
  devops-env)       echo "skills/devops-skill/devops-env/SKILL.md" ;;
  devops-ci)        echo "skills/devops-skill/devops-ci/SKILL.md" ;;
  devops-docker)    echo "skills/devops-skill/devops-docker/SKILL.md" ;;
  devops-terraform) echo "skills/devops-skill/devops-terraform/SKILL.md" ;;
  devops-observe)   echo "skills/devops-skill/devops-observe/SKILL.md" ;;
  devops-deploy)    echo "skills/devops-skill/devops-deploy/SKILL.md" ;;

  *)
    echo "Usage: ./skill.sh <skill-name>"
    echo "Available skills (install these — each includes its sub-skills):"
    echo "  git-skill"
    echo "  design-skill"
    echo "  seo-setup"
    echo "  codebase-cleanup"
    echo "  devops-skill"
    exit 1
    ;;
esac
