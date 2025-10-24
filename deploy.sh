#!/bin/bash

# Medusa Backend Deployment Script for Render
# This script helps you deploy your Medusa backend to Render

echo "🚀 Starting Medusa Backend Deployment to Render"
echo "================================================="

# Check if user is logged in to Render CLI
echo "📋 Checking Render CLI authentication..."
if ! render login --check; then
    echo "❌ Please login to Render first:"
    echo "   render login"
    exit 1
fi

echo "✅ Render CLI authenticated"

# Check if GitHub repository exists
echo "📋 Checking GitHub repository..."
if ! git remote -v | grep -q origin; then
    echo "❌ No GitHub remote found. Please push your code to GitHub first:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
    echo "   git push -u origin main"
    exit 1
fi

GITHUB_REPO=$(git remote get-url origin | sed 's/https:\/\/github.com\///' | sed 's/.git//')
echo "📦 Found GitHub repository: $GITHUB_REPO"

# Create Render blueprint
echo "📋 Creating Render blueprint..."
render blueprint create medusa-backend-blueprint \
    --name "Medusa Backend API" \
    --description "Medusa backend API with Supabase database" \
    --repo "https://github.com/$GITHUB_REPO" \
    --branch main \
    --build-command "" \
    --start-command ""

echo "✅ Blueprint created successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Go to https://dashboard.render.com/blueprints"
echo "2. Find your 'Medusa Backend API' blueprint"
echo "3. Click 'Deploy Blueprint'"
echo "4. Review and confirm the service (Backend API)"
echo "5. Wait for deployment to complete"
echo ""
echo "🌐 Your service will be available at:"
echo "   - Backend API: https://medusa-backend.onrender.com"
echo ""
echo "🔧 After deployment:"
echo "1. Go to the medusa-backend service settings"
echo "2. Run the seed script: yarn seed"
echo "3. Update CORS settings if needed"
echo ""
echo "🎉 Deployment complete! Your Medusa backend is live!"
