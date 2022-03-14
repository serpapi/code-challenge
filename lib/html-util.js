const REGEXP_HEAD_TAG = /<head>/gi;
const REGEXP_SET_IMG_SRC = /function _setImagesSrc/gi;
const REPLACEMENT_SET_IMG_SRC = "window._setImagesSrc = _setImagesSrc; function _setImagesSrc";
const INJECTED_SCRIPT = `<script>(${emulateLargeScreen.toString()})()</script>`;
const REPLACEMENT_HEAD_TAG = `<head>${INJECTED_SCRIPT}`;

export { patch };

function patch(html) {
    return html
        .replace(REGEXP_HEAD_TAG, REPLACEMENT_HEAD_TAG)
        .replaceAll(REGEXP_SET_IMG_SRC, REPLACEMENT_SET_IMG_SRC); // make sure _setImagesSrc is global (jsdom bug)
}

function emulateLargeScreen() {
    window.document.documentElement.__defineGetter__("clientWidth", () => Infinity);
}