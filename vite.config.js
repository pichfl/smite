import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vitest/config';
import { concurrencyTransform } from 'svelte-concurrency/vite';

export default defineConfig({
	plugins: [sveltekit(), concurrencyTransform()],
	test: {
		include: ['src/**/*.{test,spec}.{js,ts}']
	}
});
