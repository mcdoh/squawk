import 'phoenix_html';
import {ONE_SECOND, createDomNode, insertAfter, formatTime, onReady, postFormData, prepend, remove} from './tools.js';
import {squawkBoxTMPL, newKeyTMPL, squawkDisplayTMPL} from './templates.js';

let squawkForm;
let squawkBox;

function squawkCountdown (squawkDisplay) {
	let expiration = parseInt(squawkDisplay.getAttribute('data-expiration'));
	let squawkExpiration = squawkDisplay.querySelectorAll('.squawk-expiration')[0];

	let sqwkCountdown = () => {
		let timeRemaining = parseInt((expiration - Date.now()) / ONE_SECOND);

		if (timeRemaining > 0) {
			if (timeRemaining < 30) {
				squawkExpiration.innerHTML = formatTime(timeRemaining);
			}

			setTimeout(sqwkCountdown, ONE_SECOND);
		}
		else {
			remove(squawkDisplay);

			if (!document.querySelectorAll('.squawk-display').length) {
				remove(document.querySelector('#new-key'));

				remove(squawkBox);
				squawkBox = null;
			}
		}
	};

	sqwkCountdown();
}

function squawkSuccess (data) {
	let squawk = JSON.parse(data);
	squawk = typeof squawk === 'string' ? JSON.parse(squawk) : squawk;

	let newKey = newKeyTMPL(squawk);
	let squawkDisplay = squawkDisplayTMPL(squawk);

	let oldKey = document.querySelector('#new-key');
	if (oldKey) remove(oldKey);

	if (!squawkBox) {
		insertAfter(squawkForm, squawkBoxTMPL());
		squawkBox = document.querySelector('#squawk-box');
	}

	insertAfter(squawkForm, newKey);
	prepend(squawkBox, squawkDisplay);

	squawkCountdown(squawkDisplay);
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

	document.querySelectorAll('.squawk-display').forEach(squawkCountdown);

	squawkForm.addEventListener('submit', submitSquawk);
});
