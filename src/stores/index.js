import { localStorageStore } from '$stores/localStorage.js';

export const session = localStorageStore('session', { organisation: null, token: null });
