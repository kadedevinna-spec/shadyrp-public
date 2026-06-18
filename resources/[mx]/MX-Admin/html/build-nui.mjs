/**
 * MX-Admin NUI build
 *
 * O layout completo vive em index.html (sidebar, vistas, modais). Este script
 * apenas valida os marcadores obrigatórios para o app.js — não regenera HTML a
 * partir de templates desatualizados (isso sobrescrevia o painel alinhado).
 *
 * Uso: node build-nui.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const indexPath = path.join(__dirname, 'index.html');

const MAIN_OPEN = '<main class="adm-content">';
const MODAL_MARK = '<!-- Modal jogador -->';

const raw = fs.readFileSync(indexPath, 'utf8');
const iMain = raw.indexOf(MAIN_OPEN);
const iModal = raw.indexOf(MODAL_MARK);

if (iMain < 0 || iModal < 0 || iModal <= iMain) {
  console.error('build-nui: em index.html falta', MAIN_OPEN, 'ou', MODAL_MARK);
  process.exit(1);
}

const beforeMain = raw.slice(0, iMain + MAIN_OPEN.length);
const mainInner = raw.slice(iMain + MAIN_OPEN.length, iModal);
const afterModal = raw.slice(iModal);
const out = beforeMain + mainInner + afterModal;

if (out !== raw) {
  fs.writeFileSync(indexPath, out, 'utf8');
  console.log('build-nui: gravado', indexPath, `(${fs.statSync(indexPath).size} bytes)`);
} else {
  console.log('build-nui: OK —', path.basename(indexPath), 'válido,', fs.statSync(indexPath).size, 'bytes');
}
