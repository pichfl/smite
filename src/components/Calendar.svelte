<script>
	import { createCalendar, melt } from '@melt-ui/svelte';
	import { today, parseDate } from '@internationalized/date';
	import { page } from '$app/stores';
	import ChevronLeft from './icons/chevron-left.svelte';
	import ChevronRight from './icons/chevron-right.svelte';

	const {
		elements: { calendar, heading, grid, cell, prevButton, nextButton },
		states: { months, headingValue, weekdays, value },
		helpers: { isDateDisabled, isDateUnavailable },
		options: { locale },
	} = createCalendar({
		defaultValue: $page.params.date ? parseDate($page.params.date) : today(),
		weekStartsOn: 1,
	});

	export let onSelectDate = () => {};

	locale.set('en-US');

	function selectDate(date) {
		value.set(date);
		onSelectDate(date);
	}
</script>

<div {...$calendar} use:calendar>
	<header>
		<button {...$prevButton} use:prevButton><ChevronLeft /></button>
		<div {...$heading} use:heading>
			{$headingValue}
		</div>
		<button {...$nextButton} use:nextButton><ChevronRight /></button>
	</header>
	<div>
		{#each $months as month}
			<table {...$grid} use:grid>
				<thead aria-hidden="true">
					<tr>
						{#each $weekdays as day}
							<th>
								{day}
							</th>
						{/each}
					</tr>
				</thead>
				<tbody>
					{#each month.weeks as weekDates}
						<tr>
							{#each weekDates as date}
								<td
									role="gridcell"
									aria-disabled={$isDateDisabled(date) || $isDateUnavailable(date)}
								>
									<button
										type="button"
										{...$cell(date, month.value)}
										use:cell
										onclick={() => selectDate(date)}
									>
										{date.day}
									</button>
								</td>
							{/each}
						</tr>
					{/each}
				</tbody>
			</table>
		{/each}
	</div>
</div>

<style>
	[data-melt-calendar] {
		display: flex;
		margin: 0 auto 1rem;
		padding: 1rem;
		background-color: var(--blue-500);
		border-radius: 1rem;
	}

	header {
		display: flex;
	}

	header div {
		color: var(--blue-200);
	}

	header button {
		color: var(--blue-200);
	}

	[data-melt-calendar-prevbutton] {
	}

	[data-melt-calendar-nextbutton] {
	}

	[data-melt-calendar-heading] {
	}

	table {
		display: flex;
	}

	table,
	table * {
		display: flex;
		flex-flow: row nowrap;
		flex: 1 1 100%;
	}

	thead {
		display: none;
	}

	tbody,
	tr,
	td {
		display: contents;
	}

	th {
	}

	th div {
	}

	[data-melt-calendar-grid] {
	}

	[data-melt-calendar-cell] {
	}

	[data-melt-calendar-cell][data-outside-month='true'][data-outside-visible-months='true'] {
	}

	[data-today] {
		background-color: var(--blue-300);
	}

	[aria-selected] {
		background-color: var(--orange-500);
		color: #fff;
	}

	td:nth-child(6),
	td:nth-child(7) {
		opacity: 0.5;
		color: var(--blue-200);
	}

	td button {
		display: block;
		appearance: none;
		border: 0;
		color: inherit;
		padding: 0.25rem;
		line-height: 1;
		min-width: 1.5rem;
		border-radius: 0.75rem;
		font-weight: 700;
		text-align: center;
	}
</style>
