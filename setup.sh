#!/bin/bash

echo "🚀 Setting up Business Opportunity Analyzer..."

# Initialize npm
npm init -y

# Install all dependencies
echo "📦 Installing dependencies..."
npm install express express-rate-limit helmet cors compression dotenv \
  jsonwebtoken bcryptjs joi sequelize pg pg-hstore redis ioredis bull \
  axios @googlemaps/google-maps-services-js node-cron winston morgan \
  uuid @turf/turf ml-regression natural sentiment

# Install dev dependencies
npm install -D nodemon jest supertest eslint prettier sequelize-cli \
  eslint-config-airbnb-base eslint-plugin-import husky lint-staged

# Create all source files
echo "📁 Creating source files..."

# Create server.js
cat > server.js << 'EOF'
const express = require('express');
require('dotenv').config();
const app = require('./src/app');
const { sequelize } = require('./src/models');
const logger = require('./src/utils/logger');

const PORT = process.env.PORT || 3000;

async function startServer() {
  try {
    await sequelize.authenticate();
    logger.info('Database connected');
    
    if (process.env.NODE_ENV === 'development') {
      await sequelize.sync({ alter: true });
    }
    
    app.listen(PORT, () => {
      logger.info(`Server running on port ${PORT}`);
    });
  } catch (error) {
    logger.error('Failed to start server:', error);
    process.exit(1);
  }
}

startServer();
EOF

echo "✅ Setup complete!"
echo "📝 Next steps:"
echo "1. Copy .env.example to .env and add your API keys"
echo "2. Set up PostgreSQL database"
echo "3. Run: npm run setup:db"
echo "4. Run: npm run dev"
