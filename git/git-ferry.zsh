#!/usr/bin/env zsh

echo "Transferring $(gh repo view --json name -q ".name") from voraciousdev to charonsboat..."

gh api -X POST repos/{owner}/{repo}/transfer -f new_owner=charonsboat
