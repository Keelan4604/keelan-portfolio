document.getElementById('year').textContent = new Date().getFullYear();

const projectSummaries = {
  'sim7000A-cellular-GSM-connection': 'Arduino-based LTE CAT-M1 communication node for remote control and telemetry logging.',
  'Arduino-Controller-for-Upfitter-Switches': 'Custom microcontroller + relay control architecture for automotive accessory switching.',
  'Nextcloud': 'Self-hosted private cloud stack with secure remote access and managed storage.',
  'Homebridge': 'Smart-home bridge integrations and plugin-based device interoperability.',
  'Home-Assistant': 'Home automation ecosystem with custom controls, integrations, and systems orchestration.',
  'Docker-Setup': 'Containerized service deployment and environment migration for modular infrastructure.',
  'EcoPro-IT-Management': 'IT workflow automation and systems integration for business operations.',
  'Hackintosh-Project': 'System build and configuration work focused on hardware/software compatibility.',
  '2004-AR230': 'Marine restoration and technical documentation project.',
  'Jeep-Mods': 'Vehicle system modifications with practical engineering diagnostics.'
};

function installReveal(){
  const io=new IntersectionObserver((entries)=>entries.forEach(e=>e.isIntersecting&&e.target.classList.add('show')),{threshold:.12});
  document.querySelectorAll('.reveal').forEach(el=>io.observe(el));
}

async function loadProjects(){
  const grid=document.getElementById('projectGrid');
  try{
    const res=await fetch('./data/projects.json',{cache:'no-store'});
    const projects=await res.json();
    const top=projects.filter(p=>p?.name).slice(0,9);
    grid.innerHTML=top.map(p=>`<article class="card reveal"><h3>${p.name}</h3><p>${projectSummaries[p.name] || p.description || 'Technical project repository and implementation notes.'}</p><a href="${p.url}" target="_blank" rel="noreferrer">Open Repository ↗</a></article>`).join('');
    installReveal();
  }catch{
    grid.innerHTML='<p class="muted">Could not load projects right now.</p>';
  }
}

installReveal();
loadProjects();