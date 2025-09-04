#!/bin/bash
# ONE-STEP AI REELS SETUP

# 1️⃣ Create folders
mkdir -p config scripts viewer/scripts viewer/images

# 2️⃣ Create config.yaml
cat > config/config.yaml <<EOL
accounts:
  instagram:
    username: "test_instagram"
    password: "test_password"
  tiktok:
    username: "test_tiktok"
    password: "test_password"
  fanvue:
    username: "test_fanvue"
    password: "test_password"

personas:
  test_persona:
    name: "Test Blonde"
    style: "Indoor casual, soft natural light"
    prompt: "A blonde woman, slim-thick, natural light, cozy indoor"
    reel_source: "scripts/test_persona_reel.mp4"
    anchor_images:
      - "viewer/images/test_persona_anchor1.png"
      - "viewer/images/test_persona_anchor2.png"
EOL

# 3️⃣ Create generate_reel.sh
cat > scripts/generate_reel.sh <<'EOL'
#!/bin/bash
PERSONA="$1"
echo "Generating AI reel for $PERSONA..."
REEL_PATH="scripts/${PERSONA}_reel.mp4"
touch "$REEL_PATH"
echo "Dummy reel created at $REEL_PATH"
./extract_anchors.sh "$PERSONA"
EOL

# 4️⃣ Create extract_anchors.sh
cat > scripts/extract_anchors.sh <<'EOL'
#!/bin/bash
PERSONA="$1"
echo "Extracting anchor images for $PERSONA..."
IMG1="viewer/images/${PERSONA}_anchor1.png"
IMG2="viewer/images/${PERSONA}_anchor2.png"
touch "$IMG1" "$IMG2"
echo "Anchor images created: $IMG1, $IMG2"
EOL

# 5️⃣ Viewer files
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

# 6️⃣ README.md
cat > README.md <<EOL
# AI Reels Automation Setup
- Edit config/config.yaml with your accounts and personas
- Generate test reel:
  ./scripts/generate_reel.sh test_persona
- Anchors extracted automatically
- Add new personas/accounts to scale
EOL

# 7️⃣ Make scripts executable
chmod +x scripts/*.sh
chmod +x viewer/scripts/*.js

echo "✅ Setup complete! Repo structure created with test persona/account."
