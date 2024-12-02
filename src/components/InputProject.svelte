<script>
	import { localStorageStore } from '$stores/localStorage.js';
	import EyeSlash from './icons/eye-slash.svelte';
	import Eye from './icons/eye.svelte';
	import Details from './Details.svelte';

	export let projects = [];

	let hidden = localStorageStore('hiddenProjects', []);
	let previousProject = localStorageStore('previousProject', '');

	$: projectsByCustomer = Object.entries(
		projects.reduce((acc, { project }) => {
			if (!acc[project.customerName]) {
				acc[project.customerName] = [];
			}
			acc[project.customerName].push(project);
			return acc;
		}, {})
	);

	$: hiddenProjects = projectsByCustomer.filter(([customerName]) => $hidden.includes(customerName));
	$: visibleCustomers = projectsByCustomer.filter(
		([customerName]) => !$hidden.includes(customerName)
	);

	function toggleHidden(id) {
		hidden.update((h) => {
			if (h.includes(id)) {
				return h.filter((h) => h !== id);
			} else {
				return [...h, id];
			}
		});
	}

	function resetHidden() {
		hidden.reset();
	}
</script>

<fieldset>
	<legend class="hidden">Projects</legend>
	<ul class="customers">
		{#each visibleCustomers as [customer, projects]}
			<li class="customer">
				<h3>
					<span>{customer}</span>
					<button type="button" on:click={() => toggleHidden(customer)} aria-label="Hide">
						<EyeSlash />
					</button>
				</h3>
				<ul class="projects">
					{#each projects as { id, name }}
						<li class="project checkable">
							<label>
								<input
									type="radio"
									name="project"
									value={id}
									on:focus={() => ($previousProject = id)}
									checked={$previousProject === id}
								/>
								<span>{name}</span>
							</label>
						</li>
					{/each}
				</ul>
			</li>
		{/each}
	</ul>

	{#if hiddenProjects.length > 0}
		<Details summary="Show hidden">
			<ul class="projects">
				{#each hiddenProjects as [name]}
					<li class="project checkable">
						<span>{name}</span>

						<button type="button" on:click={() => toggleHidden(name)} aria-label="Show">
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

	h3 {
		display: flex;
		font-size: 1rem;
		margin: -0.25rem 0 1rem;
		justify-content: space-between;
		color: var(--blue-800);
	}

	h3 button {
		color: var(--blue-200);
	}

	.customers {
		display: grid;
		gap: 1.5rem;
	}

	.projects {
		display: grid;
		gap: 0.5rem;
		grid-template-columns: 1fr 1fr;
		grid-auto-rows: 3.1rem;
	}

	.projects span {
		display: -webkit-box;
		-webkit-box-orient: vertical;
		-webkit-line-clamp: 2;
		overflow: hidden;
	}

	.project {
		position: relative;
	}

	.project button {
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

	.project svg {
		display: block;
		margin: auto;
	}

	.project:hover button:hover {
		opacity: 1;
		user-select: auto;
	}
</style>
