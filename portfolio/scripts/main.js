const select = (q, el = document) => el.querySelector(q);
const selectAll = (q, el = document) => Array.from(el.querySelectorAll(q));

const projectData = [
	{
		title: "Project One",
		description: "A performant web app demonstrating SSR, caching, and accessibility.",
		image: "https://picsum.photos/seed/p1/800/500",
		url: "https://example.com/project-one",
		tags: ["TypeScript", "React", "Node.js"],
	},
	{
		title: "Project Two",
		description: "Design system and component library used across multiple products.",
		image: "https://picsum.photos/seed/p2/800/500",
		url: "https://example.com/project-two",
		tags: ["Design System", "Storybook", "CSS"],
	},
	{
		title: "Project Three",
		description: "Real-time dashboard with websockets and offline-first sync.",
		image: "https://picsum.photos/seed/p3/800/500",
		url: "https://example.com/project-three",
		tags: ["WebSocket", "PWA", "GraphQL"],
	},
];

function renderProjects() {
	const grid = select('#projects-grid');
	if (!grid) return;
	grid.innerHTML = projectData.map(project => {
		const tags = project.tags.map(t => `<span class=\"tag\">${t}</span>`).join('');
		return `
			<article class=\"project-card\">
				<a href=\"${project.url}\" target=\"_blank\" rel=\"noopener\">
					<img class=\"project-media\" src=\"${project.image}\" alt=\"Screenshot of ${project.title}\" loading=\"lazy\" />
				</a>
				<div class=\"project-body\">
					<h3 class=\"project-title\">${project.title}</h3>
					<p class=\"project-desc\">${project.description}</p>
					<div class=\"project-tags\">${tags}</div>
				</div>
			</article>
		`;
	}).join('');
}

function initTheme() {
	const storageKey = 'theme-preference';
	const saved = localStorage.getItem(storageKey);
	const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
	const initial = saved || (prefersDark ? 'dark' : 'light');
	document.documentElement.setAttribute('data-theme', initial);
	const toggle = select('#theme-toggle');
	if (toggle) {
		toggle.textContent = initial === 'dark' ? '☀️' : '🌙';
		toggle.addEventListener('click', () => {
			const current = document.documentElement.getAttribute('data-theme');
			const next = current === 'dark' ? 'light' : 'dark';
			document.documentElement.setAttribute('data-theme', next);
			localStorage.setItem(storageKey, next);
			toggle.textContent = next === 'dark' ? '☀️' : '🌙';
		});
	}
}

function initNav() {
	const toggle = select('.nav-toggle');
	const menu = select('#nav-menu');
	if (toggle && menu) {
		toggle.addEventListener('click', () => {
			const expanded = toggle.getAttribute('aria-expanded') === 'true';
			toggle.setAttribute('aria-expanded', String(!expanded));
			menu.setAttribute('aria-expanded', String(!expanded));
		});
	}
	selectAll('a[href^="#"]').forEach(link => {
		link.addEventListener('click', (e) => {
			const id = link.getAttribute('href');
			if (!id) return;
			const el = select(id);
			if (!el) return;
			e.preventDefault();
			el.scrollIntoView({ behavior: 'smooth', block: 'start' });
			if (menu) menu.setAttribute('aria-expanded', 'false');
		});
	});
}

function initContactForm() {
	const form = select('#contact-form');
	if (!form) return;
	form.addEventListener('submit', async (e) => {
		e.preventDefault();
		const formData = new FormData(form);
		const data = Object.fromEntries(formData.entries());
		try {
			// Optional: integrate with a backend or service like Formspree
			const query = new URLSearchParams(data).toString();
			window.location.href = `mailto:youremail@example.com?subject=Portfolio%20Contact&body=${encodeURIComponent(data.message)}%0A%0AFrom:%20${encodeURIComponent(data.name)}%20<${encodeURIComponent(data.email)}>`;
		} catch (err) {
			alert('Something went wrong. Please email me directly.');
		}
	});
}

function setYear() {
	const year = new Date().getFullYear();
	const yearEl = select('#year');
	if (yearEl) yearEl.textContent = String(year);
}

function main() {
	renderProjects();
	initTheme();
	initNav();
	initContactForm();
	setYear();
}

document.addEventListener('DOMContentLoaded', main);
