import 'phoenix_html';
import {ONE_SECOND, copyToClipboard, createDomNode, insertAfter, formatTime, onReady, postFormData, prepend, remove, validURL} from './tools.js';
import {squawkBoxTMPL, newKeyTMPL, squawkDisplayTMPL} from './templates.js';

let alertInfo;
let alertDanger;

let squawkForm;
let squawkBox;
let squawkURL;

function squawkCopy (squawkDisplay) {
	let squawk = squawkDisplay.getAttribute('data-squawk');
	squawkDisplay.addEventListener('click', () => copyToClipboard(squawk));
}

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

function wireUpSquawkDisplay (squawkDisplay) {
	squawkCopy(squawkDisplay);
	squawkCountdown(squawkDisplay);
}

function squawkSuccess (data) {
	let squawk = JSON.parse(data);
	squawk = typeof squawk === 'string' ? JSON.parse(squawk) : squawk;

	let newKey = newKeyTMPL(squawk);
	let squawkDisplay = squawkDisplayTMPL(squawk);

	let oldKey = document.querySelector('#new-key');
	if (oldKey) remove(oldKey);

	squawkURL.value = '';

	if (!squawkBox) {
		insertAfter(squawkForm, squawkBoxTMPL());
		squawkBox = document.querySelector('#squawk-box');
	}

	insertAfter(squawkForm, newKey);
	prepend(squawkBox, squawkDisplay);

	wireUpSquawkDisplay(squawkDisplay);
}

function squawkError (error) {
	console.error(error);
}

function submitSquawk (event) {
	event.preventDefault();

	alertInfo.innerHTML = '';
	alertDanger.innerHTML = '';

	let postURL = this.getAttribute('action');
	let formData = new FormData(this);

	if (validURL(squawkURL.value)) {
		postFormData(postURL, formData, squawkSuccess, squawkError);
	}
	else {
		alertDanger.innerHTML = 'Please enter a valid and complete (i.e. "https://...") URL.';
		squawkURL.focus();
	}
}

onReady(() => {
	alertInfo = document.querySelector('.alert-info');
	alertDanger = document.querySelector('.alert-danger');

	squawkForm = document.querySelector('#squawk-form');
	squawkBox = document.querySelector('#squawk-box');
	squawkURL = document.querySelector('#squawk_url');

	document.querySelectorAll('.squawk-display').forEach(wireUpSquawkDisplay);

	if (squawkForm) {
		squawkForm.addEventListener('submit', submitSquawk);
		squawkURL.focus();
	}
});
