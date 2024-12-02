<script>
	export let summary = '';
</script>

<details>
	<summary>{summary}</summary>
	<div>
		<slot />
	</div>
</details>

<style>
	details {
		display: contents;
	}

	summary {
		display: block;
		cursor: pointer;
		font-weight: 600;
		background-color: #fff;
		border-radius: 1rem;
		color: var(--blue-300);
		text-align: center;
		padding: 0.125rem 1rem;
		font-size: 0.85rem;
	}

	summary:hover {
		background-color: var(--blue-50);
	}

	summary:active {
		background-color: var(--blue-200);
	}

	:global(* + details summary) {
		margin-top: 2rem;
	}

	div {
		margin-top: 0.5rem;
	}
</style>
