export const ONE_SECOND = 1000;
export const is200 = /^2\d\d$/;

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
