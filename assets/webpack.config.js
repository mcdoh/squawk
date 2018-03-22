const path = require('path');

module.exports = {
	entry: {
		app: [path.join(__dirname, 'js', 'app.js')],
		admin: [path.join(__dirname, 'src', 'js', 'admin.js')]
	},
	output: {
		filename: '[name].js',
		path: path.resolve(__dirname, '../priv/static/js')
	}
};

