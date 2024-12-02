import { writable } from "svelte/store";

const parse = (value) => (value ? JSON.parse(value) : undefined);

export function localStorageStore(key, initialValue) {
	if (typeof window === 'undefined') {
		const { subscribe, set, update } = writable(initialValue);
		
		return {
			subscribe,
			set,
			update,
			includes: () => false,
		};
	}
	
	const value = window.localStorage.getItem(key);

	const { subscribe, set, update } = writable(parse(value) ?? initialValue, (s) => {
		const onStorage = (event) => {
			if (event.key !== key) {
				return;
			}

			s(parse(event.newValue));
		};

		window.addEventListener("storage", onStorage);

		return () => {
			window.removeEventListener("storage", onStorage);
		};
	});

	return {
		subscribe,
		set: (value) => {
			localStorage.setItem(key, JSON.stringify(value));
			set(value);
		},
		update: (callback) =>
			update((value) => {
				const newValue = callback(value);
				localStorage.setItem(key, JSON.stringify(newValue));
				return newValue;
			}),
		reset: () => {
			localStorage.removeItem(key);
			set(initialValue);
		},
		includes: (value) => {
			const currentValue = localStorage.getItem(key);
			return parse(currentValue).includes(value);
		},
	};
}
