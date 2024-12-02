<script>
	import { localStorageStore } from '$stores/localStorage.js';
	import EyeSlash from './icons/eye-slash.svelte';
	import Eye from './icons/eye.svelte';
	import Details from './Details.svelte';

	export let services = [];

	let hidden = localStorageStore('hiddenServices', []);
	let previousService = localStorageStore('previousService', '');

	$: hiddenServices = services.filter(({ service: { id } }) => $hidden.includes(id));
	$: visibleServices = services.filter(({ service: { id } }) => !$hidden.includes(id));

	function toggleHidden(id) {
		hidden.update((h) => {
			if (h.includes(id)) {
				return h.filter((h) => h !== id);
			} else {
				if (id === $previousService) {
					$previousService = '';
				}
				return [...h, id];
			}
		});
	}

	function resetHidden() {
		hidden.reset();
	}
</script>

<fieldset>
	<legend class="hidden">Services</legend>
	<ul class="services">
		<li class="checkable">
			<label>
				<input
					type="radio"
					name="service"
					value=""
					on:focus={() => ($previousService = '')}
					checked={$previousService === ''}
				/>
				<span>None</span>
			</label>

			<button type="button" on:click={() => toggleHidden(id)} aria-label="Hide">
				<EyeSlash />
			</button>
		</li>

		{#each visibleServices as { service: { id, name } } (id)}
			<li class="checkable">
				<label>
					<input
						type="radio"
						name="service"
						value={id}
						on:focus={() => ($previousService = id)}
						checked={$previousService === id}
					/>
					<span>{name}</span>
				</label>

				<button type="button" on:click={() => toggleHidden(id)} aria-label="Hide">
					<EyeSlash />
				</button>
			</li>
		{/each}
	</ul>

	{#if hiddenServices.length > 0}
		<Details summary="Hidden services">
			<ul class="services">
				{#each hiddenServices as { service: { id, name } }}
					<li class="checkable">
						<label>
							<input type="radio" name="service" value={id} />
							<span>{name}</span>
						</label>

						<button type="button" on:click={() => toggleHidden(id)} aria-label="Show">
							<Eye />
						</button>
					</li>
				{/each}
			</ul>

			<button type="button" on:click={resetHidden}> Show all </button>
		</Details>
	{/if}
</fieldset>

<style>
	li {
		display: block;
	}

	.services {
		display: grid;
		gap: 0.5rem;
		grid-template-columns: 1fr 1fr;
		grid-auto-rows: 1fr;
	}

	.services span {
		display: -webkit-box;
		-webkit-box-orient: vertical;
		-webkit-line-clamp: 2;
		overflow: hidden;
	}

	.services li {
		position: relative;
	}

	.services li button {
		position: absolute;
		bottom: 0.15rem;
		right: 0.15rem;
		padding: 0.25rem;
		display: grid;
		opacity: 0;
		user-select: none;
		z-index: 2;
		background: var(--blue-700);
		border-radius: 0.6rem;
		color: #fff;
	}

	.services li svg {
		display: block;
		margin: auto;
	}

	.services li:hover button:hover {
		opacity: 1;
		user-select: auto;
	}

	.checkable:has([value='']:checked) {
		background: radial-gradient(circle at 90% 10%, var(--blue-400), var(--blue-500));
		box-shadow:
			inset 0 0 0 1px var(--blue-600),
			0 0.125rem 0.5rem -0.125rem var(--blue-600);
		color: #fff;
		text-shadow: 0 0 0.25rem var(--blue-600);
	}
</style>
