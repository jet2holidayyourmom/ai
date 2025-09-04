#!/bin/bash
# ================================================
# GitHub Repo Full AI Reels Setup (One-Step)
# ================================================

# Replace this with your repo URL
REPO_URL="https://github.com/YOUR_USERNAME/ai-reels-automation.git"

# 1️⃣ Clone the repo (or use existing)
git clone "$REPO_URL"
REPO_NAME=$(basename "$REPO_URL" .git)
cd "$REPO_NAME" || exit

# 2️⃣ Create folders and placeholder files
declare -a FILES=(
"config/config.yaml"
"scripts/generate_reel.sh"
"scripts/extract_anchors.sh"
"viewer/index.html"
"viewer/scripts/viewer.js"
"README.md"
)

for f in "${FILES[@]}"; do
  # Create parent folders automatically
  mkdir -p "$(dirname "$f")"
  # Create file if it does not exist
  if [ ! -f "$f" ]; then
    touch "$f"
  fi
done

# 3️⃣ Add content to config/config.yaml
cat > config/config.yaml <<EOL
accounts:
  instagram:
    username: "your_instagram"
    password: "your_password"
  tiktok:
    username: "your_tiktok"
    password: "your_password"
  fanvue:
    username: "your_fanvue"
    password: "your_password"

personas:
  test_persona:
    name: "Test Blonde"
    style: "Indoor casual, soft light"
    reel_source: "scripts/test_persona_reel.mp4"
    anchor_images:
      - "viewer/images/test_persona_anchor1.png"
      - "viewer/images/test_persona_anchor2.png"
EOL

# 4️⃣ Add content to generate_reel.sh
cat > scripts/generate_reel.sh <<'EOL'
#!/bin/bash
PERSONA="$1"
echo "Generating AI reel for $PERSONA..."
REEL_PATH="scripts/${PERSONA}_reel.mp4"
touch "$REEL_PATH"
echo "Dummy reel created at $REEL_PATH"
./extract_anchors.sh "$PERSONA"
EOL

# 5️⃣ Add content to extract_anchors.sh
cat > scripts/extract_anchors.sh <<'EOL'
#!/bin/bash
PERSONA="$1"
echo "Extracting anchor images for $PERSONA..."
IMG1="viewer/images/${PERSONA}_anchor1.png"
IMG2="viewer/images/${PERSONA}_anchor2.png"
touch "$IMG1" "$IMG2"
echo "Dummy anchors created: $IMG1, $IMG2"
EOL

# 6️⃣ Add viewer files
cat > viewer/index.html <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AI Reels Viewer</title>
</head>
<body>
<h1>AI Reels Viewer</h1>
<div id="reels-container"></div>
<script src="scripts/viewer.js"></script>
</body>
</html>
EOL

cat > viewer/scripts/viewer.js <<EOL
console.log("Viewer loaded. Display reels and anchors here.");
EOL

# 7️⃣ Add README.md
cat > README.md <<EOL
# AI Reels Automation

## Usage

1. Edit config/config.yaml with your accounts and personas.
2. Generate AI reel:
   ./scripts/generate_reel.sh test_persona
3. Extract anchors (auto after generation):
   ./scripts/extract_anchors.sh test_persona
4. Preview:
   Open viewer/index.html in browser.

## Adding Personas
- Add new persona in config/config.yaml
- Run scripts with the persona name
EOL

# 8️⃣ Make scripts executable
chmod +x scripts/*.sh
chmod +x viewer/scripts/*.js

# 9️⃣ Commit everything to GitHub
git add .
git commit -m "Initial AI Reels project structure with test persona"
git push origin main

echo "✅ All done! Repo is ready with folders, files, and test persona."
