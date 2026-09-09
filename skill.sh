#!/usr/bin/env bash

# Local skill registry
case "$1" in
  codebase-cleanup) echo "skills/codebase-cleanup/SKILL.md" ;;
  seo-setup)        echo "skills/seo-setup/SKILL.md" ;;
  git-skill)        echo "skills/git-skill/SKILL.md" ;;
  design-skill)     echo "skills/design-skill/SKILL.md" ;;
  *)
    echo "Usage: ./skill.sh <skill-name>"
    echo "Available skills: codebase-cleanup seo-setup git-skill design-skill"
    exit 1
    ;;
esac
