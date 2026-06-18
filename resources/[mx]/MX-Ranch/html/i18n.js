/**
 * MX-Ranch NUI i18n — loads locales/{locale}.json at resource root (default: en).
 * Use window.t('section.key', { var: 'value' }) for placeholders like {var}.
 */
(function () {
  let dict = {};
  const DEFAULT_LOCALE = 'en';

  function deepGet(obj, path) {
    return path.split('.').reduce(function (o, k) {
      return o != null && o[k] !== undefined ? o[k] : undefined;
    }, obj);
  }

  function translate(path, vars) {
    let s = deepGet(dict, path);
    if (typeof s !== 'string') return path;
    if (vars && typeof vars === 'object') {
      Object.keys(vars).forEach(function (k) {
        const re = new RegExp('\\{' + k + '\\}', 'g');
        s = s.replace(re, String(vars[k]));
      });
    }
    return s;
  }

  function localeJsonUrl(locale) {
    const loc = locale || DEFAULT_LOCALE;
    const file = 'locales/' + loc + '.json';
    if (typeof GetParentResourceName === 'function') {
      return 'https://cfx-nui-' + GetParentResourceName() + '/' + file;
    }
    try {
      return new URL('../' + file, window.location.href).href;
    } catch (e) {
      return file;
    }
  }

  window.t = translate;

  window.initRanchI18n = async function (locale) {
    const url = localeJsonUrl(locale || DEFAULT_LOCALE);
    try {
      const r = await fetch(url, { cache: 'no-store' });
      if (!r.ok) throw new Error('HTTP ' + r.status);
      dict = await r.json();
    } catch (e) {
      console.warn('[MX-Ranch] i18n load failed, using empty dict:', url, e);
      dict = {};
    }
    window.RANCH_LOCALE = dict.locale || DEFAULT_LOCALE;
    window.RANCH_STRINGS = dict;
  };
})();
