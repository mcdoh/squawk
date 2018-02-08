import {createDomNode} from './tools.js';

export function squawkBoxTMPL () {
	let template = `
		<div id="squawk-box"></div>
	`;

	return createDomNode(template.trim());
}

export function newKeyTMPL (data) {
	let template = `
		<div id="new-key">
			<h2>Your key: <strong>${ data.key }</strong></h2>
		</div>
	`;

	return createDomNode(template.trim())[0];
}

export function squawkDisplayTMPL (data) {
	let template = `
		<p class="squawk-display" data-squawk="${ data.squawk }" data-expiration="${ data.expiration }">
			<strong><a href="${ data.squawk }">${ data.key }</a></strong>: <a href="${ data.url }">${ data.url }</a><span class="squawk-expiration"></span> <button type="button" class="btn btn-sm btn-info">Copy</button>
		</p>
	`;

	return createDomNode(template.trim())[0];
}

