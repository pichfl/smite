<script>
	import { localStorageStore } from '$stores/localStorage.js';

	const previousDuration = localStorageStore('previousDuration', '0');

	const durations = {
		'1h': 60,
		'2h': 120,
		'4h': 240,
		'8h': 480,
	};

	function focusCustom() {
		const custom = document.querySelector('input[name="duration-custom"]');
		custom.focus();
	}
</script>

<fieldset>
	<legend class="hidden">Duration</legend>

	{#each Object.entries(durations) as [duration, minutes]}
		<label class="option checkable">
			<input
				type="radio"
				name="duration"
				value={minutes}
				on:input={() => ($previousDuration = minutes)}
				checked={Number($previousDuration) === minutes}
			/>
			<span>{duration}</span>
		</label>
	{/each}
</fieldset>

<style>
	fieldset {
		display: flex;
		flex-flow: row wrap;
		flex: 1 1 100%;
		gap: 0.5rem;
	}

	.option {
		flex: 1 0 auto;
		display: block;
	}

	label.option {
		height: 3.2rem;
	}

	label:has([type='text']) span {
		display: none;
	}
</style>
