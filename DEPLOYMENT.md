# 🚀 Medusa Backend Deployment to Render

This guide will help you deploy your Medusa backend to Render using your existing Supabase database.

## 📋 Prerequisites

1. **GitHub Repository**: Your Medusa backend code must be pushed to GitHub
2. **Render Account**: Sign up at [render.com](https://render.com)
3. **Supabase Database**: Already configured with your connection string
4. **Node.js 20+**: Required for the backend

## 🏗️ Architecture Overview

Your deployment will include:

- **🗄️ Supabase PostgreSQL Database**: Your existing database
- **🔧 Medusa Backend API**: Medusa server

## 📦 Step 1: Prepare Your Repository

### Push to GitHub
```bash
git add .
git commit -m "Prepare for Render deployment"
git push origin main
```

### Verify Repository Structure
Ensure your repository has:
```
├── src/                      # Medusa source code
├── package.json             # Dependencies
├── medusa-config.ts         # Configuration
├── render.yaml              # Render configuration
├── deploy.sh                # Deployment script
└── DEPLOYMENT.md            # This file
```

## 🚀 Step 2: Deploy to Render

### Method A: Using Render Dashboard (Recommended)

1. **Go to [Render Dashboard](https://dashboard.render.com)**
2. **Click "New +" → "Blueprint"**
3. **Connect your GitHub repository**
4. **Select your repository** (your medusa backend repo)
5. **Render will detect `render.yaml`** and show 1 service:
   - `medusa-backend` (Node.js API)
6. **Click "Apply"** to create the blueprint
7. **Click "Deploy Blueprint"** to start deployment

### Method B: Manual Deployment

1. **Go to [Render Dashboard](https://dashboard.render.com)**
2. **Click "New +" → "Web Service"**
3. **Connect your GitHub repository**
4. **Configure the service:**
   - **Name**: `medusa-backend`
   - **Root Directory**: `/` (root of your repo)
   - **Build Command**: `yarn install && yarn build`
   - **Start Command**: `yarn start`
   - **Health Check Path**: `/health`
   - **Environment Variables**:
     - `NODE_ENV=production`
     - `PORT=10000`
     - `DATABASE_URL=postgresql://postgres.uydlqgdvowwrstsflzpl:Saurabh2026@aws-1-ap-south-1.pooler.supabase.com:5432/postgres`
     - `JWT_SECRET` (auto-generated)
     - `COOKIE_SECRET` (auto-generated)
     - `STORE_CORS=https://your-storefront-url.com`
     - `ADMIN_CORS=https://your-admin-url.com`
     - `AUTH_CORS=https://your-admin-url.com`

## ⚙️ Step 3: Configure Services (Post-Deployment)

### Database Setup
Your Supabase database is already configured and ready to use!

### Seed Initial Data
Once the backend is deployed:

1. **Go to medusa-backend service**
2. **Click on "Shell" tab**
3. **Run the seed command**:
   ```bash
   yarn seed
   ```

This will create:
- Sample products (T-shirts, sweatshirts, etc.)
- Categories and collections
- Shipping options
- Tax regions
- API keys

## 🌐 Step 4: Access Your Service

After successful deployment, your service will be available at:

| Service | URL | Description |
|---------|-----|-------------|
| **Backend API** | `https://medusa-backend.onrender.com` | REST API endpoints |

## 🔧 Step 5: Post-Deployment Configuration

### Update CORS Settings (if needed)
If you encounter CORS issues:

1. **Go to medusa-backend service settings**
2. **Update environment variables**:
   ```
   STORE_CORS=https://medusa-storefront.onrender.com
   ADMIN_CORS=https://medusa-admin.onrender.com
   AUTH_CORS=https://medusa-admin.onrender.com
   ```
3. **Redeploy the backend service**

### Custom Domain (Optional)
1. **Purchase a domain** from any registrar
2. **Go to each service settings**
3. **Navigate to "Custom Domains"**
4. **Add your domain** and configure SSL

## 🛠️ Troubleshooting

### Common Issues

#### Build Failures
- **Check Node.js version**: Must be 20+
- **Verify dependencies**: Run `yarn install` locally first
- **Check build logs**: View detailed logs in Render dashboard

#### Database Connection Issues
- **Verify DATABASE_URL**: Should start with `postgresql://`
- **Check database status**: Ensure PostgreSQL is running
- **Wait for migration**: Database setup takes time

#### Service Communication Issues
- **Check environment variables**: Ensure services can find each other
- **Verify CORS settings**: Update URLs if services change
- **Check service logs**: Look for connection errors

### Environment Variables Reference

| Variable | Service | Description |
|----------|---------|-------------|
| `DATABASE_URL` | Backend, Admin | PostgreSQL connection string |
| `JWT_SECRET` | Backend, Admin | JWT signing secret |
| `COOKIE_SECRET` | Backend, Admin | Cookie encryption secret |
| `STORE_CORS` | Backend, Admin | Storefront CORS origin |
| `ADMIN_CORS` | Backend, Admin | Admin CORS origin |
| `AUTH_CORS` | Backend, Admin | Auth CORS origin |
| `NEXT_PUBLIC_MEDUSA_BACKEND_URL` | Storefront | Backend API URL |
| `NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY` | Storefront | Public API key |

## 📊 Monitoring and Logs

### View Logs
1. **Go to your service in Render dashboard**
2. **Click "Logs" tab**
3. **Monitor real-time logs** for errors

### Service Health Checks
- **Backend**: `GET https://your-backend.onrender.com/health`
- **Storefront**: `GET https://your-storefront.onrender.com`
- **Admin**: `GET https://your-admin.onrender.com`

## 🚀 Production Considerations

### Free Tier Limitations
- **750 hours/month** per service
- **Services sleep** after 15 minutes of inactivity
- **Cold start time**: 30-60 seconds

### Upgrade to Paid Plans
For production use:
1. **Upgrade database** to paid plan for persistence
2. **Add custom domains** for branding
3. **Set up monitoring** and alerts
4. **Configure backups** for data safety

### Performance Optimization
1. **Enable caching** for static assets
2. **Optimize images** in the storefront
3. **Set up CDN** for global performance
4. **Monitor resource usage** regularly

## 🔒 Security Best Practices

1. **Use strong secrets**: All JWT and cookie secrets are auto-generated
2. **Enable HTTPS**: All Render services use SSL by default
3. **Regular updates**: Keep dependencies updated
4. **Monitor access**: Use Render's built-in logging

## 📞 Support

### Getting Help
1. **Render Documentation**: [docs.render.com](https://docs.render.com)
2. **Medusa Documentation**: [docs.medusajs.com](https://docs.medusajs.com)
3. **Community Discord**: [Medusa Discord](https://discord.com/invite/medusajs)

### Common Commands
```bash
# Check service status
render services

# View logs for a service
render logs medusa-backend

# Restart a service
render restart medusa-backend

# Update environment variables
render env set NODE_ENV=production --service medusa-backend
```

## 🎉 Success Checklist

- [ ] All 4 services deployed successfully
- [ ] Database connection working
- [ ] Sample data seeded
- [ ] Storefront accessible
- [ ] Admin dashboard working
- [ ] API responding correctly
- [ ] No CORS errors
- [ ] All environment variables configured

## 🔄 Updates and Maintenance

### Updating Your Store
1. **Push changes to GitHub**
2. **Render auto-deploys** on git push
3. **Monitor deployment logs**
4. **Test all services** after deployment

### Backup Strategy
- **Database backups**: Configured automatically by Render
- **Code backups**: Use Git for version control
- **Environment variables**: Document and backup manually

---

**🎊 Congratulations! Your Medusa store is now live on Render!**

Visit your storefront and start customizing your e-commerce experience!
