<script>
	export let data;
</script>

<header>
	<div>
		<h1>Smite</h1>

		<nav>
			<a href="https://{data.account.name}.mite.de">Open Mite</a>
		</nav>

		<p>
			{data.myself.name} ({data.account.title})
			<a href="/logout">Logout</a>
		</p>
	</div>
</header>

<main>
	<slot />
</main>

<style>
	header {
		background: var(--blue-900);
		color: #fff;
	}

	header p {
		margin-left: auto;
	}

	a {
		padding: 0.25rem 0.5rem;
		display: inline-block;
		color: inherit;
		text-decoration: none;
	}

	div,
	main {
		padding: 1rem;
	}

	div {
		display: flex;
		align-items: center;
		margin: 0 auto;
	}

	main {
		margin: 0 auto 3rem;
	}
</style>
