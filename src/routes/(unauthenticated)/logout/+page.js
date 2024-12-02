import { session } from '$stores';
import { goto } from '$app/navigation';

export function load() {
	session.set({ organisation: null, token: null });

	return goto('/login');
}
