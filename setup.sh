#!/usr/bin/env bash
#
# setup.sh — Bootstrap the .agents/ directory for a new project.
#
# Usage:
#   cd my-project
#   bash ~/dotagents/setup.sh
#
# What it does:
#   1. Copies the .agents directory (without installed skills) into the current directory
#   2. Clones the skill repos into .agents/skills/installed/
#   3. Initializes MEMORY.md from the template
#   4. Prints next steps

set -euo pipefail

DOTAGENTS_DIR="${HOME}/dotagents"
SKILLS_INSTALL_DIR=".agents/skills/installed"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}==> dotagents setup${NC}"
echo ""

# Check if dotagents source exists
if [ ! -d "${DOTAGENTS_DIR}" ]; then
    echo -e "${RED}Error:${NC} ${DOTAGENTS_DIR} not found."
    echo "Clone it first: git clone https://github.com/LoveKhatri/dotagents.git ~/dotagents"
    exit 1
fi

# Check we're in a project directory (not dotagents itself)
if [ "$(pwd)" = "${DOTAGENTS_DIR}" ]; then
    echo -e "${RED}Error:${NC} Don't run this from the dotagents repo itself."
    echo "cd into your project directory first."
    exit 1
fi

# Copy .agents without the installed/ subdirectory (those are cloned separately)
echo "Copying .agents structure..."
rsync -a --exclude='skills/installed/*/.git' \
         --exclude='skills/installed/superpowers/.git' \
         --exclude='skills/installed/mattpocock/.git' \
         --exclude='skills/installed/gstack/.git' \
         "${DOTAGENTS_DIR}/.agents/" .agents/

# ── SKILLS ──────────────────────────────────────────────

echo ""
echo -e "${YELLOW}==> Cloning skill collections...${NC}"

skill_count=0

clone_skill() {
    local name="$1"
    local repo="$2"
    local dir="${SKILLS_INSTALL_DIR}/${name}"

    if [ -d "${dir}/.git" ]; then
        echo "  ${name}: already installed, pulling latest..."
        git -C "${dir}" pull --ff-only 2>/dev/null || echo "  ${name}: pull failed (dirty tree?), skipping."
    else
        echo "  ${name}: cloning..."
        rm -rf "${dir}"
        if git clone "${repo}" "${dir}" 2>/dev/null; then
            skill_count=$((skill_count + 1))
        else
            echo -e "  ${RED}${name}: clone failed. Check network or repo URL.${NC}"
        fi
    fi
}

clone_skill "superpowers" "https://github.com/obra/superpowers.git"
clone_skill "mattpocock" "https://github.com/mattpocock/skills.git"
clone_skill "gstack"      "https://github.com/garrytan/gstack.git"

# ── MEMORY ──────────────────────────────────────────────

echo ""
echo -e "${YELLOW}==> Setting up memory...${NC}"

if [ ! -f ".agents/memory/MEMORY.md" ]; then
    cp "${DOTAGENTS_DIR}/.agents/memory/MEMORY.md" .agents/memory/MEMORY.md
    echo "  Created .agents/memory/MEMORY.md from template"
else
    echo "  MEMORY.md already exists, leaving it alone."
fi

# ── GITIGNORE ───────────────────────────────────────────

if [ -f ".gitignore" ]; then
    if ! grep -q "# .agents" .gitignore 2>/dev/null; then
        echo "" >> .gitignore
        cat >> .gitignore <<'GITIGNORE_EOF'

# .agents — agent skills/plugins are gitignored, rules/memory are tracked
.agents/skills/installed/
GITIGNORE_EOF
        echo "  Added .agents entries to existing .gitignore"
    else
        echo "  .gitignore already has .agents entries."
    fi
else
    cat > .gitignore <<'GITIGNORE_EOF'
node_modules/
dist/
.env
*.log

# .agents — agent skills/plugins are gitignored, rules/memory are tracked
.agents/skills/installed/
GITIGNORE_EOF
    echo "  Created .gitignore."
fi

# ── DONE ────────────────────────────────────────────────

echo ""
echo -e "${GREEN}==> Done!${NC}"
echo ""
echo "What was set up:"
echo "  .agents/skills/installed/  — skill collections (${skill_count}/3 cloned)"
echo "  .agents/memory/            — memory system ready"
echo "  .agents/rules/             — rule templates ready"
echo "  .agents/plugins/           — plugins directory ready"
echo ""
echo "Next steps:"
echo "  1. Edit .agents/memory/MEMORY.md with your project overview"
echo "  2. Review and customize .agents/rules/ for your project's needs"
echo "  3. Add project-specific skills if needed"
echo "  4. Commit the .agents/ directory (excluding skills/installed/)"
echo ""
echo "The agent will now pick up your skills, rules, and memory automatically."
