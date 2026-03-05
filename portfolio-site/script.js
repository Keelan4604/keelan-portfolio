const root = document.documentElement;
const pref = localStorage.getItem('theme');
if (pref === 'light') root.classList.add('light');

document.getElementById('themeToggle')?.addEventListener('click', () => {
  root.classList.toggle('light');
  localStorage.setItem('theme', root.classList.contains('light') ? 'light' : 'dark');
});

document.getElementById('year').textContent = new Date().getFullYear();

function installReveal() {
  const els = document.querySelectorAll('.reveal');
  const io = new IntersectionObserver((entries) => {
    entries.forEach((e) => {
      if (e.isIntersecting) e.target.classList.add('show');
    });
  }, { threshold: 0.12 });
  els.forEach(el => io.observe(el));
}

async function loadProjects() {
  try {
    const res = await fetch('./data/projects.json', { cache: 'no-store' });
    const projects = await res.json();
    const grid = document.getElementById('projectGrid');

    const curated = projects
      .filter(p => p?.name)
      .sort((a, b) => a.name.localeCompare(b.name))
      .slice(0, 9);

    grid.innerHTML = curated.map(p => `
      <article class="card reveal">
        <h3>${p.name}</h3>
        <p>${p.description || 'Project repository and technical documentation.'}</p>
        <p class="muted">${p.language || 'Multi-stack / mixed tooling'}</p>
        <a href="${p.url}" target="_blank" rel="noreferrer">Open Repository ↗</a>
      </article>
    `).join('');

    installReveal();
  } catch (e) {
    document.getElementById('projectGrid').innerHTML = '<p class="muted">Could not load projects right now.</p>';
  }
}

installReveal();
loadProjects();