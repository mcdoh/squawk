import 'phoenix_html';
import {createDomNode, insertAfter, onReady, postFormData, prepend, remove} from './tools.js';
import {squawkBoxTMPL, newKeyTMPL, squawkTMPL} from './templates.js';

let squawkForm;
let squawkBox;

function squawkSuccess (data) {
	let squawk = JSON.parse(data);
	squawk = typeof squawk === 'string' ? JSON.parse(squawk) : squawk;

	let newKeyEl = newKeyTMPL(squawk);
	let squawkEl = squawkTMPL(squawk);

	let oldKey = document.querySelector('#new-key');
	if (oldKey) remove(oldKey);

	if (!squawkBox) {
		insertAfter(squawkForm, squawkBoxTMPL());
		squawkBox = document.querySelector('#squawk-box');
	}

	insertAfter(squawkForm, newKeyEl);
	prepend(squawkBox, squawkEl);
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
	squawkBox = document.querySelector('#squawk-box');

	squawkForm.addEventListener('submit', submitSquawk);
});
