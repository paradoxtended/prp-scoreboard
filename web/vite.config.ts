import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import path from 'node:path';
// https://vite.dev/config/
export default defineConfig({
    plugins: [svelte()],
    base: './',
    resolve: {
        alias: {
            $lib: path.resolve('./src/lib'),
            '~': path.resolve('../'),
        },
    },
    build: {
        outDir: 'dist',
        target: 'esnext',
    },
    esbuild: {
        logOverride: { 'this-is-undefined-in-esm': 'silent' },
    },
});
