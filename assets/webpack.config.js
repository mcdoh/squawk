const fs = require('fs');
const path = require('path');

let concatCSS = [{
	target: '../priv/static/css/app.css',
	files: [
		path.join(__dirname, 'css', 'phoenix.css'),
		path.join(__dirname, 'css', 'app.css'),
	]
}];

concatCSS.forEach(css=> {
	css.files.forEach((file, index) => {
		let contents = fs.readFileSync(file, 'utf-8');

		fs.writeFileSync(css.target, contents,  {flag: index === 0 ? 'w' : 'a'});
	});
});

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

