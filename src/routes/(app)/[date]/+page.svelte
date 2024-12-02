<script>
	import { pseudoEnhance } from '$lib/forms.js';
	import { goto } from '$app/navigation';
	import { mite } from '$lib/mite';
	import { task } from 'svelte-concurrency';
	import { page } from '$app/stores';
	import Plus from '$components/icons/plus.svelte';

	import Calendar from '$components/Calendar.svelte';
	import InputProject from '$components/InputProject.svelte';
	import InputService from '$components/InputService.svelte';
	import InputDuration from '$components/InputDuration.svelte';
	import Entries from '../../../components/Entries.svelte';

	const entriesTask = task(async (date = $page.params.date) => {
		return await mite.entries(date.toString());
	});

	entriesTask.perform();

	const enhance = pseudoEnhance((data) => {
		console.log('enhanced', data);
	});

	const onSelectDate = (date) => {
		entriesTask.perform(date);
		goto(`/${date.toString()}`);
	};

	export let data;
</script>

<Calendar {onSelectDate} />

<form class="select" use:enhance>
	<section class="section">
		<InputProject projects={data.projects} />
	</section>

	<section class="section">
		<InputService services={data.services} />
	</section>

	<div class="section">
		<div class="action">
			<InputDuration />
			<button type="submit" aria-label="Add"><Plus /></button>
		</div>

		<Entries entries={$entriesTask.lastSuccessful} />
	</div>
</form>

<style>
	form {
		max-width: 70rem;
		margin: 0 auto;
		gap: 1.25rem;
		display: grid;
		grid-template-columns: 1fr 1fr 2fr;
	}

	.section {
		position: relative;
		z-index: 1;
		background: #fff;
		border-radius: 0.75rem;
		padding: 1rem;
		box-shadow: 0 0.5rem 1rem -0.25rem var(--blue-500);
	}

	.action {
		display: flex;
		gap: 0.5rem;
		align-items: center;
	}

	.action > * {
		flex: 1 1 auto;
	}

	.action button {
		padding: 0.5rem 1rem;
		border-radius: 2rem;
		background: var(--blue-500);
		aspect-ratio: 1 / 1;
		color: color-mix(in srgb, #fff 80%, transparent);
		box-shadow: 0 0 0 0.7rem var(--blue-200);
		transition: box-shadow 0.2s ease-in-out;
	}

	.action button:hover {
		background: var(--blue-700);
		color: color-mix(in srgb, #fff 100%, transparent);
		box-shadow: 0 0 0 0.9rem var(--blue-200);
	}

	.action button:active {
		background: var(--blue-700);
		color: color-mix(in srgb, #fff 100%, transparent);
		box-shadow: 0 0 0 0.4rem var(--blue-300);
		transition: box-shadow 0.1s ease-in-out;
	}
</style>
