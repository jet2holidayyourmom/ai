#!/bin/bash
# ===================================================
# Full AI Reels Automation Setup (Auto-ready version)
# ===================================================

echo "Starting full AI Reels Automation setup..."

# Root project folder
ROOT_DIR="ai-reels-automation"
mkdir -p "$ROOT_DIR"
cd "$ROOT_DIR" || exit

# 1️⃣ Create folder structure
declare -a DIRS=(
  "config"
  "scripts"
  "viewer/images"
  "viewer/scripts"
  ".github/workflows"
)
for dir in "${DIRS[@]}"; do
  mkdir -p "$dir"
done

# 2️⃣ Create config file with sample persona + account placeholders
cat > config/config.yaml <<EOL
# ==============================
# Add your accounts here
# ==============================
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

# ==============================
# Define your personas here
# ==============================
personas:
  test_persona:
    name: "Test Blonde"
    style: "Indoor casual, soft light"
    # Path to generated reel
    reel_source: "scripts/test_persona_reel.mp4"
    # Extracted anchor images
    anchor_images:
      - "viewer/images/test_persona_anchor1.png"
      - "viewer/images/test_persona_anchor2.png"
EOL

# 3️⃣ Generate Reel Script (with dummy Fal.ai API call)
cat > scripts/generate_reel.sh <<'EOL'
#!/bin/bash
PERSONA="$1"
echo "🔹 Generating AI reel for $PERSONA..."

# Placeholder: Replace this with Fal.ai or other AI API call
REEL_PATH="scripts/${PERSONA}_reel.mp4"
touch "$REEL_PATH"
echo "✅ Dummy reel created at $REEL_PATH"

# Optionally, automatically extract anchors from this reel
./extract_anchors.sh "$PERSONA"
EOL
chmod +x scripts/generate_reel.sh

# 4️⃣ Extract Anchor Images Script
cat > scripts/extract_anchors.sh <<'EOL'
#!/bin/bash
PERSONA="$1"
echo "🔹 Extracting anchor images for $PERSONA..."

IMG1="viewer/images/${PERSONA}_anchor1.png"
IMG2="viewer/images/${PERSONA}_anchor2.png"
# Dummy files for testing
touch "$IMG1" "$IMG2"
echo "✅ Dummy anchor images created: $IMG1, $IMG2"
EOL
chmod +x scripts/extract_anchors.sh

# 5️⃣ Viewer
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
console.log("Viewer loaded.");
// Example: Load reels/images dynamically
// Fetch persona info from config.yaml if needed
EOL
chmod +x viewer/scripts/viewer.js

# 6️⃣ README.md
cat > README.md <<EOL
# AI Reels Automation (Full Auto-ready)

## Usage

1. Add your accounts and personas in config/config.yaml.
2. Generate AI reel for a persona:
   ./scripts/generate_reel.sh test_persona
3. Anchors are automatically extracted after reel generation.
4. Preview reels/images locally in viewer/index.html.

## Adding More Personas
- Add a new persona in config/config.yaml
- Run:
  ./scripts/generate_reel.sh persona_name

## Notes
- Replace placeholder Fal.ai calls with real API integration.
- Anchor images are extracted automatically.
EOL

# Make all scripts executable
chmod +x scripts/*.sh
chmod +x viewer/scripts/*.js

echo "✅ Setup complete! Edit config/config.yaml with your accounts and new personas."
echo "Run './scripts/generate_reel.sh persona_name' to generate reels and anchor images."
