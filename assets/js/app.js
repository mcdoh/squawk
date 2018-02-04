import 'phoenix_html';
import {ONE_SECOND, createDomNode, insertAfter, onReady, postFormData} from './tools.js';

let squawkForm;

function newSquawkTMPL (data) {
	let template = `
		<div class="new-squawk">
			<p>Your key: <strong>${ data.key }</strong></p>
			<p>Your link: <a href="${ data.squawk }">${ data.squawk }</a></p>
			<p>Expires: ${ new Date(data.expiration * ONE_SECOND) }</p>
		</div>
	`;

	return template.trim();
}

function squawkSuccess (data) {
	let squawk = JSON.parse(data);
	squawk = typeof squawk === 'string' ? JSON.parse(squawk) : squawk;

	let squawkEl = createDomNode(newSquawkTMPL(squawk));

	insertAfter(squawkForm, squawkEl[0]);
}

function squawkError (error) {
	console.error(error);
}

function submitSquawk (event) {
	event.preventDefault();

	let postURL = this.getAttribute('action');
	let formData = new FormData(this);

	postFormData(postURL, formData, squawkSuccess, squawkError);
}

onReady(() => {
	squawkForm = document.querySelector('#squawk-form');

	squawkForm.addEventListener('submit', submitSquawk);
});
