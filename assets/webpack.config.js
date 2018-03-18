const path = require('path');

module.exports = {
	entry: {
		app: './js/app.js'
	},
	output: {
		filename: '[name].js',
		path: path.resolve(__dirname, '../priv/static/js')
	}
};

