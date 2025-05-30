// rollup.config.mjs
import { babel }      from '@rollup/plugin-babel';
import resolve        from '@rollup/plugin-node-resolve';
import nodePolyfills  from 'rollup-plugin-polyfill-node';
import commonjs       from '@rollup/plugin-commonjs';
import pkg            from './package.json' with { type: 'json' };

const PLUGINS = [
    // so Rollup can find its dependencies
	resolve({ preferBuiltins: false, mainFields: ['browser'] }),
	commonjs(), // so Rollup can convert dependendies to ES modules
    babel({ babelHelpers: 'bundled' }),
    nodePolyfills()
];

export default [
    {
        input: 'rdf.js',
        output: {
            name: 'RDF',
            file: '../target/asset/rdf.js',
            format: 'umd'
        },
	plugins: PLUGINS
    },
    {
        input: 'd3.js',
        output: {
            name: 'd3',
            file: '../target/asset/d3.js',
            format: 'umd'
        },
	plugins: PLUGINS
    },
    // browser-friendly UMD build
    {
        external: ['rdf', 'd3'],
        input: 'rdf-viz.js',
        output: {
            name: 'RDFViz',
            globals: {
                rdf: 'RDF',
                d3:  'd3'
            },
	    file: '../target/asset/rdf-viz.js',
	    format: 'umd'
        },
	plugins: PLUGINS
    },
    {
        external: ['rdf', 'd3', 'rdf-viz'],
	input: 'force-directed.js',
	output: {
	    name: 'ForceRDF',
            globals: {
                rdf:       'RDF',
                d3:        'd3',
                'rdf-viz': 'RDFViz',
            },
	    file: '../target/asset/force-directed.js',
	    format: 'umd'
	},
	plugins: PLUGINS
    },
    {
        external: ['rdf', 'd3', 'rdf-viz', 'complex'],
	input: 'hierarchical.js',
	output: {
	    name: 'HierRDF',
            globals: {
                rdf:       'RDF',
                d3:        'd3',
                'rdf-viz': 'RDFViz',
                'complex': 'Complex'
            },
	    file: '../target/asset/hierarchical.js',
	    format: 'umd'
	},
	plugins: PLUGINS
    },
];
