<script>
	import { task } from 'svelte-concurrency';
	import Lock from './icons/lock.svelte';

	export let entries = [];

	function parseDuration(minutes) {
		const hours = Math.floor(minutes / 60);
		const remainder = minutes % 60;
		return `${hours}h ${remainder ? remainder + 'm' : ''}`;
	}
</script>

<table>
	<tbody>
		{#each entries as { timeEntry: entry } (entry.id)}
			<tr>
				<td>{entry.customerName}</td>
				<td>{entry.projectName}</td>
				<td>{parseDuration(entry.minutes)}</td>
				<td>
					{#if entry.locked}
						<Lock />
					{/if}
				</td>
				<td>
					<button type="button"> Delete </button>
				</td>
			</tr>
		{/each}
	</tbody>
</table>

<style>
	table {
		width: 100%;
		margin-top: 2rem;
		table-layout: auto;
	}

	td:last-child {
		text-align: right;
	}
</style>
