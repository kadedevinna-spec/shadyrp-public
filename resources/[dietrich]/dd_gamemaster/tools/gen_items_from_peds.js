const fs = require('fs');
const path = require('path');

function readFile(p) {
  return fs.readFileSync(p, 'utf8');
}

function sanitizeId(str) {
  return String(str)
    .toLowerCase()
    .replace(/\s+/g, '_')
    .replace(/[^a-z0-9_]/g, '_');
}

function isAnimal(model) {
  return model.startsWith('A_C_') || model.startsWith('MP_A_C_') || model === 'MP_PREDATOR';
}

function includesAny(haystack, needles) {
  const s = haystack.toLowerCase();
  return needles.some((n) => s.includes(n.toLowerCase()));
}

function detectGender(model) {
  const s = model.toLowerCase();
  // Strong markers first
  if (/(^|[_])females?(?:[_]|$)/i.test(model) || s.includes('_f_') || s.includes('mp_female') || s.includes('female_') || s.endsWith('_female')) {
    return 'female';
  }
  if (/(^|[_])males?(?:[_]|$)/i.test(model) || s.includes('_m_') || s.includes('mp_male') || s.includes('male_') || s.endsWith('_male')) {
    // Note: patterns like A_F_M_ contain both _f_ and _m_; we check _f_ first above
    return 'male';
  }
  return null;
}

function classifyAnimal(model) {
  const tags = ['animal'];
  let image = 'wild';
  const s = model.toLowerCase();

  const isHorseLike = includesAny(s, [
    'horse', 'mule', 'donkey', 'p_c_horse'
  ]);
  const isAquatic = includesAny(s, [
    'fish', 'shark', 'turtl', 'turtlesea', 'crab', 'crawfish', 'cormorant', 'pelican', 'seagull', 'duck', 'egret', 'heron'
  ]);
  const isDomestic = includesAny(s, [
    'cow', 'bull', 'sheep', 'pig', 'goat', 'chicken', 'cat', 'dog', 'rooster'
  ]);
  const isBird = includesAny(s, [
    'bluejay', 'cardinal', 'carolinaparakeet', 'cedarwaxwing', 'crow', 'eagle', 'egret', 'goose', 'hawk', 'heron', 'loon', 'oriole', 'owl',
    'parrot', 'pelican', 'pheasant', 'pigeon', 'prairiechicken', 'quail', 'raven', 'redfootedbooby', 'robin', 'rooster', 'roseatespoonbill',
    'seagull', 'songbird', 'sparrow', 'turkey', 'vulture', 'woodpecker'
  ]);
  const isDangerous = includesAny(s, [
    'bear', 'cougar', 'panther', 'wolf', 'alligator', 'lion', 'boar'
  ]);

  if (isHorseLike) {
    tags.push('horses');
    image = 'horses';
  } else if (isAquatic) {
    tags.push('aquatic');
    image = 'aquatic';
  } else if (isDomestic) {
    tags.push('domestic');
    image = 'domestic';
  } else if (isBird) {
    tags.push('birds');
    image = 'birds';
  } else if (isDangerous) {
    tags.push('dangerous');
    // Use wild image for dangerous animals per request
    image = 'wild';
  } else {
    tags.push('wild');
    image = 'wild';
  }

  // Optional temperament tag for dangerous wildlife
  if (tags.includes('dangerous')) {
    tags.push('hostile');
  }

  return { tags, image };
}

function classifyNpc(model) {
  const tags = ['npc'];
  let image = 'civil';
  const s = model.toLowerCase();

  const isLawman = (
    includesAny(s, ['law', 'deputy', 'sheriff', 'police', 'marshal', 'pinlaw', 'revenue', 'guard', 'bountyhunter', 'pinkerton'])
  );

  const isCriminal = (
    includesAny(s, [
      'criminal', 'bandit', 'duster', 'owlhoot', 'murfree', 'skinner', 'outlaw', 'poacher', 'exconfed', 'gang', 'goon', 'raider', 'thug',
      'kidnap', 'rob', 'prisoner', 'bountytarget', 'odriscoll', 'inbred'
    ])
  );

  if (isLawman && !isCriminal) {
    tags.push('lawman', 'armed', 'neutral');
    image = 'lawman';
  } else if (isCriminal && !isLawman) {
    tags.push('criminal', 'armed', 'hostile');
    image = 'criminal';
  } else if (isLawman && isCriminal) {
    // Rare ambiguous case: prefer lawman image, keep both tags
    tags.push('lawman', 'criminal', 'armed', 'hostile');
    image = 'lawman';
  } else {
    tags.push('civil', 'unarmed', 'neutral');
    image = 'civil';
  }

  const gender = detectGender(model);
  if (gender === 'male' || gender === 'female') {
    tags.push(gender);
    image = `${image}_${gender}`;
  }

  return { tags, image };
}

function generate() {
  const root = path.resolve(__dirname, '..');
  const pedsPath = path.join(root, 'client', 'dataHandler', 'peds.lua');
  const outPath = path.join(root, 'config', 'data_items_generated.lua');
  const lua = readFile(pedsPath);

  const models = [];
  const re = /"([^"]+)"/g;
  let m;
  while ((m = re.exec(lua)) !== null) {
    models.push(m[1]);
  }

  const lines = [];
  lines.push('GM = GM or {}');
  lines.push('GM.DataGeneratedItems = {');
  for (const model of models) {
    const id = sanitizeId(model);
    const type = isAnimal(model) ? 'animal' : 'npc';
    const classification = type === 'animal' ? classifyAnimal(model) : classifyNpc(model);
    const luaTags = `{${classification.tags.map((t) => `\'${t}\'`).join(', ')}}`;
    const imageName = classification.image;
    const line = `  { id = '${id}', name = '${model}', type = '${type}', image = 'images/items/${imageName}.webp', tags = ${luaTags}, model = '${model}', condition = 'anyone' },`;
    lines.push(line);
  }
  lines.push('}');
  lines.push('');

  fs.writeFileSync(outPath, lines.join('\n'));
  console.log(`Wrote ${models.length} items to ${outPath}`);
}

generate();


