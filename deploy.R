# ============================================================
# deploy.R — One-click deploy for Iluahmad GitHub Pages site
# ============================================================

# -----------------------------
# 1. Set your repository path
# -----------------------------
repo_path <- "C:/Users/Ahmad Ilu/OneDrive - The Nigerian Economic Summit Group (NESG)/Desktop/PC/Lenovo 2023/ACCER 2020/RESEARCH COLLECTION/Rstudio/GitHub/WEBSITE/Iluahmad"
setwd(repo_path)
message("Working directory set to: ", repo_path)

# -----------------------------
# 2. Set Git identity
# -----------------------------
system('git config --global user.name "Iluahmad"')
system('git config --global user.email "ILUAHMAD7@YAHOO.COM"')
message("Git identity set")

# -----------------------------
# 3. Pull latest changes
# -----------------------------
message("Pulling latest changes from GitHub...")
system("git pull origin main --allow-unrelated-histories")

# -----------------------------
# 4. Render Quarto site
# -----------------------------
message("Rendering Quarto website...")
quarto::quarto_render()

# -----------------------------
# 5. Stage changes
# -----------------------------
system("git add .")

# -----------------------------
# 6. Commit changes
# -----------------------------
commit_msg <- paste0("Auto-deploy: ", Sys.time())
system(paste0('git commit -m "', commit_msg, '"'))

# -----------------------------
# 7. Push to GitHub
# -----------------------------
message("Pushing changes to GitHub...")
system("git push origin main")

message("✔ Website deployed successfully!")
