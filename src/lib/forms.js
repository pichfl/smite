export function pseudoEnhance(onSubmit = () => {}) {
	return (element) => {
		let submitHandler = (event) => {
			event.preventDefault();

			onSubmit(Object.fromEntries(new FormData(event.target).entries()), event);
		};

		element.addEventListener('submit', submitHandler);

		return {
			destroy() {
				element.removeEventListener('submit', submitHandler);
				submitHandler = null;
			},
		};
	};
}
