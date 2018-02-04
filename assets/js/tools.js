export const ONE_SECOND = 1000;
export const is200 = /^2\d\d$/;

export function createDomNode (htmlString) {
	let host = document.createElement('div');
	host.innerHTML = htmlString;

	return [...host.childNodes].map(childNode => childNode.parentNode.removeChild(childNode));
}

export function insertAfter (afterThis, insertThis) {
	if (Array.isArray(insertThis)) {
		insertThis.reverse();
		insertThis.forEach(node => insertAfter(afterThis, node));
		insertThis.reverse();
	}
	else {
		afterThis.parentNode.insertBefore(insertThis, afterThis.nextSibling);
	}
}

export function noop () {}

export function onReady (callback) {
	if (document.readyState !== 'loading') callback();
	else document.addEventListener('DOMContentLoaded', callback);
}

export function postFormData(url, formData, callback = noop, errorback = noop) {
	let xhr = new XMLHttpRequest();

	xhr.onreadystatechange = () => {
		if (xhr.readyState > 3) {
			if (is200.test(xhr.status)) {
				callback(xhr.responseText);
			}
			else {
				errorback(xhr);
			}
		}
	};

	xhr.onerror = () => errorback(xhr);

	xhr.open('POST', url);
	xhr.timeout = ONE_SECOND;
	xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
	xhr.send(formData);

	return xhr;
}

export function prepend(el, prependThis) {
	el.insertBefore(prependThis, el.childNodes[0]);
}

export function remove (el) {
	el.parentNode.removeChild(el);
}
