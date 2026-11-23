# Spectra for Linux, Agent Guidelines

These rules govern agent work in this repository,
luinbytes/spectra-linux. This repo is the Linux packaging and build
repo for Spectra, forked from imputnet/helium-linux. The core
browser lives in luinbytes/spectra, which has its own AGENTS.md;
the shared rules there (documentation on every change, the README
watch list pattern, the Codex review loop) apply here too. This
file covers what is specific to the Linux build, plus the same
housekeeping discipline, so the two repos never drift apart
unnoticed. Nothing in this file authorises contributions to
upstream imputnet repositories.

## What lives here, and what does not

- The browser source arrives through the helium-chromium
  submodule. Its home is luinbytes/spectra: PR #1 in this repo
  moves the submodule URL from imputnet/helium to
  luinbytes/spectra, and once that lands the submodule must keep
  pointing at luinbytes/spectra. Never point it back at upstream,
  and never edit the submodule's contents from this repo or commit
  changes inside it. Core changes belong in luinbytes/spectra, in
  its own patch layer.
- This repo owns: the Linux patch set under patches/, packaging
  under package/, build scripts, the Docker builder images, and
  the CI workflows that turn the core into Linux binaries,
  AppImages, and deb packages.
- A submodule bump is a change like any other: its own branch and
  PR, saying which core commit it moves to and why. The automated
  bump workflow proposes; a PR still gets reviewed and Codex
  checked before merge.

## Documentation is part of every change

- For every PR, actively check whether README.md or any other
  documentation here is affected, and update what is affected in
  the same PR. If nothing is affected, say so in the PR description
  and say why.
- Watch for statements that are true today and will go false later,
  especially: download and install instructions, which version of
  Helium or Spectra a package is, and anything describing the
  artifacts as Helium's once Spectra's own builds ship. When your
  change makes one false, updating it is part of your change.
- The packaging currently ships Helium named artifacts
  (package/helium.desktop, helium wrapper scripts, the
  net.imput.helium metainfo). That is correct until the rebrand
  step lands; when it does, every one of those files is renamed or
  updated in that same change, and this paragraph is updated with
  it. Until then, do not half rename individual files.

## Pull requests and the Codex review

- Every PR here gets an automatic review from ChatGPT Codex. After
  opening or pushing, check the review, fix everything valid in the
  same PR, push, and re-check the re-review until it is clean.
- If a finding is wrong, reply on the PR explaining why instead of
  silently ignoring it.
- Never report a PR as ready before the Codex check has happened,
  and state its status plainly when reporting to Lu.

## Branches stay clean

- main is always buildable. Nobody pushes to main directly; every
  change arrives by PR with CI green and the Codex review checked.
- One branch per change, named for what it does, with a short kind
  prefix: feat/, fix/, docs/, agents/, chore/, ci/.
- Branches are short lived. One still open and untouched after
  about two weeks needs a decision: finish it, or close it and
  record what is left in the sweep list below. Delete branches
  when their PR merges or closes.
- Keep an open branch current with main while it lives. Never
  rewrite history on main.

## CI and builds stay healthy

- The Build Linux release workflow is the way Spectra for Linux
  gets built: on GitHub Actions, from main or a PR branch, never
  as a hand built one off on someone's machine for anything that
  ships.
- Never merge with red CI, and never disable, skip, or weaken a
  check (including the patch series lint) to get green. Fix the
  cause, or record it in the sweep list below and leave the PR
  unmerged.
- Workflow changes get their own branch and PR, and the changed
  workflow must run successfully on the branch before merge
  wherever the trigger allows.
- Builds here are long and split into stages. Cancel runs that no
  longer matter; one current build per branch is enough. Do not
  queue duplicate full builds to "see if it passes this time"
  without changing something first.
- Keep the versions of the actions the workflows use current; they
  are on the maintenance sweep below.
- Secrets and signing material never appear in workflow files,
  logs, or artifacts. pubkey.asc is the public key and is fine;
  private signing keys never enter this repo. A workflow that
  needs a new secret stops and asks Lu.

## Releases are deliberate

- Linux releases are created by the Build Linux release workflow
  with its release option, from green main only, and carry notes:
  what changed, what is known broken, and the Helium, Chromium,
  and Spectra core versions inside.
- Never edit, move, or delete a published release or its tag.
  Fixes ship as a new release.
- The deb repo workflow publishes packages people install from.
  Treat changes to it as release changes: extra care, own PR, and
  a successful dry run where possible.
- A release that fails partway gets reported and recorded in the
  sweep list below, never left half published and silent.

## Nothing gets forgotten

Lu's standing rule for this project: nothing is left to go stale,
unmaintained, or forgotten about.

- Every deferred item or follow up goes in exactly one durable
  place before its PR closes: an entry in the sweep list below, by
  default. A follow up that only exists in a PR description, a
  review comment, or a chat does not exist.
- GitHub issues in Lu's repositories are work orders for his agent
  swarms: an opened issue is picked up by the swarm, worked through
  to a PR, and left for Lu to review. That is a global rule of Lu's.
  So open an issue only when the item is meant to be solved by the
  swarm, never as passive tracking or parking, and write it
  descriptively and helpfully, because the swarm works from the
  issue text alone: what is wanted, why, and what done looks like.
- Resolved issues close automatically, or they do not count as
  resolved. A PR that resolves an issue must name it with a closing
  keyword (Closes #N, Fixes #N) in its description, aimed at the
  branch the issue will actually land through, so GitHub closes the
  issue when the work merges. Stacked PRs need care here: if the
  resolving PR merges into another PR's branch rather than main,
  the keyword only fires when that chain reaches main, so the
  description must make the chain obvious.
- Whoever merges the resolving work verifies afterwards that the
  issue actually closed. If it is still open, close it manually in
  the same session, with a short note linking the merged PR. An
  issue whose work has landed must never be left sitting open;
  issue #6 in luinbytes/spectra sat open after its PRs merged, and
  Lu had to point it out. That is the failure this rule exists to
  prevent.
- When you notice something stale while doing other work, fix it
  in scope or record it in the sweep list in the same session.
  Noticing and walking past is the failure this section exists to
  prevent.

### The maintenance sweep

On a regular pass, and whenever Lu asks for a tidy up, check each
of these and act on what you find. Add new aging things here in
the change that introduces them.

- The submodule: is the pinned core commit the one we mean to
  ship, and are upstream Helium core changes being absorbed in
  luinbytes/spectra on purpose rather than by drift?
- Upstream imputnet/helium-linux changes worth absorbing here.
- Workflows, and the versions of the actions they use.
- The Docker builder images and their base image pins.
- downloads.ini and the Chromium tarball source it points at.
- Open branches, PRs, and issues: anything untouched for about
  two weeks gets triaged, closed with a reason, or picked up.
- The core repo's AGENTS.md: rule changes there get considered
  for this file, and vice versa, in the same piece of work.
- Packaging facts: desktop file, metainfo, wrapper scripts, and
  the deb repo metadata still match what the build produces.

## Repository hygiene

- No build output, tarballs, packages, or AppImages get committed.
  Build products belong on releases or in CI artifacts, not git.
- Keep the Linux patch series tidy and passing its lint; a patch
  that stops applying is fixed or removed in the change that
  breaks it.
- This repo and everything unique to it or to Helium in it is
  GPL-3.0. Keep the license files and upstream credits intact.
