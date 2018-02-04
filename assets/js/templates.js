
export function squawkBoxTMPL () {
	let template = `
		<hr />
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

export function squawkTMPL (data) {
	let template = `
		<p data-expiration="${ data.expiration }">
			<strong><a href="${ data.squawk }">${ data.key }</a></strong>: <a href="${ data.url }">${ data.url }</a><span class="squawk-expiration">1:23</span>
		</p>
	`;

	return createDomNode(template.trim())[0];
}

