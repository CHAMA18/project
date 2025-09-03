# Personal Portfolio

Static site built with HTML, CSS, and JavaScript. Includes dark mode, responsive layout, and dynamic projects.

## Develop

Use any static server. Example:

```bash
python3 -m http.server 8080 -d .
```

Then open `http://localhost:8080/portfolio/` if serving from repo root, or `http://localhost:8080/` from inside `portfolio/`.

## Customize

- Update name, bio, links in `index.html` and `scripts/main.js` projectData.
- Replace assets in `assets/` and icons in `icons/`.

## Deploy

Host on any static hosting (GitHub Pages, Netlify, Vercel). Ensure correct base path. Add your production URL to `robots.txt` and `sitemap.xml`.
