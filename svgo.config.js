module.exports = {
	multipass: true,
	js2svg: {
		indent: 2,
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
