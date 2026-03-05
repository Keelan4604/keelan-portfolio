const root = document.documentElement;
const pref = localStorage.getItem('theme');
if (pref === 'light') root.classList.add('light');

document.getElementById('themeToggle')?.addEventListener('click', () => {
  root.classList.toggle('light');
  localStorage.setItem('theme', root.classList.contains('light') ? 'light' : 'dark');
});

document.getElementById('year').textContent = new Date().getFullYear();

async function loadProjects() {
  try {
    const res = await fetch('./data/projects.json', { cache: 'no-store' });
    const projects = await res.json();
    const grid = document.getElementById('projectGrid');
    const top = projects
      .sort((a,b) => new Date(b.updated) - new Date(a.updated))
      .slice(0, 9);

    grid.innerHTML = top.map(p => `
      <article class="card">
        <h3>${p.name}</h3>
        <p>${p.description || 'Project repository and documentation.'}</p>
        <p class="muted">${p.language || 'Multi-tech'} • Updated ${new Date(p.updated).toLocaleDateString()}</p>
        <a href="${p.url}" target="_blank" rel="noreferrer">Open repository ↗</a>
      </article>
    `).join('');
  } catch (e) {
    document.getElementById('projectGrid').innerHTML = '<p class="muted">Could not load projects right now.</p>';
  }
}

loadProjects();