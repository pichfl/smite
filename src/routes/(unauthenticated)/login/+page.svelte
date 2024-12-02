<script>
	import { pseudoEnhance } from '$lib/forms.js';
	import { session } from '$stores';
	import { goto } from '$app/navigation';

	const enhance = pseudoEnhance((data) => {
		const { organisation, token } = data;

		session.set({ organisation, token });

		if (organisation && token) {
			return goto('/');
		}

		return { success: true };
	});
</script>

<h1>Login</h1>

<form method="POST" use:enhance>
	<p>
		<label for="organisation">Organisation</label>
		<input type="text" value="mainmatter" name="organisation" />
	</p>
	<p>
		<label for="token">Token</label>
		<input type="text" value="841b3f859c675bea" name="token" />
	</p>
	<p>
		<button type="submit">Submit</button>
	</p>
</form>
