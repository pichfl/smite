import { CalendarDate } from '@internationalized/date';
import { goto } from '$app/navigation';

export function load() {
	goto(`/${new CalendarDate().toString()}`);
}
