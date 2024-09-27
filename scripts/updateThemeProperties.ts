// scripts/updateThemeProperties.ts
import { readdirSync, writeFileSync } from 'fs';
import { join } from 'path';

const distDir = join(__dirname, '../theme/keywind/login/resources/dist');
const files = readdirSync(distDir);

const cssFile = files.find(file => file.endsWith('.css'));
const jsFile = files.find(file => file.endsWith('.js') && file.startsWith('index'));

if (!cssFile || !jsFile) {
  throw new Error('CSS or JS file not found in the dist directory');
}

const themePropertiesContent = `
parent=base
styles=dist/${cssFile}
scripts=dist/${jsFile}
`;

writeFileSync(join(__dirname, '../theme/keywind/login/theme.properties'), themePropertiesContent.trim());
console.log('theme.properties updated successfully');