import { mite } from '$lib/mite';
import { goto } from '$app/navigation';
import { session } from '$stores';
import { get } from 'svelte/store';

export const ssr = false;

export async function load({ url }) {
	const { organisation, token } = get(session);

	if (!organisation || !token) {
		if (url.pathname === '/login') {
			return { myself: {}, account: {} };
		}

		goto('/login');

		return { myself: {}, account: {} };
	}

	const [myself, account] = await Promise.all([mite.myself(), mite.account()]);
	return { myself, account };
}
