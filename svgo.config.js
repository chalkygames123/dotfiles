module.exports = {
	multipass: true,
	js2svg: {
		indent: 2,
		pretty: true,
	},
	plugins: [
		{
			name: 'preset-default',
			params: {
				overrides: {
					removeUnknownsAndDefaults: {
						keepDataAttrs: false,
					},
					removeViewBox: false,
				},
			},
		},
		'convertStyleToAttrs',
		'reusePaths',
		'sortAttrs',
	],
};
