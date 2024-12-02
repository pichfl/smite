import { mite } from '$lib/mite';

export async function load() {
	const [projects, services] = await Promise.all([mite.projects(), mite.services()]);

	return { projects, services };
}
